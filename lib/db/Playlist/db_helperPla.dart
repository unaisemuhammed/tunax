// class Playlist {
//   int? id;
//   String playListName;
//   int playlist_id;
//   String songName;
//   int songId;
//   String location;
//
//   Playlist(
//       {this.id,
//       required this.playListName,
//       required this.playlist_id,
//       required this.songName,
//       required this.songId,
//       required this.location});
//
//   Playlist.fromMap(Map<String, dynamic> res)
//       : id = res['id'],
//         playListName = res['playListName'],
//         playlist_id = res['playlist_id'],
//         songName = res['songName'],
//         songId = res['songId'],
//         location = res['location'];
//
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'playListName': playListName,
//       'playlist_id': playlist_id,
//       'songName': songName,
//       'songId': songId,
//       'location': location
//     };
//   }
// }

class PlaylistModel {
  int? id;
  String playListName;

  List<PlayListSong> playListSongs = [];

  //TABLE COLUMNS
  static String tableName = 'playlist';
  static String col_id = "id";
  static String col_playListName = "playlistName";

  PlaylistModel({
    this.id,
    required this.playListName,
  });

  PlaylistModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        playListName = res['playListName'];

  Map<String, dynamic> toMapForDB() {
    return {
      col_id: id,
      col_playListName: playListName,
    };
  }

  setSongsInPlaylist(List<PlayListSong> songsList) {
    playListSongs.clear();
    playListSongs.addAll(songsList);
  }
}

class PlayListSong {
  int? id;
  int songID;
  int playlistID;
  String songName;
  String path;

  static String Id = 'id';
  static String songId = 'songID';
  static String playlistsID = "playlistID";
  static String songsName = "songName";
  static String songPath = "path";

  PlayListSong(
      {this.id,
      required this.songID,
      required this.playlistID,
      required this.songName,
      required this.path});

  PlayListSong.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        songID = res['songID'],
        playlistID = res['playlistID'],
        songName = res['songName'],
        path = res['path'];

  Map<String, dynamic> toMapForDB() {
    return {
      Id: id,
      songId: songID,
      playlistsID: playlistID,
      songsName: songName,
      songPath: path,
    };
  }

//add variables methods similar to the above class
}
