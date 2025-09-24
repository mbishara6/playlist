import 'package:flutter/material.dart';
import 'package:play_list/Screens/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatefulWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  State<NeuBox> createState() => _NeuBoxState();
}

class _NeuBoxState extends State<NeuBox> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // is darkMode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
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
                color: isDarkMode ? Colors.grey : Colors.white,
                blurRadius: 15,
                offset: const Offset(-4, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: widget.child,
        ),
      ),
    );
  }
}
