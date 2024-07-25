import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/utils/Network/local/shared_preferences.dart';
import 'package:institute_management_system/features/login/presentation/manager/cubit/login_state.dart';

import '../../../../../core/utils/Network/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  final Dio dio;
  bool statusChangePassword = false;

  LoginCubit({required this.dio}) : super(LoginInitialState());

  Future<void> loginUser(  {required String userName, required String password}) async {
    emit(LoginLoadingState());

    await dio.post('login',
        data: {"username": userName, "password": password}).then((value) {
      if (value.statusCode == 200) {
        CacheHelper.saveData(key: "token", value: value.data["data"]);
        CacheHelper.saveData(key: "userName", value: userName);
        emit(LoginSuccessState());
        dio.options.headers["Authorization"] = "Bearer ${value.data["data"]}";
      } else if (value.data["message"] != null) {
        emit(LoginErrorState(error: value.data["message"]));
      } else {
        emit(LoginErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
      }
    }).onError((error, stackTrace) {
      emit(LoginErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
    });
  }

  Future<void> updateDataLogin(  {required String userName, required String password, required String newPassword, required String confirmPassword}) async {
    emit(UpdateDataLoadingState());
    await dio.post(EDITPROFILE,
        data: {"username": userName,"old_password": password,"password": newPassword,"confirm_password": confirmPassword}).then((value) async {
      if (value.statusCode == 200) {
       emit(UpdateDataSuccessState());

      } else if (value.data["message"] != null) {
        emit(UpdateDataErrorState(error: value.data["message"]));
      } else {
        emit(UpdateDataErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
      }
    }).onError((error, stackTrace) {
      emit(UpdateDataErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
    });

  }



  Future<void> logOut() async {
    try {
      final response = await dio.post("logout").onError((error, stackTrace) {
        throw ServerException();
      });
      if (response.statusCode == 200) {
        if (await CacheHelper.removeToken()) {
          emit(LogOutSuccessState());
        }
      } else {
        emit(LoginErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
      }
    } on ServerException {
      emit(LoginErrorState(error: "حدث خطأ يرجى المحاولة مجددا"));
    }
  }

  void changeFields(){
    statusChangePassword=!statusChangePassword;
    emit(ChangeFieldsState());
  }
}

