import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/servicer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'MusicPages/TrackPage.dart';
import 'Songs.dart';
import 'db/Favourite/helper.dart';


class PageManager extends Track {
  late final _audioPlayer;
  final buttonNotifier = ValueNotifier(ButtonState.paused);
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(current: Duration.zero, total: Duration.zero),
  );

  // PageManager(this._audioPlayer) {
  //   _init();
  // }

  // void init({required SongModel songInfo});
  final OnAudioQuery audioQuery = OnAudioQuery();
  DatabaseHandler? handler;
  dynamic songs;
  int index=1;

  Future<void> loadPlaylist(songs) async {
    songs = songs;
    final playlist = await handler!.retrieveUsers();
    final mediaItems = playlist.map((song) => MediaItem(
      id: '2',
      album: 'Unu',
      title: 'Unaise',
      extras: {'url': songs},
    )).toList();
    _audioPlayer.addQueueItems(mediaItems);
    // play();
  }

  // Future<void> _loadPlaylist() async {
  //   final songRepository = getIt<PlaylistRepository>();
  //   final playlist = await songRepository.addingSongs();
  //   final mediaItems = playlist
  //       .map((song) =>
  //       MediaItem(
  //         id: '2',
  //         album: 'Unu',
  //         title: 'Unaise',
  //         extras: {'url':"https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3"},
  //       ))
  //       .toList();
  //
  //   _audioPlayer.addQueueItems(mediaItems);
  // }


  void _init() async {
    handler = DatabaseHandler();
    await loadPlaylist(songs);
    songs = await audioQuery.querySongs();


    _audioPlayer.playbackState.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.pause();
        _audioPlayer.seek(Duration.zero);
      }
    });

    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        total: oldState.total,
      );
    });

    _audioPlayer.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        total: mediaItem?.duration ?? Duration.zero,);
    });
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void next() {
    _audioPlayer.skipToNext();
  }

  void previous() {
    _audioPlayer.skipToPrevious();
  }
}

class ProgressBarState {
  final Duration current;
  final Duration total;

  ProgressBarState({required this.current, required this.total});
}

enum ButtonState { paused, playing }


// class MusicPlayerScreen extends StatefulWidget {
//   SongModel songInfo;
//
//   MusicPlayerScreen({Key?key, required this.songInfo})
//       : super(key: key);
//
//   MusicPlayerScreenState createState() => MusicPlayerScreenState();
// }
//
// class MusicPlayerScreenState extends State<MusicPlayerScreen> {
//   bool isPlaying = false;
//   final AudioPlayer player = AudioPlayer();
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setSong(widget.songInfo);
//   }
//
//   void dispose() {
//     super.dispose();
//     player.dispose();
//   }
//
//   void setSong(SongModel songInfo) async {
//     widget.songInfo = songInfo;
//     await player.setUrl(widget.songInfo.data);
//     isPlaying = false;
//     changeStatus();
//   }
//
//   void changeStatus() {
//     setState(() {
//       isPlaying = !isPlaying;
//     });
//     if (isPlaying) {
//       player.play();
//     } else {
//       player.pause();
//     }
//   }
//
//   @override
//   Widget build(context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: Center(
//         child: GestureDetector(
//           child: Icon(
//             isPlaying
//                 ? Icons.pause_circle_outline_sharp
//                 : Icons.play_circle_outline_sharp,
//             color: Colors.white,
//             size: 100,
//           ),
//           behavior: HitTestBehavior.translucent,
//           onTap: () {
//             changeStatus();
//           },
//         ),
//       ),
//     );
//   }
// }
