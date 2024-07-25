import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/errors/validation_error.dart';

class WeekDaySelector extends StatefulWidget {
  final Set days;
  final Color backgroundColor;
  final Color inactiveTextColor;
  final Color activeTextColor;
  final Color hoverColor;
  final Color inactiveButtonColor;
  final Color activeButtonColor;

  const WeekDaySelector({
    super.key,
    this.backgroundColor = Colors.yellow,
    this.inactiveTextColor = Colors.white,
    this.activeTextColor = Colors.white,
    this.inactiveButtonColor = Colors.black,
    this.activeButtonColor = Colors.blue,
    this.hoverColor = Colors.green,
    required this.days,
  });

  @override
  State<WeekDaySelector> createState() => _WeekDaySelectorState();
}

class _WeekDaySelectorState extends State<WeekDaySelector> {
  final weekdays = [
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت"
  ];
  @override
  Widget build(BuildContext context) {
    return FormField<Set<String>>(validator: (value) {
      if (widget.days.isEmpty) {
        return "يجب اختيار يوم واحد على الأقل";
      }
      return null;
    }, builder: (formFieldState) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("أيام الدورة"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  7,
                  (index) => IconButton(
                    hoverColor: widget.hoverColor,
                    onPressed: () {
                      setState(
                        () {
                          if (widget.days.contains(index)) {
                            widget.days.remove(index);
                          } else {
                            widget.days.add(index);
                          }
                        },
                      );
                    },
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      minimumSize: const Size(0, 0),
                      fixedSize: MediaQuery.sizeOf(context) * 0.075,
                      backgroundColor: widget.days.contains(index)
                          ? widget.activeButtonColor
                          : widget.inactiveButtonColor,
                    ),
                    icon: Text(
                      weekdays[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.days.contains(index)
                            ? widget.activeTextColor
                            : widget.inactiveTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (formFieldState.hasError)
              ValidationErrorMessage(formFieldState: formFieldState)
          ],
        ),
      );
    });
  }
}
