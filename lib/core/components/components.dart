import 'package:flutter/material.dart';

import '../Them/custom_colors.dart';

Widget defaultTextFiled({
  bool enable = true,
  bool obscure = false,
  required TextEditingController controller,
  required TextInputType typeKeyBord,
  String? Function(String? value)? validate,
  required String lableText,
  IconData? prefix,
  Widget? suffix,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool? isclicklable = true,
  Color cursorColor = Colors.black,
  Color colorIcon = Colors.black,
  Color labelColor = Colors.black,
  double fontSize = 14,
  double width = 300,
  Color first = Colors.grey,
  Color last = gray100,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        //color: background,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: const Alignment(0.7, 0.0),
          colors: [first, last],
          tileMode: TileMode.clamp,
        ),
      ),
      child: TextFormField(
        //inputFormatters: List.empty() ,

        obscureText: obscure,
        //maxLines: 3,
        enableInteractiveSelection: enable,
        //focusNode: FocusNode(),
        enabled: isclicklable,
        validator: validate,
        controller: controller,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onTap: () {
          onTap!();
        },
        onChanged: (s) {
          onChanged!(s);
        },
        cursorColor: cursorColor,
        keyboardType: typeKeyBord,

        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          focusColor: Colors.yellowAccent,
          errorMaxLines: 2,
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                width: 2.5,
                color: Colors.yellow,
              )),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.yellowAccent,
            ),
          ),
          errorStyle: const TextStyle(color: Colors.yellowAccent),
          labelText: lableText,
          suffixIcon: suffix,
          prefixIcon: Icon(
            prefix,
            color: colorIcon,
          ),

          labelStyle: TextStyle(color: labelColor, fontSize: fontSize),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 2, color: gray150),
          ),
          // enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Honey),borderRadius: ) ,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: beige, style: BorderStyle.none)),
        ),
      ),
    );
