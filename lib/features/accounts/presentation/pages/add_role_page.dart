import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/role_details_bloc/role_details_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/add_role_body.dart';
import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddRolePage extends StatefulWidget {
  final int? id;
  const AddRolePage({super.key, this.id});

  @override
  State<AddRolePage> createState() => _AddRolePageState();
}

class _AddRolePageState extends State<AddRolePage> {
  late TextEditingController nameController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TitleWhitBackButton(
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
            text: widget.id != null ? "تعديل دور" : 'إضافة دور',
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => getit.sl<RoleDetailsBloc>()
                ..add(GetPermissionsEvent(id: widget.id)),
              child: BlocConsumer<RoleDetailsBloc, RoleDetailsState>(
                listener: (context, state) {
                  if (state.status == RoleStatus.loaded) {
                    _populateFileds(state.role);
                  }
                },
                builder: (context, state) {
                  if (state.status == RoleStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == RoleStatus.failure) {
                    return ReseendButton(
                      message: state.message!,
                      onPressed: () {
                        BlocProvider.of<RoleDetailsBloc>(context)
                            .add(GetPermissionsEvent(id: widget.id));
                      },
                    );
                  }
                  return AddRoleBody(
                    formKey: formKey,
                    id: widget.id,
                    detailsState: state,
                    nameController: nameController,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _populateFileds(RoleEntity roleEntity) {
    nameController.text = roleEntity.name;
  }
}
