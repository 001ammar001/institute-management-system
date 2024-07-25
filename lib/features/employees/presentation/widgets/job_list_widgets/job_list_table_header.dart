import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:institute_management_system/core/widgets/table_screen/background_header.dart';

class JobListTableHeader extends StatelessWidget {
  final Size media;
  const JobListTableHeader({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BackgroundHeaderTable(
        media: media,
        row: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'id',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'الاسم',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'الراتب',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
