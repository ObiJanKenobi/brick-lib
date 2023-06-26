import 'package:intl/intl.dart';

enum DebugType {
  /// Base
  Info,
  Log,
  Warning,
  Critical,
  Fatal,

  /// App
  Widget,
  Memory,
  Request,
  RequestResponse,
  WebView,
  User,
}

extension MyEnumExtension on DebugType {
  String get symbol => {
        DebugType.Info: "🟩",
        DebugType.Log: "✅",
        DebugType.Warning: "🟨",
        DebugType.Critical: "🟥",
        DebugType.Fatal: "📛",
        DebugType.Widget: "🔳",
        DebugType.Memory: "🔘",
        DebugType.Request: "🟣",
        DebugType.RequestResponse: "🟣",
        DebugType.User: "🚻",
      }[this]!;
}

class Debug {
  Debug._(); //nonVirtual
  static final Debug instance = Debug._();

  static bool get debugEnabled => Debug.instance._debugEnabled;

  static set debugEnabled(value) {
    Debug.instance._debugEnabled = value;
  }

  static void setLoggingEnabledByType(DebugType type, bool enabled) {
    Debug.instance._logTypesEnabled[type] = enabled;
    // Debug.instance._save();
  }

  static bool loggingEnabledByType(DebugType type) => Debug.instance._logTypesEnabled[type] ?? false;

  static void info(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Info, force);

  static void log(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Log, force);

  static void warn(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Warning, force);

  static void critical(String msg) {
    Debug.instance._maybeWrite(msg, DebugType.Critical, true);
  }

  static void fatal(String msg) {
    print("FATAL !! $msg");
    // exit(1);
  }

  static void widget(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Widget, force);

  static void memory(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Memory, force);

  static void request(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.Request, force);

  static void requestResponse(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.RequestResponse, force);

  static void webView(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.WebView, force);

  static void user(String msg, {bool force = false}) => Debug.instance._maybeWrite(msg, DebugType.User, force);

  void init() {
    // try {
    //   loadFromFile();
    // } catch (_) {
    //   // debug.json file does not exist on first app start; Save with default values
    //   _save();
    // }
  }

  /// We don't use kDebugMode directly.
  /// We want to be able to override debugEnabled during runtime, even in release apps.
  bool _debugEnabled = true; //;
  Map<DebugType, bool> _logTypesEnabled = {for (var type in DebugType.values) type: false};
  final NumberFormat _secondFormat = NumberFormat("00");
  final NumberFormat _millisecondFormat = NumberFormat("000");

  void _maybeWrite(String msg, DebugType type, bool force) {
    if (force || loggingEnabledByType(type)) {
      _write(msg, type, force);
    }
  }

  void _write(String msg, DebugType type, bool wasForced) {
    final DateTime now = DateTime.now();
    final String name =
        '${now.hour}:${now.minute}:${_secondFormat.format(now.second)}:${_millisecondFormat.format(now.millisecond)}] ${type.symbol} [${_getFunctionNameFromTrace(StackTrace.current).toString()}]';
    print(
        "$name ${wasForced ? "!!" : "-"} $msg"); // We use print now instead of debugPrint because debugPrint prints output asynchronously, making it difficult to read the logs in the correct order.
  }

  String _getFunctionNameFromTrace(StackTrace trace) {
    final frames = trace.toString().split('\n');

    final traceString = frames[3];
    final indexOfWhiteSpace = traceString.indexOf(' ');
    final subStr = traceString.substring(indexOfWhiteSpace);
    final indexOfFunction = subStr.indexOf(RegExp('[A-Za-z0-9]'));

    return subStr.substring(indexOfFunction).substring(0, subStr.substring(indexOfFunction).indexOf(' '));
  }

  Map<String, dynamic> toJson() {
    Map<String, bool> logsEnabledJson = {};
    for (var i in _logTypesEnabled.keys) {
      logsEnabledJson[i.name] = _logTypesEnabled[i]!;
    }
    return logsEnabledJson;
  }
}
