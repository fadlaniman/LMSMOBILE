import 'dart:async';

import 'package:mysql1/mysql1.dart';

Future connection() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2', port: 3306, user: 'root', db: 'lms'));
  // Finally, close the connection

  await conn.close();
}
