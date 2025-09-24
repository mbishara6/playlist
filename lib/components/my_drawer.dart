import 'package:flutter/material.dart';
import 'package:play_list/Screens/settings.dart';
import 'package:play_list/components/page_transitions.dart';

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
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: Text(
                "H O M E",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.home_filled,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 5),
            child: ListTile(
              title: Text(
                "L I B R A R Y",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.library_music,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 5),
            child: ListTile(
              title: Text(
                "F A V O R I T E S",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary.withValues(alpha: 0.3),
            indent: 25,
            endIndent: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 5),
            child: ListTile(
              title: Text(
                "S E T T I N G S",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () {
                Navigator.push(context, FadeRoute(page: const Settings()));
              },
            ),
          )
        ]
      ),
      
    );
  }
}

