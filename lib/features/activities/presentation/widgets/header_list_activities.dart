import 'package:flutter/material.dart';

import '../../../../core/widgets/table_screen/background_header.dart';

class HeaderListActivities extends StatelessWidget {
  final Size media;
  const HeaderListActivities({
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
              '     #          ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '                              النشاط                ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '                                الوقت',
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
