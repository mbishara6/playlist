import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Theme/theme_provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("S E T T I N G S ")
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [
            //darkMode
            Text("Dark Mode",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            
            CupertinoSwitch(
                value:
                Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                onChanged: (value){
                  Provider.of<ThemeProvider>(context,listen: false).toggleTheme();

            })
            
          ],
        ),
      ),
    );
  }
}
