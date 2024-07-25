import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text="إرسال",
  });
  final bool isLoading;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.sizeOf(context).width * .35,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MaterialButton(
              color: Colors.yellow,
              onPressed: onPressed,
              child: Text(text),
            ),
    );
  }
}
