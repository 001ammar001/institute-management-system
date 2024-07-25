import 'package:flutter/material.dart';

import 'buttons/back_button.dart';

class TitleWhitBackButton extends StatelessWidget {
  const TitleWhitBackButton({
    super.key,
    required this.text, required this.function,
  });
  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
           BackButtonYellow(function: function,),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.sizeOf(context).width * 0.02,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 18.0, right: 18.0),
                  child: Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
