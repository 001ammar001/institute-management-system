import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String label;
  final Function add;
  const AddButton({
    super.key,
    required this.label, required this.add,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.amber,
        width: 300,
        height: 40,
        child: MaterialButton(
          onPressed: () {
            add();
          },
          child: Text("إضافة $label"),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class AddNewItemButton extends StatelessWidget {
//   const AddNewItemButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {},
//       padding: EdgeInsets.zero,
//       style: IconButton.styleFrom(
//         backgroundColor: Colors.yellow,
//         highlightColor: Colors.yellowAccent,
//         minimumSize: const Size(0, 0),
//         maximumSize: const Size.fromRadius(25),
//         iconSize: MediaQuery.sizeOf(context).width * 0.035,
//       ),
//       color: Colors.black,
//       icon: const Icon(
//         Icons.add,
//       ),
//     );
//   }
// }
