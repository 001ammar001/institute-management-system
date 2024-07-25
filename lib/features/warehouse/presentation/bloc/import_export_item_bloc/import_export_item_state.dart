part of 'import_export_item_bloc.dart';

sealed class ImportExportItemStates extends Equatable {
  const ImportExportItemStates();

  @override
  List<Object> get props => [];
}

final class ImportExportItemInitial extends ImportExportItemStates {}

final class ImportExportItemLoadingState extends ImportExportItemStates {}

final class ImportExportItemSucessState extends ImportExportItemStates {}

final class ImportExportItemFailureState extends ImportExportItemStates {
  final String message;

  const ImportExportItemFailureState({required this.message});
}
