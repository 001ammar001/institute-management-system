import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/warehouse_repository.dart';

class ImportExportItemUseCase {
  final WareHouseRepository repository;

  ImportExportItemUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(ImportExportEntity itemEntity) async {
    return await repository.importExportItem(itemEntity);
  }
}
