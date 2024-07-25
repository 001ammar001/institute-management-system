import 'package:flutter/material.dart';

class CrossCheckButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CrossCheckButton(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      style: IconButton.styleFrom(
        backgroundColor: value ? Colors.green : Colors.red,
      ),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == const ValueKey('icon1')
              ? Tween<double>(begin: 1, end: 0).animate(anim)
              : Tween<double>(begin: 0.75, end: 1).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: value
            ? const Icon(Icons.check, key: ValueKey('icon1'))
            : const Icon(Icons.close, key: ValueKey('icon2')),
      ),
      onPressed: () {
        onChanged(!value);
      },
    );
  }
}
