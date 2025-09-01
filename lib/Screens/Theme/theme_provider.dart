import 'package:flutter/material.dart';
import 'package:play_list/Screens/Theme/dark_mode.dart';
import 'package:play_list/Screens/Theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  // initially light mode
  late ThemeData _themeData = lightMode;

  //get theme
  ThemeData get themeData => _themeData;

  //is dark mode
bool get isDarkMode => themeData == darkMode;

 //set Theme

set themeData (ThemeData themeData){
  _themeData = themeData;

  //update ui
  notifyListeners();
}


void toggleTheme(){
  if(_themeData==lightMode){
    themeData = darkMode;
  }else{
    themeData= lightMode;
  }
}


}