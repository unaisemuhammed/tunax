import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/colors.dart' as AppColors;
import 'package:musicplayer/db/Favourite/db_helper.dart';
import 'package:musicplayer/db/Favourite/helper.dart';
import 'package:musicplayer/db/Playlist/SelectPlaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
class MusicControll extends StatefulWidget {
  SongModel songInfo;
  MusicControll(
      {required this.songInfo, required this.changeTrack, required this.key,})
      : super(key: key);
  Function changeTrack;
  final GlobalKey<MusicControllState> key;

  @override
  MusicControllState createState() => MusicControllState();
}

class MusicControllState extends State<MusicControll> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  final AudioPlayer player = AudioPlayer();
  dynamic songTitle;
  dynamic songId;
  dynamic songLocation;
  DatabaseHandler? handler;
  int repeat = 0;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    handler = DatabaseHandler();
    addUsers(songTitle, songId, songLocation);
    setSong(widget.songInfo);
  }

  void dispose() {
    super.dispose();
    player.dispose();
  }

  Future<int> addUsers(songTitle, songId, songLocation) async {
    User firstUser = User(name: songTitle, num: songId, location: songLocation);
    List<User> listOfUsers = [firstUser];
    debugPrint("ADNAN:$songTitle");
    debugPrint("ADNAN: $songId");
    debugPrint("ADNAN: $songLocation");
    return await handler!.insertUser(listOfUsers);
  }

  void setSong(SongModel songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.data);
    currentValue = minimumValue;
    maximumValue = player.duration!.inMilliseconds.toDouble();
    if (currentValue == maximumValue) {
      widget.changeTrack(true);
    }
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);
    });
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentValue);
        if (currentValue == maximumValue) {
          widget.changeTrack(true);
        }
      });
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  void nextSong() {
    setState(() {
      if (currentValue >= maximumValue) {
        widget.changeTrack(true);
      }
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(context) {
    final double Height = MediaQuery.of(context).size.height;
    final double Width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "TUNE " "Ax",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Gemunu',
                  fontWeight: FontWeight.bold),
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.back,
          leading: IconButton(
            padding: EdgeInsets.only(top: 5, left: 10),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 40,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.back,
                Colors.black,
              ])),
          child: Stack(
            children: [
              ///Play $ Pause///
              ///Play $ Pause///
              Positioned(
                top: Height - 170,
                child: Container(
                  width: Width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(
                      //     iconSize: 25,
                      //     color: Colors.white,
                      //     onPressed: () {},
                      //     icon: Icon(Icons.shuffle)),
                      GestureDetector(
                        child: Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 35,
                        ),
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          widget.changeTrack(false);
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          changeStatus();
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 35,
                        ),
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          widget.changeTrack(true);
                        },
                      ),
                      // IconButton(
                      //   iconSize: 25,
                      //   color: Colors.white,
                      //   onPressed: () async {
                      //     setState(() {
                      //       if(repeat==0){
                      //         repeat=1;
                      //       }else
                      //         {
                      //           repeat=0;
                      //         }
                      //     });
                      //     if(repeat==1){
                      //       player.setLoopMode(LoopMode.one);
                      //     }else{
                      //       player.setLoopMode(LoopMode.off);
                      //     }
                      //   },
                      //
                      //   icon: repeat == 0
                      //       ? Icon(Icons.repeat)
                      //       : Icon(Icons.repeat_one),
                      // ),
                    ],
                  ),
                ),
              ),

              ///Slider///
              ///Slider///
              ///Slider///
              ///Slider///
              ///
// Positioned(
//   right: 20,
//   left: 20,
//   top: Height - 242,
//   child: ProgressBar(
//     progress: player.position,
//     total: widget.songInfo.duration.toDouble(),
//     onSeek: (value) {
//       currentValue = value as double;
//       player.seek(Duration(milliseconds: currentValue.round()));
//     },
//     baseBarColor: Colors.grey,
//     progressBarColor: Colors.white,
//     thumbColor: Colors.white,
//     barHeight: 3,
//     timeLabelTextStyle: TextStyle(
//         color: Colors.white,
//         fontSize: 13,
//         height: 1.5,
//         fontFamily: "Gemunu"),
//   ),
// ),
              Positioned(
                right: 0,
                left: 0,
                top: Height - 250,
                child: Slider(
                    inactiveColor: Colors.grey,
                    activeColor: Colors.white,
                    min: minimumValue,
                    max: maximumValue,
                    value: currentValue,
                    onChanged: (value) {
                      currentValue = value;
                      player.seek(Duration(milliseconds: currentValue.round()));
                    }),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: Height - 210,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      currentTime,
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Gemunu'),
                    ),
                    SizedBox(
                      width: 250,
                    ),
                    Text(
                      endTime,
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Gemunu'),
                    )
                  ],
                ),
              ),

              ///Favourite Container///
              ///Favourite Container///
              ///Favourite Container///
              Positioned(
                top: Height - 320,
                child: Container(
                  width: Width,
// color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        icon: Icon(Icons.volume_up),
                        onPressed: () {
                          showSliderDialog(
                            context: context,
                            title: "Adjust volume",
                            divisions: 10,
                            min: 0.0,
                            max: 1.0,
                            value: player.volume,
                            stream: player.volumeStream,
                            onChanged: player.setVolume,
                          );
                        },
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        iconSize: 25,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            songTitle = widget.songInfo.title;
                            songId = widget.songInfo.id;
                            songLocation = widget.songInfo.data;
                            addUsers(songTitle, songId, songLocation);
                          });
                        },
                        icon: Icon(Icons.favorite_border),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateOrSelect(),
                              ));
                        },
                        icon: Icon(Icons.add_outlined),
                      ),
                    ],
                  ),
                ),
              ),

              ///subtitle///
              ///subtitle///
              ///subtitle///
              Positioned(
                right: 5,
                left: 5,
                top: Height /3,
                child: Container(
                  child: Center(
                    child: Text(
                      widget.songInfo.artist.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: "Titil"),
                    ),
                  ),
                  height: 100,
                  width: Width,
                ),
              ),

              ///Song Title///
              ///Song Title///
              ///Song Title///
              Positioned(
                right: 20,
                left: 20,
                top: Height/3,
                child: Container(
                  height: 25,
                  child: Center(
                    child: Marquee(
                      blankSpace: 100,
                      text: widget.songInfo.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Titil",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              ///Icon $ Images///
              ///Icon $ Images///
              ///Icon $ Images///
              Positioned(
                right: 100,
                left: 100,
                top: Height / 25,
                child: CircleAvatar(
                  radius: 105,
                  backgroundColor: AppColors.shade,
                  child: Icon(
                    Icons.music_note_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
// child: ClipOval(
//   child: Image.asset(
//     "Assets/Selena-Gomez-640x514.jpg",
//     fit: BoxFit.cover,
//     height: Height,
//     width: Width,
//   ),
// ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.back,
      title: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Gemunu',
              fontWeight: FontWeight.bold,
              fontSize: 24.0)),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gemunu',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                inactiveColor: Colors.grey,
                activeColor: Colors.white,
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
