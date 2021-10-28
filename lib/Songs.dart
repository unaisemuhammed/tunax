abstract class PlaylistRepository {
  Future<List<Map<String, String>>> addingSongs();
}

class DemoPlaylist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> addingSongs(
      {int length = 3}) async {
    return List.generate(length, (index) => _nextSong());
  }

  var _songIndex = 0;
  static const _maxSongNumber = 16;

  Map<String, String> _nextSong() {
    return {
      'id': '1',
      'title': 'The Heart',
      'album': 'SelenaGomez',
      'url':
      'https://www..com/examples/mp3/SoundHelix-Song-1.mp3',
    };
  }
}
