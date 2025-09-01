import 'package:flutter/material.dart';
import 'package:play_list/Screens/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children:<Widget>[
          //logo
          DrawerHeader(child: Center(
            child: Icon(Icons.music_note_sharp,
            size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
              opticalSize: 15,
            ),
          ),),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 25),
            child: ListTile(
              title: Text("H O M E"),
              leading:Icon(Icons.home_filled),
              onTap: ()=> Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 5),
            child: ListTile(
              title: Text(" S E T T I N G S"),
              leading:Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => Settings()));

                //Navigate to settings

              },
            ),
          )
        ]
      ),
      
    );
  }
}

