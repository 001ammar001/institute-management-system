part of 'import_export_item_bloc.dart';

class ImportExportItemEvent extends Equatable {
  final ImportExportEntity importExportEntity;
  const ImportExportItemEvent({required this.importExportEntity});

  @override
  List<Object> get props => [importExportEntity];
}
