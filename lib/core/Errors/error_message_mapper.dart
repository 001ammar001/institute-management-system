import 'package:institute_management_system/core/Errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure) {
    case ServerFailure _:
      return "حدث خطأ يرجى المحاولة لاحق";
    case DataFailure _:
      return failure.message;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
