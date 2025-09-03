import 'package:flutter/material.dart';
import 'package:play_list/Models/song.dart';
import 'package:flutter/foundation.dart';

class PlayListProvider extends ChangeNotifier{
 // playlist of songs
  final List<Song> _playlist =[
    Song(
        songName: "nice",
        artistName: 'dicom',
        albumArtImagePath: "assets/images",
        audioPath: "audio/chill")


  ];
  // current song playlist

  int? _currentSongIndex;


  /*
  AUDIO PLAYER
   */
  // audio Player

  //duration

  //constructor

  //initially not playing



  //Getters
List<Song> get playlist => _playlist;

int?  get currentSongIndex => _currentSongIndex;

  void setCurrentSongIndex(int index) {
    _currentSongIndex = index;
    notifyListeners();
  }

  // setters
set currentSongIndex(int? newIndex){
    //update current song
  _currentSongIndex = newIndex;
  notifyListeners();


}







}