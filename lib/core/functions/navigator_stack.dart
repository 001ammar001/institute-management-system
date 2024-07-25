import 'package:flutter/material.dart';
import 'package:institute_management_system/features/dashbord/presentation/pages/dash_bord.dart';

class ScreenStack {
  final List<Widget> _stackScreen = [const DashBordPage()];
  final List<String> _stackTitle = ['اللوحة الرئيسية'];

  void pushScreen({required Widget screen, required String title}) {
    _stackScreen.add(screen);
    _stackTitle.add(title);
  }

  void popScreen() {
    if (_stackScreen.length != 1) {
      _stackScreen.removeLast();
      _stackTitle.removeLast();
    } else if (_stackTitle[0] != 'اللوحة الرئيسية') {
      _stackScreen.removeLast();
      _stackTitle.removeLast();
      _stackScreen.add(const DashBordPage());
      _stackTitle.add('اللوحة الرئيسية');
    }
  }

  void clearScreens() {
    _stackScreen.clear();
    _stackTitle.clear();
  }

  Widget get currentScreen {
    return _stackScreen.last;
  }

  String get currentTitle {
    return _stackTitle.last;
  }
}
