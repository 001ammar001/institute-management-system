import 'package:flutter/material.dart';

class ButtonOfDashboard extends StatelessWidget {
  const ButtonOfDashboard({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.purple),
            width: 150,
            height: MediaQuery.of(context).size.height * 0.08,
            child: MaterialButton(
              onPressed: onPressed(),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
