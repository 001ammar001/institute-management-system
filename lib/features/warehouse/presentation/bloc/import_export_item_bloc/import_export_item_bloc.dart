import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';
import 'package:institute_management_system/features/warehouse/domain/usecases/import_export_item.dart';

part 'import_export_item_event.dart';
part 'import_export_item_state.dart';

class ImportExportItemBloc
    extends Bloc<ImportExportItemEvent, ImportExportItemStates> {
  final ImportExportItemUseCase importExportItem;
  ImportExportItemBloc({required this.importExportItem})
      : super(ImportExportItemInitial()) {
    on<ImportExportItemEvent>((event, emit) async {
      emit(ImportExportItemLoadingState());
      final result = await importExportItem(event.importExportEntity);
      result.fold(
        (l) => emit(
          ImportExportItemFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(ImportExportItemSucessState()),
      );
    });
  }
}
