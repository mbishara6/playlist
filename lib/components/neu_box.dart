import 'package:flutter/material.dart';
import 'package:play_list/Screens/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child ;
  const NeuBox({super.key,required this.child});

  @override
  Widget build(BuildContext context) {

    //is darkMode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        
        color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            // darker shadow on bottom
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),

            BoxShadow(
              color: isDarkMode ? Colors.grey : Colors.white ,
              blurRadius: 15,
              offset: const Offset(-4,-4),
            ),]
      ),
    padding: EdgeInsets.all(12),
      child: child,
    );
  }
}
