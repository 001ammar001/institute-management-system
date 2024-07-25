import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../login/presentation/manager/cubit/login_cubit.dart';
import '../../../login/presentation/manager/cubit/login_state.dart';
import '../../../login/presentation/pages/login_page.dart';
import 'dashboard_header.dart';

class CardTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String mainText;
  final String subText;
  final Widget page;

  const CardTile(
      {super.key,
      required this.icon,
      required this.iconBgColor,
      required this.mainText,
      required this.subText,
      required this.page});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return SizedBox(
      height: media.height / 10,
      width: media.width / 7,
      child: MaterialButton(
        onPressed: () {
          if (page is LogOut) {
            BlocProvider.of<LoginCubit>(context).logOut();
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  showErrorSnackBar(context, state.error);
                } else if (state is LogOutSuccessState) {
                  navigateAndFinish(
                      context,
                      const LoginPage(
                        type: 'Login',
                      ));
                }
              },
              child: const LogOut(),
            );
          } else {
            screenStack.pushScreen(screen: page, title: mainText);
            bloc.add(ChangeWidgetEvent());
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(media.aspectRatio * 5),
          child: Row(
            children: [
              Icon(
                icon,
                size: media.width / 40,
                color: Colors.yellow,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        mainText,
                        style: TextStyle(
                          fontSize: media.height / 45,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      subText,
                      style: TextStyle(
                        fontSize: media.height / 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
