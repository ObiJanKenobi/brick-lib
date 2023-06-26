import 'package:logger/logger.dart';
import 'dart:io' as io;

Logger getLogger(String className) {
  return Logger(printer: PrettyPrinter(printTime: true));
}
