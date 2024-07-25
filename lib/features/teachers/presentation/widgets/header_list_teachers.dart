import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/background_header.dart';

class HeaderListTeachers extends StatelessWidget {
  const HeaderListTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BackgroundHeaderTable(
        media: screenMedia(context),
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
                    'تاريخ الميلاد',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'رقم الهاتف',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // Space for icons
                ], //
              ),
            ),
            SizedBox(width: screenMedia(context).width / 12),
          ],
        ),
      ),
    );
  }
}
