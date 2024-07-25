import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/utils/Network/local/shared_preferences.dart';
import 'package:institute_management_system/features/accounts/data/data_sources/roles_remote_data_source.dart';
import 'package:institute_management_system/features/accounts/data/data_sources/users_remote_data_source.dart';
import 'package:institute_management_system/features/accounts/data/repositores/roles_repository_implementation.dart';
import 'package:institute_management_system/features/accounts/data/repositores/user_repository_implementation.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/roles_repository.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/user_repository.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/add_update_role_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/add_user_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/delete_user_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/edit_user_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/fetch_users_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/get_permissions_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/get_role_details_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/restore_user_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/user_details_usecase.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/add_role_bloc/add_role_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/role_details_bloc/role_details_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:institute_management_system/features/courses/data/data_sources/course_remote_datasource.dart';
import 'package:institute_management_system/features/courses/data/data_sources/room_category_remote_datasource.dart';
import 'package:institute_management_system/features/courses/data/data_sources/subject_remote_data_source.dart';
import 'package:institute_management_system/features/courses/data/repositores/subject_repository_implmentation.dart';
import 'package:institute_management_system/features/courses/data/repositores/coures_repository_implementation.dart';
import 'package:institute_management_system/features/courses/data/repositores/room_category_repository_implementation.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';
import 'package:institute_management_system/features/courses/domain/repositores/room_category_repository.dart';
import 'package:institute_management_system/features/courses/domain/repositores/subject_repository.dart';
import 'package:institute_management_system/features/courses/domain/useCases/add_course_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/category/add_update_category_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/new_enrollment_use_case.dart';
import 'package:institute_management_system/features/courses/domain/useCases/room/add_update_room_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/add_update_subject_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/get_calendar_events_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/get_course_details_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/delete_subjects_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/get_subjects_usecase.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/add_course_bloc/add_coures_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/coures_details_bloc/course_details_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/rooms_and_categorys/rooms_and_categorys_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/add_subject_bloc/add_subject_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/subjects_list_bloc/subjects_list_bloc.dart';
import 'package:institute_management_system/features/employees/data/data_sources/employee_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/data_sources/job_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/data_sources/shift_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/repositores/employee_repository_implementation.dart';
import 'package:institute_management_system/features/employees/data/repositores/job_repository_implementation.dart';
import 'package:institute_management_system/features/employees/data/repositores/shift_repository_implementation.dart';
import 'package:institute_management_system/features/employees/domain/repositires/employee_repository.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_employee_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_job_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_shift_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/delete_job_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/delete_shift_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_emloyee_data_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_job_details_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_jobs_list_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_shift_details.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_shifts_list_usecase.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/add_employee_bloc/add_employee_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/add_job_bloc/add_job_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/add_shift_bloc/add_shift_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/employee_detials_bloc/employee_details_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/enrollment/enrollment_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/job_details_bloc/job_details_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/jobs_title_list_bloc/job_title_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shift_details_bloc/shift_details_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shifts_list_bloc/shits_list_bloc.dart';
import 'package:institute_management_system/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:institute_management_system/features/login/presentation/pages/login_page.dart';
import 'package:institute_management_system/features/search/data/data_sources/search_remote_datasource.dart';
import 'package:institute_management_system/features/search/data/repositores/search_repository_implementation.dart';
import 'package:institute_management_system/features/search/domain/repositores/search_repositore.dart';
import 'package:institute_management_system/features/search/domain/usecases/search_usecase.dart';
import 'package:institute_management_system/features/search/presentation/bloc/search_dialog_bloc/search_dialog_bloc.dart';
import 'package:institute_management_system/features/students/data/data_sources/student_remote_data_source.dart.dart';
import 'package:institute_management_system/features/students/data/repositores/student_repository_implementation.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';
import 'package:institute_management_system/features/students/domain/usecases/add_update_student_usecase.dart';
import 'package:institute_management_system/features/students/domain/usecases/fetch_student_without_pagination.dart';
import 'package:institute_management_system/features/students/domain/usecases/get_student_courses_use_case.dart';
import 'package:institute_management_system/features/students/domain/usecases/get_student_details_usecase.dart';
import 'package:institute_management_system/features/students/presentation/bloc/add_student_bloc/add_student_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/student_course/student_course_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/student_details_bloc/student_details_bloc.dart';
import 'package:institute_management_system/features/teachers/data/data_sources/teacher_remote_data_source.dart.dart';
import 'package:institute_management_system/features/teachers/data/repositores/teacher_repository_implementation.dart';
import 'package:institute_management_system/features/teachers/domain/repositores/teacher_repository.dart';
import 'package:institute_management_system/features/teachers/domain/usecases/add_update_teacher_usecase.dart';
import 'package:institute_management_system/features/teachers/domain/usecases/get_teachers_details.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/add_teacher_bloc/add_teacher_bloc.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/teacher_details_bloc/teacher_details_bloc.dart';
import 'package:institute_management_system/features/warehouse/domain/usecases/add_update_stock_item_usecase.dart';
import 'package:institute_management_system/features/warehouse/domain/usecases/import_export_item.dart';
import 'package:institute_management_system/features/warehouse/presentation/bloc/add_update_stock_item_bloc/add_update_stock_item_bloc.dart';
import 'package:institute_management_system/features/warehouse/presentation/bloc/import_export_item_bloc/import_export_item_bloc.dart';

