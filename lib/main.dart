import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/utils/Network/local/shared_preferences.dart';
import 'package:institute_management_system/features/drawer/presentation/pages/drawer_page.dart';
import 'package:institute_management_system/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:institute_management_system/features/login/presentation/pages/login_page.dart';
import 'features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:get/get.dart';
import 'package:institute_management_system/core/Them/light_theme.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:window_manager/window_manager.dart';

void main() async {
  //Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await getit.init();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(400, 600));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    print(token);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider(
          create: (context) => getit.sl<LoginCubit>(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const ScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.trackpad,
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        title: 'Instituate Management System',
        theme: lightTheme,
        navigatorKey: navigationKey,
        locale: const Locale('ar'),
        home: token == null
            ? const LoginPage(
                type: 'Login',
              )
            : const HomeScreen(),
      ),
    );
  }
}
