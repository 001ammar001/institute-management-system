import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_details_page_button.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/custom_list_view.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/item_builder_user.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TitleWhitBackButton(
          function: () {
            screenStack.popScreen();
            drawerBloc.add(ChangeWidgetEvent());
          },
          text: "تفاصيل الحساب",
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getit.sl<UserDetailsBloc>()
                ..add(GetUserDetailsEvent(id: user.id!)),
            ),
            BlocProvider(
              create: (context) => getit.sl<ListUsersBloc>(),
            ),
          ],
          child: BlocConsumer<ListUsersBloc, ListUsersStates>(
            listener: (context, state) {
              if (state is UserDeleteSucessState) {
                screenStack.popScreen();
                drawerBloc.add(ChangeWidgetEvent());
              }
              if (state is UserEditSucessState) {
                BlocProvider.of<UserDetailsBloc>(context)
                    .add(GetUserDetailsEvent(id: user.id!));
              }
            },
            builder: (context, state) {
              return BlocConsumer<UserDetailsBloc, UserDetailsState>(
                listener: (BuildContext context, UserDetailsState state) {},
                builder: (context, state) {
                  return (state is UserDetailsLoadedState)
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.8,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    color: Color.fromARGB(82, 128, 128, 128)),
                              ],
                              color: const Color.fromARGB(255, 238, 218, 238)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText20(
                                          text:
                                              "اسم الحساب:${state.userDetailsEntity.username}"),
                                      CustomText20(
                                          text:
                                              "نوع الحساب:${state.userDetailsEntity.role.name}"),
                                      (state.userDetailsEntity.employee != null)
                                          ? CustomText20(
                                              text:
                                                  "اسم الموظف : ${state.userDetailsEntity.employee!.name}")
                                          : const CustomText20(
                                              text:
                                                  "لا يوجد حساب موظف لهذا الحساب"),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: state.userDetailsEntity.userActivityInfo!
                                        .isEmpty
                                    ? const SizedBox(
                                        height: 230,
                                        child: Center(
                                          child: CustomText20(
                                              text:
                                                  "لا يوجد أنشطة خاصة بهذا الحساب"),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            color: Colors.purple.shade100,
                                            child: const Center(
                                              child: CustomText20(
                                                text: "انشطة الحساب",
                                              ),
                                            ),
                                          ),
                                          CustomListView(
                                              userActivity: state
                                                  .userDetailsEntity
                                                  .userActivityInfo!),
                                        ],
                                      ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DetailPageButton(
                                      text: "حذف الحساب",
                                      color: Colors.red,
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        alertDialogGeneral(
                                          title:
                                              "هل أنت متأكد من أنك تريد حذف الحساب",
                                          context: context,
                                          submitFunction: () {
                                            BlocProvider.of<ListUsersBloc>(
                                                    context)
                                                .add(DeleteUserEvent(
                                                    indexUser: user.id!));
                                          },
                                        );
                                      }),
                                  DetailPageButton(
                                      text: "تعديل بيانات الحساب",
                                      color: Colors.green,
                                      onPressed: () async {
                                        await showEditUserDialog(context, user);
                                      })
                                ],
                              )
                            ],
                          ),
                        )
                      : (state is UserDetailFailureState)
                          ? CustomText20(text: state.message)
                          : const CircularProgressIndicator();
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
