import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

createDatabase(roomName) async {
  final databaseFolder = await getDatabasesPath();
  return openDatabase(
    join(databaseFolder, '${roomName}_chat_database.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE messages (id INTEGER PRIMARY KEY, message TEXT, timestamp INTEGER)',
      );
    },
    version: 1,
  );
}

insertMessage(data) async {
  final database = await createDatabase(data['room']);
  await database.insert(
    'messages',
    {
      'message': data['message'],
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

loadMessages(String room) async {
    final database = await createDatabase(room);
    return await database.query('messages');
  }
