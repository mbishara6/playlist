import 'package:flutter/material.dart';
import 'package:play_list/Screens/song_page.dart';
import 'package:play_list/components/my_drawer.dart';
import 'package:play_list/components/page_transitions.dart';
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
playlistProvider.playSong(songIndex);
    Navigator.push(
      context, 
      SlideRightRoute(page: const SongPage()),
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
              padding: const EdgeInsets.all(16),
              itemBuilder:(context,index){
                // get Individual song
                final Song song = playlist[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      song.songName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      song.artistName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14,
                      ),
                    ),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(song.albumArtImagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.play_circle_filled,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                    onTap: () => goToSong(index),
                  ),
                );
              }
            );
          }
      ),
    );
  }
}


