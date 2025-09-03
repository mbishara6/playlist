import 'package:flutter/material.dart';
import 'package:play_list/Screens/song_page.dart';
import 'package:play_list/components/my_drawer.dart';
import 'package:provider/provider.dart';
import '../Models/playlist_provider.dart';
import '../Models/song.dart';


class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  //get the final playlist provider
  late final dynamic  playlistProvider;
  @override
  void initState(){
    // Todo: Implement initState
    super.initState();

    //get playList Provider
    playlistProvider = Provider.of<PlayListProvider>(context,listen:false);

  }

  void goToSong (int songIndex){
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(
        context, 
    MaterialPageRoute(builder: (context) => SongPage(),
    ),
    );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("P L A Y L I S T "),
      ),
      drawer:MyDrawer(),
      body: Consumer<PlayListProvider>(
          builder: (context,value,child){

            // get the playlist
            final List<Song> playlist= value.playlist;

            //return List view UI
            return ListView.builder(
              itemCount: playlist.length,
                itemBuilder:(context,index){
                  // get Individual song
                  final Song song = playlist[index];
                  return ListTile(
                    title: Text(song.songName),
                    subtitle: Text(song.artistName),
                    leading: Image.asset(song.albumArtImagePath),
                    onTap: () => goToSong(index),

                  );
                }
            );
          }
      ),
    );
  }
}


