import 'package:flutter/material.dart';

void navigateTo({context, widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return widget;
    }));

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return widget;
    }), (route) => false);