import '../../features/accounts/domain/useCases/delete_role_usecase.dart';
import '../../features/accounts/domain/useCases/fetch_role_usecase.dart';
import '../../features/accounts/presentation/bloc/list_roles_bloc/list_role_bloc.dart';
import '../../features/activities/domain/usecases/fetch_activity_usecase.dart';
import '../../features/activities/data/data_sources/activity_remote_data_source.dart.dart';
import '../../features/activities/data/repositores/activity_repository_implementation.dart';
import '../../features/activities/domain/repositores/activity_repository.dart';
import '../../features/activities/presentation/bloc/list_activities_bloc/list_activity_bloc.dart';
import '../../features/box/box_accounts/data/data_sources/accounts_remote_data_source.dart.dart';
import '../../features/box/box_accounts/data/repositores/accounts_repository_implementation.dart';
import '../../features/box/box_accounts/domain/repositores/accounts_repository.dart';
import '../../features/box/box_accounts/domain/usecases/delete_accounts_usecase.dart';
import '../../features/box/box_accounts/domain/usecases/fetch_main_accounts_usecase.dart';
import '../../features/box/box_accounts/domain/usecases/fetch_sub_accounts_usecase.dart';
import '../../features/box/box_accounts/presentation/bloc/list_main_accounts_bloc/main_accounts_bloc.dart';
import '../../features/box/box_accounts/presentation/bloc/list_sub_accounts_bloc/sub_accounts_bloc.dart';
import '../../features/courses/domain/useCases/category/delete_category_usecase.dart';
import '../../features/courses/domain/useCases/category/fetch_categories_usecase.dart';
import '../../features/courses/domain/useCases/delete_course_usecase.dart';
import '../../features/courses/domain/useCases/fetch_courses_usecase.dart';
import '../../features/courses/domain/useCases/room/delete_room_usecase.dart';
import '../../features/courses/domain/useCases/room/fetch_rooms_usecase.dart';
import '../../features/courses/presentation/bloc/list/list_categories_bloc/list_categories_bloc.dart';
import '../../features/courses/presentation/bloc/list/list_courses_bloc/list_courses_bloc.dart';
import '../../features/courses/presentation/bloc/list/list_rooms_bloc/list_rooms_bloc.dart';
import '../../features/employees/domain/usecases/delete_employee_usecase.dart';
import '../../features/employees/domain/usecases/fetch_employees_usecase.dart';
import '../../features/employees/presentation/bloc/list_employee_bloc/list_employees_bloc.dart';
import '../../features/students/domain/usecases/delete_student_usecase.dart';
import '../../features/students/domain/usecases/fetch_students_usecase.dart';
import '../../features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';
import '../../features/teachers/domain/usecases/delete_teacher_usecase.dart';
import '../../features/teachers/domain/usecases/fetch_teachers_usecase.dart';
import '../../features/teachers/presentation/bloc/list_teachers_bloc/list_teachers_bloc.dart';
import '../../features/warehouse/data/data_sources/warehouse_remote_data_source.dart.dart';
import '../../features/warehouse/data/repositores/warehouse_repository_implementation.dart';
import '../../features/warehouse/domain/repositores/warehouse_repository.dart';
import '../../features/warehouse/domain/usecases/delete_item_usecase.dart';
import '../../features/warehouse/domain/usecases/fetch_items_warehouse_usecase.dart';
import '../../features/warehouse/presentation/bloc/stock_items_list_bloc/list_items_warehouse_bloc.dart';
import '../functions/navigator_stack.dart';

