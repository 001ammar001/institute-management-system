import 'package:flutter/material.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/home_card.dart';

import '../../../accounts/presentation/pages/show_roles.dart';
import '../../../login/presentation/pages/login_page.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardTile(
            icon: Icons.play_arrow_outlined,
            iconBgColor: Colors.yellow,
            mainText: "الأدوار",
            subText: "",
            page: ShowRolesScreen(),
          ),
          CardTile(
            icon: Icons.play_arrow_outlined,
            iconBgColor: Colors.yellow,
            mainText: "النسخ الاحتياطي",
            subText: "",
            page:SizedBox(),
          ),
          CardTile(
            icon: Icons.person,
            iconBgColor: Colors.yellow,
            mainText: "تقارير",
            subText: "",
            page: SizedBox(),
          ),
          CardTile(
            icon: Icons.play_arrow_outlined,
            iconBgColor: Colors.yellow,
            mainText: "تعديل بيانات الحساب",
            subText: "",
            page: LoginPage(
              type: 'Update',
            ),
          ),
          CardTile(
            icon: Icons.play_arrow_outlined,
            iconBgColor: Colors.yellow,
            mainText: "تسجيل الخروج",
            subText: "",
            page:  LogOut(),
          )
        ],
      ),
    );
  }
}

class  LogOut extends StatelessWidget{
  const LogOut();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
