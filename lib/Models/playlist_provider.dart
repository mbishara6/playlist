import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:play_list/Models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "nice",
      artistName: 'dicom',
      albumArtImagePath: "assets/images",
      audioPath: "audio/chill",
    )
  ];

  // current song index
  int? _currentSongIndex;

  /*
  AUDIO PLAYER
   */
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // playing state
  bool _isPlaying = false;

  // play the song
  Future<void> play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0; // loop back
      }
      play();
    }
  }

  // play previous song
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex != null) {
        if (_currentSongIndex! > 0) {
          _currentSongIndex = _currentSongIndex! - 1;
        } else {
          _currentSongIndex = _playlist.length - 1; // loop back
        }
        play();
      }
    }
  }

  // listen to duration updates
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /*
  GETTERS
   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
  SETTERS
   */
  void setCurrentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
