import 'package:flutter/material.dart';
import '../table_screen/background_buttons_pages.dart';

class ButtonsPagesRow extends StatelessWidget {
  const ButtonsPagesRow({
    super.key,
    required this.onPresBack,
    required this.onPresForward,
    required this.pageNumber,
  });

  final int pageNumber;
  final Function onPresBack;
  final Function onPresForward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BackgroundButtonsPages(
        buttonsRow: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                onPresBack();
              },
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.yellow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'الصفحة $pageNumber',
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                onPresForward();
              },
            ),
          ],
        ),
      ),
    );
  }
}
