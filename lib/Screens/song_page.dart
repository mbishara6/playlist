import 'package:flutter/material.dart';
import 'package:play_list/Models/playlist_provider.dart';
import 'package:play_list/components/neu_box.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
        builder: (context,value,child){
// get the playlist
        final playlist = value.playlist;
        final currentSong = playlist[value.currentSongIndex ?? 0];


          // Return UI
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                centerTitle: true,
                title: Text("S O N G P A G E",
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // appbar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //back button
                          IconButton(
                            onPressed: ()=>Navigator.pop(context),
                            icon:const Icon(Icons.arrow_back),
                          ),
                          //title
                          const Text("P L A Y L I S T"),

                          //MENU BUTTON
                          IconButton(onPressed: (){},
                              icon:const  Icon(Icons.menu))
                        ],
                      ),

                      //album artwork
                      NeuBox(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(currentSong.albumArtImagePath),
                              ),
                              // song artist Name
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // artist name
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(currentSong.songName,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,

                                        ),),
                                        Text(currentSong.artistName),
                                      ],
                                    ),
                                    //heart icon
                                    Icon(Icons.favorite,
                                      color: Colors.red,)
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 25,),
                      // song duration progress
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //start time
                                Text("0:00"),

                                // shuffle
                                Icon(Icons.shuffle),

                                //repeat

                                Icon(Icons.repeat),

                                //end time
                                Text("0:00")
                              ],
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape:
                                const RoundSliderThumbShape(enabledThumbRadius: 0)
                            ),
                            child: Slider(
                                min: 0,
                                max: 100,
                                activeColor: Colors.green,
                                value: 0,
                                onChanged:(value){

                                }

                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      //playback controls
                      Row(
                        children: [
                          //skip previous
                          Expanded(
                            child: GestureDetector(
                              child: NeuBox(
                                child: Icon(Icons.skip_previous),),
                            ),),
                          SizedBox(width: 25,),

                          //play pause
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: NeuBox(
                                child: Icon(Icons.play_arrow),),
                            ),),

                          //skip forward
                          Expanded(
                            child: GestureDetector(
                              child: NeuBox(
                                child: Icon(Icons.skip_next),),
                            ),)

                        ],

                      ),

                    ],
                  ),
                ),
              ),
          );});
        }
   


  }

// Center(
// child: NeuBox(
// child: Icon(
// Icons.search_rounded,
// opticalSize: 10,
// size: 100,
//
// )),),
