import 'package:musicplayer/colors.dart' as AppColors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'db_helperPla.dart';
import 'helperPlay.dart';

class SelectTrack extends StatefulWidget {
  dynamic playlistid;
  SelectTrack({Key? key, required this.playlistid}) : super(key: key);

  @override
  SelectTrackState createState() => SelectTrackState();
}

class SelectTrackState extends State<SelectTrack> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  dynamic songID;
  dynamic playlistID;
  dynamic songName;
  dynamic path;
  List<SongModel> Tracks = [];

  late PlaylistDatabaseHandler songAddHandler;

  void initState() {
    super.initState();
    getTracks();
    songAddHandler = PlaylistDatabaseHandler();
    // requestPermission();
    addUsers(songID, playlistID, songName, path);
  }

  Future<int> addUsers(songTitle, playlistID, songName, path) async {
    PlayListSong firstUser = PlayListSong(
        songID: songID, playlistID: playlistID, songName: songName, path: path);
    List<PlayListSong> listOfUsers = [firstUser];
    // playlistID = playlistHandler!.insertPlaylist(listOfUsers);
    debugPrint("SELECTIONSONG:::::$songID,$playlistID,$songName,$path");
    return await songAddHandler.insertSongs(listOfUsers);
  }

  // requestPermission() async {
  //   // Web platform don't support permissions methods.
  //   if (!kIsWeb) {
  //     bool permissionStatus = await audioQuery.permissionsStatus();
  //     if (!permissionStatus) {
  //       await audioQuery.permissionsRequest();
  //     }
  //     setState(() {});
  //   }
  // }

  void getTracks() async {
    Tracks = await audioQuery.querySongs();
    setState(() {
      Tracks = Tracks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double Heights = MediaQuery.of(context).size.height;
    final double Weights = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.back,
        title: Text(
          "Add song to playlist",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.shade,
      body: Container(
        padding: EdgeInsets.only(bottom: 60, top: 5),
        color: Colors.transparent,
        child: ListView.builder(
            itemCount: Tracks.length,
            itemBuilder: (BuildContext context, int index) {
              if (Tracks[index].data.contains("mp3"))
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(8),
                        nullArtworkWidget: Container(
                            width: Weights / 8,
                            height: Heights / 14,
                            decoration: BoxDecoration(
                                color: AppColors.back,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.music_note_outlined,
                              color: Colors.grey,
                              size: 45,
                            )),
                        id: Tracks[index].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.contain,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            songID = Tracks[index].id;
                            playlistID = widget.playlistid+1;
                            songName = Tracks[index].title;
                            path = Tracks[index].data;
                            addUsers(songID, playlistID, songName, path);
                          });
                        },
                      ),
                      title: Text(
                        Tracks[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        Tracks[index].displayNameWOExt,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Divider(
                      height: 0,
                      indent: 85,
                      color: Colors.grey,
                    ),
                  ],
                );
              return Container(
                height: 0,
              );
            }),
      ),
    );
  }
}
