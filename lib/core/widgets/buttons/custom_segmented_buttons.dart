import 'package:flutter/material.dart';

class CustomSegmentedButton extends StatelessWidget {
  const CustomSegmentedButton({
    super.key,
    required this.selectedValue,
    required this.onSelectionChanged,
    required this.label,
    required this.segments,
  });
  final String label;
  final Set selectedValue;
  final List<ButtonSegment> segments;
  final void Function(Set<dynamic> data) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SegmentedButton(
                  selected: selectedValue,
                  emptySelectionAllowed: false,
                  onSelectionChanged: (p0) {
                    onSelectionChanged(p0);
                  },
                  showSelectedIcon: false,
                  style: SegmentedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.all(20),
                    selectedBackgroundColor: Colors.yellow,
                    selectedForegroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  segments: segments,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
