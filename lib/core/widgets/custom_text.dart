import 'package:flutter/material.dart';

class CustomText25 extends StatelessWidget {
  const CustomText25(
      {super.key, required this.text, this.color = Colors.black});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 25),
    );
  }
}

class CustomText14 extends StatelessWidget {
  const CustomText14({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14),
    );
  }
}

class CustomText20 extends StatelessWidget {
  const CustomText20({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }
}

class CustomText17 extends StatelessWidget {
  const CustomText17({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17),
    );
  }
}
