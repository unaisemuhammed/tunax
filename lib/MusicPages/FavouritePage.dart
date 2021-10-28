import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/MusicPages/BottomBar.dart';
import 'package:musicplayer/colors.dart' as AppColors;
import 'package:musicplayer/db/Favourite/db_helper.dart';
import 'package:musicplayer/db/Favourite/helper.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../PageManager.dart';
import 'Cnplaylist.dart';
import 'MusicControllPage.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<Favourite> {
  dynamic Track = [];
  dynamic Tracks = [];
  final GlobalKey<MusicControllsState> key = GlobalKey<MusicControllsState>();
  final OnAudioQuery audioQuery = OnAudioQuery();
  late final AudioPlayer player;
  int currentIndex = 0;
  int isFav = 0;
  dynamic songTitle;
  dynamic songId;
  dynamic songLocation;
  int favourite = 0;
  late DatabaseHandler handler;
  late PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    getTracks();
    _pageManager = PageManager();
    handler = DatabaseHandler();
    player = AudioPlayer();
  }

  void getTracks() async {
    Tracks = await this.handler.retrieveUsers();
    setState(() {
      Tracks = Tracks;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != Tracks.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState!.setSong(Tracks[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final double Heights = MediaQuery.of(context).size.height;
    final double Weights = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.shade,
        body: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: FutureBuilder(
            future: this.handler.retrieveUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // player.setUrl(snapshot.data![index].location);
                            // player.play();
                              Track = snapshot.data![index].location;
                              currentIndex = index;
                            dynamic TracksTitle = snapshot.data![index].name;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MusicControlls(
                                      changeTrack: changeTrack,
                                      songInfo: Track,
                                      songTitle: TracksTitle,
                                      key: key,
                                    )));
                          },
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
                            id: snapshot.data![index].num,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.contain,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              await this
                                  .handler
                                  .deleteUser(snapshot.data![index].id!);
                              setState(() {
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                          ),
                          title: Text(
                            snapshot.data![index].name,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            "ariana Grande",
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
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
