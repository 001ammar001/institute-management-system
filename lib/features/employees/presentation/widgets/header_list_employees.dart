import 'package:flutter/material.dart';

import '../../../../core/widgets/table_screen/background_header.dart';

class HeaderListEmployees extends StatelessWidget {
  final Size media;
  const HeaderListEmployees({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BackgroundHeaderTable(
        media: media,
        row: Row(
          children: [
            const Text(
              '     id           ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'الاسم',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'المسمى الوظيفي',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'المعاش',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // Space for icons
                ], //
              ),
            ),
            SizedBox(width: media.width / 12),
          ],
        ),
      ),
    );
  }
}
