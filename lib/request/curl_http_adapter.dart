import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A Dio [HttpClientAdapter] that performs requests by shelling out to the
/// `curl.exe` bundled with Windows (10 v1803+ / 11).
///
/// Why: Rebrickable sits behind Cloudflare bot protection that blocks the
/// `dart:io` TLS fingerprint (HTTP 403 / cf-1010 "banned browser"). On Apple
/// and Android the app dodges this by routing through the OS-native HTTP stack
/// (NSURLSession / Cronet) via `native_dio_adapter`, whose fingerprint is
/// accepted — but that package has no Windows backend and falls back to
/// `dart:io`, so Windows stays blocked.
///
/// `curl.exe` on Windows uses **Schannel**, the OS-native TLS stack, so this is
/// the direct Windows counterpart to the Apple/Android fix: same idea (native
/// TLS), different transport (a subprocess rather than an FFI plugin).
///
/// Only intended for use on Windows; other platforms should keep using
/// `NativeAdapter`.
class CurlHttpAdapter implements HttpClientAdapter {
  CurlHttpAdapter({this.curlPath = 'curl'});

  /// Executable to invoke. Defaults to `curl`, resolved via PATH (which on
  /// Windows includes System32, where curl.exe lives).
  final String curlPath;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    // Collect the request body (POST/DELETE) if present.
    Uint8List? body;
    if (requestStream != null) {
      body = await _collect(requestStream);
      if (body.isEmpty) body = null;
    }

    final tmp = await Directory.systemTemp.createTemp('rb_curl_');
    final headerFile = File('${tmp.path}${Platform.pathSeparator}headers.txt');

    try {
      final args = <String>[
        '--silent',
        '--show-error',
        '--dump-header', headerFile.path,
        '-X', options.method,
      ];

      // Forward request headers. Skip the ones curl computes itself; a stale
      // content-length or an Accept-Encoding we can't honour would corrupt the
      // exchange.
      var hasContentType = false;
      options.headers.forEach((key, value) {
        final lower = key.toLowerCase();
        if (lower == 'content-length' || lower == 'accept-encoding') return;
        if (lower == 'content-type') hasContentType = true;
        args
          ..add('-H')
          ..add('$key: $value');
      });

      if (body != null) {
        if (!hasContentType && options.contentType != null) {
          args
            ..add('-H')
            ..add('content-type: ${options.contentType}');
        }
        final bodyFile = File('${tmp.path}${Platform.pathSeparator}body.bin');
        await bodyFile.writeAsBytes(body);
        // '@file' streams the exact bytes; keeps secrets (e.g. the login
        // password) out of the process argument list.
        args
          ..add('--data-binary')
          ..add('@${bodyFile.path}');
      }

      final timeout = options.receiveTimeout ?? options.connectTimeout;
      if (timeout != null && timeout.inSeconds >= 1) {
        args
          ..add('--max-time')
          ..add(timeout.inSeconds.toString());
      }

      // The resolved URI already includes query parameters merged by Dio.
      args.add(options.uri.toString());

      final result = await Process.run(
        curlPath,
        args,
        stdoutEncoding: null,
        stderrEncoding: null,
      );

      if (result.exitCode != 0) {
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'curl exited ${result.exitCode}: ${_text(result.stderr)}',
        );
      }

      final bodyBytes = _bytes(result.stdout);
      final headerText =
          await headerFile.exists() ? await headerFile.readAsString() : '';
      final parsed = _parseHeaders(headerText);

      return ResponseBody(
        Stream<Uint8List>.value(Uint8List.fromList(bodyBytes)),
        parsed.statusCode,
        statusMessage: parsed.statusMessage,
        headers: parsed.headers,
      );
    } on ProcessException catch (e) {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: 'curl.exe not found (needs Windows 10 v1803+): ${e.message}',
      );
    } finally {
      try {
        await tmp.delete(recursive: true);
      } catch (_) {}
    }
  }

  @override
  void close({bool force = false}) {}

  Future<Uint8List> _collect(Stream<Uint8List> stream) async {
    final chunks = <int>[];
    await for (final chunk in stream) {
      chunks.addAll(chunk);
    }
    return Uint8List.fromList(chunks);
  }

  List<int> _bytes(Object? stdout) {
    if (stdout is List<int>) return stdout;
    if (stdout is String) return utf8.encode(stdout);
    return const [];
  }

  String _text(Object? stderr) {
    if (stderr is List<int>) return utf8.decode(stderr, allowMalformed: true);
    return stderr?.toString() ?? '';
  }

  _ParsedHeaders _parseHeaders(String dump) {
    // With redirects, curl writes one header block per hop; the final response
    // is the last block.
    final blocks = dump
        .split(RegExp(r'\r?\n\r?\n'))
        .where((b) => b.trim().isNotEmpty)
        .toList();
    if (blocks.isEmpty) return const _ParsedHeaders(0, '', {});

    final lines = const LineSplitter().convert(blocks.last);
    if (lines.isEmpty) return const _ParsedHeaders(0, '', {});

    var statusCode = 0;
    var statusMessage = '';
    final statusMatch =
        RegExp(r'^HTTP/\S+\s+(\d{3})\s*(.*)$').firstMatch(lines.first);
    if (statusMatch != null) {
      statusCode = int.tryParse(statusMatch.group(1)!) ?? 0;
      statusMessage = statusMatch.group(2)?.trim() ?? '';
    }

    final headers = <String, List<String>>{};
    for (final line in lines.skip(1)) {
      final idx = line.indexOf(':');
      if (idx <= 0) continue;
      final key = line.substring(0, idx).trim().toLowerCase();
      // curl already decoded and reframed the body in memory; forwarding the
      // original framing headers would only confuse Dio.
      if (key == 'content-encoding' || key == 'content-length') continue;
      headers.putIfAbsent(key, () => []).add(line.substring(idx + 1).trim());
    }
    return _ParsedHeaders(statusCode, statusMessage, headers);
  }
}

class _ParsedHeaders {
  const _ParsedHeaders(this.statusCode, this.statusMessage, this.headers);
  final int statusCode;
  final String statusMessage;
  final Map<String, List<String>> headers;
}
