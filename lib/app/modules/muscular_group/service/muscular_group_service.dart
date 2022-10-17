import 'package:injectable/injectable.dart';

import './i_muscular_group_service.dart';
import '../../../core/logger/i_logger.dart';
import '../../../models/muscular_group_model.dart';
import '../repository/i_muscular_group_repository.dart';

@LazySingleton(as: IMuscularGroupService)
class MuscularGroupService implements IMuscularGroupService {
  final IMuscularGroupRepository muscularGroupRepository;
  ILogger log;

  MuscularGroupService({
    required this.muscularGroupRepository,
    required this.log,
  });

  @override
  Future<void> create(MuscularGroupModel muscularGroup) async {
    return muscularGroupRepository.create(muscularGroup);
  }

  @override
  Future<List<MuscularGroupModel>> getAll() {
    return muscularGroupRepository.getAll();
  }
}
