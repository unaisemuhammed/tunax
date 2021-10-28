import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helperPla.dart';

class PlaylistDatabaseHandler {

  final List<Map<String, Object?>> queryResults=[];
  Future<Database> initializeDB() async {
    String dbpath = await getDatabasesPath();
    return openDatabase(
      join(dbpath, "playTrackerDb.db"),
      version: 1,
      onCreate: (
        database,
        version,
      ) async {
        print("Creating playlists");
        await database.execute(
          "CREATE TABLE playlist(id INTEGER PRIMARY KEY AUTOINCREMENT,playListName TEXT NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE songs(id INTEGER PRIMARY KEY AUTOINCREMENT,songID INTEGER,playlistID INTEGER NOT NULL,songName TEXT NOT NULL,path TEXT NOT NULL)",
        );
      },
    );
  }

  Future<int> insertPlaylist(List<PlaylistModel> playlist) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var element in playlist) {
      result = await db.insert('playlist', element.toMapForDB());
      print('RSULTFROMINSERTPLAYLIST:$result');
    }
    return result;
  }

  Future<int> insertSongs(List<PlayListSong> songs) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var song in songs) {
      result = await db.insert('songs',song.toMapForDB());
      print('RESULTFROMINSERTSONGS:$result');
    }
    return result;
  }

  Future<List<PlaylistModel>> retrievePlaylist() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('playlist');
    debugPrint("QUERYPLAYLISTMETHOD: $queryResult");
    return queryResult.map((e) => PlaylistModel.fromMap(e)).toList();
  }

  Future<List<PlayListSong>> retrieveSongs() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('songs');
    debugPrint("QUERYSONGSMETHOD: $queryResult");
      return queryResult.map((e) => PlayListSong.fromMap(e)).toList();

  }

  Future<List<PlayListSong>> retrieveSingleSong(playlistFolderId) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('songs',where: 'playlistID =="$playlistFolderId"');
    debugPrint("QUERYSINGLESONGSMETHOD: $queryResult");
    return queryResult.map((e) => PlayListSong.fromMap(e)).toList();

  }


  Future<void> deletePlaylist(int id) async {
    final db = await initializeDB();
    await db.delete(
      'playlist',
      where: "id = ?",
      whereArgs: [id],
    );
    debugPrint("DELETED::");
  }

  Future<void> deleteSongs(int id) async {
    final db = await initializeDB();
    await db.delete(
      'songs',
      where: "id = ?",
      whereArgs: [id],
    );
    debugPrint("DELETED::");
  }
}