final sl = GetIt.instance;

class RefreshTokenInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 502) {
      if (await CacheHelper.removeToken()) {
        navigationKey.currentState!.pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage(
                type: 'Login',
              );
            },
          ),
        );
      } else {
        throw ServerException();
      }
    } else {
      return handler.next(err);
    }
  }
}

Future<void> init() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000/api/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      validateStatus: (status) {
        return status == 502 ? false : true;
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${CacheHelper.getData(key: "token")}"
      },
    ),
  );

  dio.interceptors.add(RefreshTokenInterceptor());

  sl.registerLazySingleton(() => dio);

  initTemplate();
}

Future<void> initTemplate() async {
  initUser();
  initAuth();
  initSearch();
  initAddUpdateRoomCategory();
  initSubjects();
  initStudent();
  initShift();
  initJob();
  initTeacher();
  initCourse();
  initEmployee();
  initWarehouse();
  initRoles();
  initScreenStack();
  initListActivity();
  initAccounts();
}

Future<void> initScreenStack() async {
  sl.registerLazySingleton<ScreenStack>(() => ScreenStack());
}

Future<void> initAuth() async {
  sl.registerLazySingleton(() => LoginCubit(dio: sl()));
}

Future<void> initSearch() async {
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImplementation(
      searchRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => SearchForItemUseCase(searchRepository: sl()));
  sl.registerFactory(() => SearchBloc(searchForItemUseCase: sl()));
}

Future<void> initUser() async {
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserDioDataSource(dio: sl()));

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      userRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => FetchUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => UserDetailsUseCase(repositrory: sl()));
  sl.registerLazySingleton(() => AddUserUseCase(repositrory: sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => RestoreUserUseCase(repositrory: sl()));

  sl.registerFactory(() => AddUserBloc(addUserUseCase: sl()));
  sl.registerFactory(() => UserDetailsBloc(userDetailsUseCase: sl()));

  sl.registerFactory(() => ListUsersBloc(
        fetchUsersUseCase: sl(),
        deleteUserUseCase: sl(),
        editUserUseCase: sl(),
        restoreUserUseCase: sl(),
      ));
}

