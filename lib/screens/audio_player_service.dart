import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'all_song_screen.dart';

class AudioPlayerService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  List<Music> _playlist = [];
  int _currentIndex = 0;
  bool _isRepeat = false;
  bool _isShuffle = false;

  AudioPlayer get player => _player;
  List<Music> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _player.playing;
  bool get isRepeat => _isRepeat;
  bool get isShuffle => _isShuffle;
  Music? get currentSong =>
      _playlist.isNotEmpty ? _playlist[_currentIndex] : null;

  AudioPlayerService() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (_isRepeat) {
          _player.seek(Duration.zero);
          _player.play();
        } else {
          next();
        }
      }
      notifyListeners();
    });
  }

  Future<void> playPlaylist(List<Music> songs, int index) async {
    _playlist = songs;
    _currentIndex = index;
    await _loadAndPlay();
  }

  Future<void> _loadAndPlay() async {
    if (_playlist.isEmpty) return;
    await _player.setUrl(_playlist[_currentIndex].url);
    await _player.play();
    notifyListeners();
  }

  void play() {
    _player.play();
    notifyListeners();
  }

  void pause() {
    _player.pause();
    notifyListeners();
  }

  void next() async {
    if (_playlist.isEmpty) return;
    if (_isShuffle) {
      final candidates = List.generate(_playlist.length, (i) => i)..remove(_currentIndex);
      candidates.shuffle();
      _currentIndex = candidates.first;
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }
    await _loadAndPlay();
  }

  void previous() async {
    if (_playlist.isEmpty) return;
    if (_isShuffle) {
      final candidates = List.generate(_playlist.length, (i) => i)..remove(_currentIndex);
      candidates.shuffle();
      _currentIndex = candidates.first;
    } else {
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    }
    await _loadAndPlay();
  }

  void seekForward10s() {
    final newPos = _player.position + const Duration(seconds: 10);
    _player.seek(newPos < (_player.duration ?? Duration.zero) ? newPos : (_player.duration ?? Duration.zero));
    notifyListeners();
  }

  void seekBackward10s() {
    final newPos = _player.position - const Duration(seconds: 10);
    _player.seek(newPos > Duration.zero ? newPos : Duration.zero);
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }

  void stopAndClear() {
  pause();
  _playlist.clear();
  notifyListeners();
}

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}