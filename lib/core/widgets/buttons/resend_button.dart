import 'package:flutter/material.dart';

class ReseendButton extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  const ReseendButton({
    super.key,
    this.message = "حدث خطأ يرجى المحاولة مجددا",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          TextButton(
            onPressed: onPressed,
            child: const Text("إعادة المحاولة"),
          )
        ],
      ),
    );
  }
}