Future<void> initAddUpdateRoomCategory() async {
  sl.registerLazySingleton<RoomCategoryDataSource>(
      () => RoomCategoryDioDataSource(dio: sl()));

  sl.registerLazySingleton<RoomAndCategoryRepository>(
    () => RoomAndCategoryRepositoryImplementation(
      searchRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddUpdateRoomUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchRoomsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteRoomUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchCategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(repository: sl()));

  sl.registerFactory(() => RoomsAndCategorysBloc(
        addUpdateCategory: sl(),
        addUpdateRoom: sl(),
      ));
  sl.registerFactory(() => ListRoomsBloc(
        fetchRoomsUseCase: sl(),
        deleteRoomUseCase: sl(),
      ));
  sl.registerFactory(() => ListCategoriesBloc(
        fetchCategoriesUseCase: sl(),
        deleteCategoryUseCase: sl(),
      ));
}

Future<void> initSubjects() async {
  sl.registerLazySingleton<SubjectRemoteDataSource>(
      () => SubjectDioDataSource(dio: sl()));

  sl.registerLazySingleton<SubjectRepository>(
    () => SubjectRepositoryImplementation(
      subjectRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateSubjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteSubjectUseCase(repository: sl()));

  sl.registerFactory(() => SubjectAddBloc(addUpdateSubject: sl()));
  sl.registerFactory(() =>
      SubjectsListBloc(deleteSubjectUseCase: sl(), getSubjectsUseCase: sl()));
}

Future<void> initStudent() async {
  sl.registerLazySingleton<StudentRemoteDataSource>(
      () => StudentDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImplementation(
      studentRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateStudentUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetStudentDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchStudentsUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => FetchStudentsWithoutPaginationUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteStudentUseCase(repository: sl()));

  sl.registerFactory(() => AddStudentBloc(addUpdateStudent: sl()));
  sl.registerFactory(() => StudentDetailsBloc(getStudentDetail: sl()));
  sl.registerFactory(() => ListStudentsBloc(
      fetchstudentsWithoutPagination: sl(),
      fetchStudentsUseCase: sl(),
      deleteStudentUseCase: sl()));
}

Future<void> initWarehouse() async {
  sl.registerLazySingleton<WarehouseRemoteDataSource>(
      () => WarehouseDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<WareHouseRepository>(
    () => WarehouseRepositoryImplementation(
      warehouseRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => FetchItemsUseCase(repository: sl()));

  sl.registerLazySingleton(() => DeleteItemUseCase(repository: sl()));

  sl.registerLazySingleton(() => AddUpdateStockItemUseCase(repository: sl()));

  sl.registerLazySingleton(() => ImportExportItemUseCase(repository: sl()));

  sl.registerFactory(() => AddStockItemBloc(addUpdateStockItem: sl()));

  sl.registerFactory(() => ImportExportItemBloc(importExportItem: sl()));

  sl.registerFactory(() => ListItemsWarehouseBloc(
      fetchItemsWarehouseUseCase: sl(), deleteItemsWarehouseUseCase: sl()));
}

Future<void> initListActivity() async {
  sl.registerLazySingleton<ActivityListRemoteDataSource>(
      () => ActivityDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<ActivityListRepository>(
    () => ActivityListRepositoryImplementation(
      activityRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => FetchActivitiesUseCase(repository: sl()));

  sl.registerFactory(() => ListActivitiesBloc(
        fetchActivitiesUseCase: sl(),
      ));
}

Future<void> initAccounts() async {
  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepoImp(
      accountRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => FetchMainAccountsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchSubAccountsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountsUseCase(repository: sl()));

  sl.registerFactory(() => ListMainAccountsBloc(
        fetchMainAccountsUseCase: sl(),
      ));
  sl.registerFactory(() => ListSubAccountsBloc(
        fetchSubAccountsUseCase: sl(),
        deleteAccountUseCase: sl(),
      ));
}

Future<void> initTeacher() async {
  sl.registerLazySingleton<TeacherRemoteDataSource>(
      () => TeacherDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<TeacherRepository>(
    () => TeacherRepositoryImplementation(
      teacherRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateTeacherUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTeacherDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchTeachersUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTeacherUseCase(repository: sl()));

  sl.registerFactory(() => AddTeacherBloc(addUpdateTeacher: sl()));
  sl.registerFactory(() => TeacherDetailsBloc(getTeacherDetail: sl()));
  sl.registerFactory(() =>
      ListTeachersBloc(fetchTeachersUseCase: sl(), deleteTeacherUseCase: sl()));
}

Future<void> initRoles() async {
  sl.registerLazySingleton<RoleRemoteDataSource>(
      () => RoleDioDataSource(dio: sl()));

  sl.registerLazySingleton<RoleRepository>(
    () => RoleRepositoryImplementation(
      roleRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateRoleUseCase(roleRepository: sl()));
  sl.registerLazySingleton(() => GetRoleDetailsUseCase(roleRepository: sl()));
  sl.registerLazySingleton(() => GetPermissionsUseCase(roleRepository: sl()));
  sl.registerLazySingleton(() => FetchRolesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteRoleUseCase(repository: sl()));

  sl.registerFactory(() => AddRoleBloc(addUpdateRoleUseCase: sl()));
  sl.registerFactory(
      () => RoleDetailsBloc(getRoleDetails: sl(), getPermissions: sl()));
  sl.registerFactory(
      () => ListRolesBloc(fetchRolesUseCase: sl(), deleteRoleUseCase: sl()));
}

Future<void> initShift() async {
  sl.registerLazySingleton<ShiftRemoteDataSource>(
      () => ShiftDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<ShiftRepository>(
    () => ShiftRepositoryImplementation(
      shiftRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateShiftUseCase(shiftRepository: sl()));
  sl.registerLazySingleton(() => GetShiftDataUseCase(shiftRepository: sl()));
  sl.registerLazySingleton(() => DeleteShiftUseCase(shiftRepository: sl()));
  sl.registerLazySingleton(() => GetShiftsListUseCase(shiftRepository: sl()));

  sl.registerFactory(() => ShiftDetailsBloc(getShiftData: sl()));
  sl.registerFactory(
      () => ShiftListBloc(getShiftList: sl(), deleteShift: sl()));

  sl.registerFactory(() => AddShiftBloc(addUpdateShift: sl()));
}

Future<void> initCourse() async {
  sl.registerLazySingleton<CourseRemoteDataSource>(
      () => CourseDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImplementation(
      courseRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => AddUpdateCourseUseCase(courseRepository: sl()));
  sl.registerLazySingleton(
      () => GetCalendarEventsUseCase(courseRepository: sl()));
  sl.registerLazySingleton(() => FetchCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteCourseUseCase(repository: sl()));

  sl.registerLazySingleton(
      () => GetCourseDetailsUseCase(courseRepository: sl()));
  sl.registerLazySingleton(() => NewEnrollmentUseCase(courseRepository: sl()));
  sl.registerLazySingleton(
      () => GetStudentCourseUseCase(studentRepository: sl()));

  sl.registerFactory(() => EnrollmentBloc(newEnrollmentUseCase: sl()));
  sl.registerFactory(() => AddCourseBloc(addCourseUseCase: sl()));
  sl.registerFactory(() => CourseDetailsBloc(getCourseDetails: sl()));
  sl.registerFactory(() => StudentCourseBloc(studentCourseUseCase: sl()));
  sl.registerFactory(() => CalendarBloc(getCalendarEvents: sl()));
  sl.registerFactory(() =>
      ListCoursesBloc(fetchCoursesUseCase: sl(), deleteCourseUseCase: sl()));
}

Future<void> initJob() async {
  sl.registerLazySingleton<JobRemoteDataSource>(
      () => JobDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<JobRepository>(
    () => JobRepositoryImplementation(
      jobRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddUpdateJobUseCase(jobRepository: sl()));
  sl.registerLazySingleton(() => GetJobDataUseCase(jobRepository: sl()));
  sl.registerLazySingleton(() => GetJobTitleListUseCase(jobRepository: sl()));
  sl.registerLazySingleton(() => DeleteJobTitleUseCase(jobRepository: sl()));

  sl.registerFactory(() => AddJobBloc(addUpdateJobUseCase: sl()));
  sl.registerFactory(
      () => JobTitleListBloc(getJobTitleList: sl(), deleteJobTitle: sl()));
  sl.registerFactory(() => JobDetailsBloc(getJobData: sl()));
}

Future<void> initEmployee() async {
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
      () => EmployeeDioRemoteDataSource(dio: sl()));

  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImplementation(
      employeeRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(
      () => AddUpdateEmployeeUseCase(employeeRepository: sl()));

  sl.registerLazySingleton(
      () => GetEmployeeDataUseCase(employeeRepository: sl()));

  sl.registerLazySingleton(() => FetchEmployeesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteEmployeeUseCase(repository: sl()));

  sl.registerFactory(() => AddEmployeeBloc(
        addUpdateEmployeeUseCase: sl(),
      ));
  sl.registerFactory(() => EmployeeDetailsBloc(
        getEmployeeDetail: sl(),
      ));
  sl.registerFactory(() => ListEmployeesBloc(
      fetchEmployeesUseCase: sl(), deleteEmployeeUseCase: sl()));
}
