import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.none,
  ),
  level: kReleaseMode ? Level.off : Level.debug,
);
