import 'package:flutter/material.dart';
import 'package:play_list/Screens/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'Models/playlist_provider.dart';
import 'Screens/home.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context)=>ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>PlayListProvider()),
      ],
        child: const Home() ,)
  );
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}
