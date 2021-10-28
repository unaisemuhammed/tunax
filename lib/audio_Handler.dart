// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
//
//
// MediaItem mediaItem = MediaItem(
//     id: songList[0].url,
//     title: songList[0].name,
//     artUri: Uri.parse(songList[0].icon),
//     album: songList[0].album,
//     duration: songList[0].duration,
//     artist: songList[0].artist);
//
// Future<AudioHandler> initAudioService() async {
//   return await AudioService.init(
//     builder: () => MyAudioHandler(),
//     config: AudioServiceConfig(
//       androidNotificationChannelId: 'com.mycompany.myapp.audio',
//       androidNotificationChannelName: 'Audio Service Demo',
//       androidNotificationOngoing: true,
//       androidStopForegroundOnPause: true,
//     ),
//   );
// }
// class MyAudioHandler extends BaseAudioHandler {
//   // TODO: Override needed methods
//   final _player = AudioPlayer();
//   final _playlist = ConcatenatingAudioSource(children: []);
//   MyAudioHandler() {
//     _notifyAudioHandlerAboutPlaybackEvents();
//   }
//
//
//
//
//
//
//   void _notifyAudioHandlerAboutPlaybackEvents() {
//     _player.playbackEventStream.listen((PlaybackEvent event) {
//       final playing = _player.playing;
//       playbackState.add(playbackState.value.copyWith(
//         controls: [
//           MediaControl.skipToPrevious,
//           if (playing) MediaControl.pause else MediaControl.play,
//           MediaControl.skipToNext,
//         ],
//         systemActions: const {
//           MediaAction.seek,
//         },
//         androidCompactActionIndices: const [0, 1],
//         processingState: const {
//           ProcessingState.idle: AudioProcessingState.idle,
//           ProcessingState.ready: AudioProcessingState.ready,
//           ProcessingState.completed: AudioProcessingState.completed,
//         }[_player.processingState]!,
//         repeatMode: const {
//           LoopMode.off: AudioServiceRepeatMode.none,
//           LoopMode.one: AudioServiceRepeatMode.one,
//           LoopMode.all: AudioServiceRepeatMode.all,
//         }[_player.loopMode]!,
//         shuffleMode: (_player.shuffleModeEnabled)
//             ? AudioServiceShuffleMode.all
//             : AudioServiceShuffleMode.none,
//         playing: playing,
//         updatePosition: _player.position,
//         bufferedPosition: _player.bufferedPosition,
//         speed: _player.speed,
//         queueIndex: event.currentIndex,
//       ));
//     });
//   }
//
//   @override
//   Future<void> onStop() async {
//     AudioServiceBackground.setState(
//         controls: [],
//         playing: false,
//         processingState: AudioProcessingState.ready);
//     await _player.stop();
//     await super.stop();
//   }
//
//   @override
//   Future<void> onPlay() async {
//     AudioServiceBackground.setState(controls: [
//       MediaControl.pause,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seek
//     ], playing: true, processingState: AudioProcessingState.ready);
//     await _player.play();
//     return super.play();
//   }
//
//   @override
//   Future<void> onPause() async {
//     AudioServiceBackground.setState(controls: [
//       MediaControl.play,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seek
//     ], playing: false, processingState: AudioProcessingState.ready);
//     await _player.pause();
//     return super.pause();
//   }
//
//   @override
//   Future<void> onSkipToNext() async {
//     if (current < songList.length - 1)
//       current = current + 1;
//     else
//       current = 0;
//     mediaItem = MediaItem(
//         id: songList[current].url,
//         title: songList[current].name,
//         artUri: Uri.parse(songList[current].icon),
//         album: songList[current].album,
//         duration: songList[current].duration,
//         artist: songList[current].artist);
//     AudioServiceBackground.setMediaItem(mediaItem);
//     await _player.setUrl(mediaItem.id);
//     AudioServiceBackground.setState(position: Duration.zero);
//     return super.onSkipToNext();
//   }
//
//   @override
//   Future<void> onSkipToPrevious() async {
//     if (current != 0)
//       current = current - 1;
//     else
//       current = songList.length - 1;
//     mediaItem = MediaItem(
//         id: songList[current].url,
//         title: songList[current].name,
//         artUri: Uri.parse(songList[current].icon),
//         album: songList[current].album,
//         duration: songList[current].duration,
//         artist: songList[current].artist);
//     AudioServiceBackground.setMediaItem(mediaItem);
//     await _player.setUrl(mediaItem.id);
//     AudioServiceBackground.setState(position: Duration.zero);
//     return super.onSkipToPrevious();
//   }
//
//   @override
//   Future<void> onSeekTo(Duration position) {
//     _player.seek(position);
//     AudioServiceBackground.setState(position: position);
//     return super.seek(position);
//   }
//
//
//
// }