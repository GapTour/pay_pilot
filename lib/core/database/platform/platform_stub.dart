import 'dart:io';

import 'package:drift/drift.dart';

class PlatformInterface {
  static QueryExecutor createDatabaseConnection(String databaseName) =>
      throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io',
      );

  static Future<File> databaseFile(String databaseName) =>
      throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io',
      );
}
