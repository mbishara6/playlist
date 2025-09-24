import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:play_list/Models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "Blinding Lights",
      artistName: 'The Weeknd',
      albumArtImagePath: "assets/images/dababby.jpeg",
      audioPath: "audios/tenkai.mp3",
    ),
    Song(
      songName: "Watermelon Sugar",
      artistName: 'Harry Styles',
      albumArtImagePath: "assets/images/micheal.jpeg",
      audioPath: "audios/Hussain_Al_Jassmi_-__Ommi_Jannah(360p).mp3",
    ),
    Song(
      songName: "Levitating",
      artistName: 'Dua Lipa',
      albumArtImagePath: "assets/images/Rema.jpeg",
      audioPath: "audios/moha_k_x_dystinct_x_yam_darba_9adiya_lyrics_video_aac_46573.m4a",
    ),
    Song(
      songName: "Good 4 U",
      artistName: 'Olivia Rodrigo',
      albumArtImagePath: "assets/images/dababby.jpeg",
      audioPath: "audios/tenkai.mp3",
    ),
    Song(
      songName: "Stay",
      artistName: 'The Kid LAROI & Justin Bieber',
      albumArtImagePath: "assets/images/micheal.jpeg",
      audioPath: "audios/Hussain_Al_Jassmi_-__Ommi_Jannah(360p).mp3",
    ),
    Song(
      songName: "Heat Waves",
      artistName: 'Glass Animals',
      albumArtImagePath: "assets/images/Rema.jpeg",
      audioPath: "audios/moha_k_x_dystinct_x_yam_darba_9adiya_lyrics_video_aac_46573.m4a",
    ),
  ];


  // current song index
  int? _currentSongIndex = 0;

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

  // shuffle and repeat modes
  bool _isShuffleMode = false;
  bool _isRepeatMode = false;

  // play the song
  Future<void> play() async {
    try {
      final String path = _playlist[_currentSongIndex!].audioPath;
// Attempting to play: $path
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(path));
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
// Error playing audio
      _isPlaying = false;
      notifyListeners();
    }
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
// pauseOrResume called
    if (_isPlaying) {
      pause();
    } else {
      if (_currentSongIndex != null) {
        play();
      }
    }
  }

  // seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_isShuffleMode) {
        // Generate random next song (different from current)
        final Random random = Random();
        int newIndex;
        do {
          newIndex = random.nextInt(_playlist.length);
        } while (newIndex == _currentSongIndex && _playlist.length > 1);
        _currentSongIndex = newIndex;
      } else {
        // Normal sequential play
        if (_currentSongIndex! < _playlist.length - 1) {
          _currentSongIndex = _currentSongIndex! + 1;
        } else {
          if (_isRepeatMode) {
            _currentSongIndex = 0; // loop back to start
          } else {
            // If not repeat mode, stay at the last song and stop
            _isPlaying = false;
            notifyListeners();
            return;
          }
        }
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
        if (_isShuffleMode) {
          // Generate random previous song (different from current)
          final Random random = Random();
          int newIndex;
          do {
            newIndex = random.nextInt(_playlist.length);
          } while (newIndex == _currentSongIndex && _playlist.length > 1);
          _currentSongIndex = newIndex;
        } else {
          // Normal sequential play
          if (_currentSongIndex! > 0) {
            _currentSongIndex = _currentSongIndex! - 1;
          } else {
            if (_isRepeatMode) {
              _currentSongIndex = _playlist.length - 1; // loop back to end
            } else {
              // If not repeat mode, stay at the first song and stop
              _isPlaying = false;
              notifyListeners();
              return;
            }
          }
        }
        play();
      }
    }
  }

  // listen to duration updates
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition ?? Duration.zero;
      // Ensure current duration doesn't exceed total duration
      if (_totalDuration.inSeconds > 0 && _currentDuration > _totalDuration) {
        _currentDuration = _totalDuration;
      }
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isRepeatMode) {
        // If repeat mode is on, replay the same song
        play();
      } else {
        // Otherwise play next song
        playNextSong();
      }
    });
  }

  // dispose player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // toggle shuffle mode
  void toggleShuffle() {
    _isShuffleMode = !_isShuffleMode;
    notifyListeners();
  }

  // toggle repeat mode
  void toggleRepeat() {
    _isRepeatMode = !_isRepeatMode;
    notifyListeners();
  }

  // Simple method to play a specific song
  void playSong(int index) {
_currentSongIndex = index;
    play();
  }

  /*
  GETTERS
   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isShuffleMode => _isShuffleMode;
  bool get isRepeatMode => _isRepeatMode;
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
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
