import 'package:equatable/equatable.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class ProcurementItemEntity extends Equatable {
  final int? id;
  final SearchEntity item;
  final bool forStudent;
  final int quantity;

  const ProcurementItemEntity({
    this.id,
    required this.item,
    required this.forStudent,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, item, forStudent, quantity];
}
