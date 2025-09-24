import 'package:flutter/material.dart';
import 'package:play_list/Models/playlist_provider.dart';
import 'package:play_list/components/neu_box.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitMinutes =
    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String twoDigitSeconds =
    duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$twoDigitMinutes:$twoDigitSeconds";
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
        builder: (context,value,child){
// get the playlist

        final playlist = value.playlist;
        // Safety check for current song index
        final songIndex = value.currentSongIndex ?? 0;
        if (songIndex >= playlist.length) {
          // If index is out of bounds, reset to first song
          value.playSong(0);
        }
        final currentSong = playlist[songIndex.clamp(0, playlist.length - 1)];


          // Return UI
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                centerTitle: true,
                title: Text("S O N G P A G E",
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      // Song info header
                      Text(
                        "Now Playing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 10),

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
                      const SizedBox(height: 20,),
                      // song duration progress
                      Column(
                        children: [
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //start time
                                Text(formatTime(value.currentDuration)),

                                // shuffle
                                GestureDetector(
                                  onTap: value.toggleShuffle,
                                  child: Icon(
                                    Icons.shuffle,
                                    color: value.isShuffleMode ? Colors.green : Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),

                                //repeat
                                GestureDetector(
                                  onTap: value.toggleRepeat,
                                  child: Icon(
                                    Icons.repeat,
                                    color: value.isRepeatMode ? Colors.green : Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),

                                //end time
                                Text(formatTime(value.totalDuration)),
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
                                max: value.totalDuration.inSeconds.toDouble(),
                                value: value.currentDuration.inSeconds.toDouble(),
                                activeColor: Colors.green,
                                onChanged:(double double){},
                                  // sliding has finished 
                                 onChangeEnd: (double double ){
                                  value.seek(Duration(seconds: double.toInt()));


                                }

                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      //playback controls
                      Row(
                        children: [
                          //skip previous
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
value.playPreviousSong();
                              },
                              child: NeuBox(
                                child: Icon(Icons.skip_previous, size: 28),
                              ),
                            ),
                          ),
                          SizedBox(width: 25,),

                          //play pause
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
value.pauseOrResume();
                              },
                              child: NeuBox(
                                child: Icon(
                                  value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 24,),

                          //skip forward
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
value.playNextSong();
                              },
                              child: NeuBox(
                                child: Icon(Icons.skip_next, size: 28),
                              ),
                            ),
                          ),

                        ],

                      ),

                    ],
                    ),
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
