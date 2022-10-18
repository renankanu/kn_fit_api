import 'package:injectable/injectable.dart';

import '../../../core/logger/i_logger.dart';
import '../../../models/muscle_group_model.dart';
import '../repository/i_muscle_group_repository.dart';
import 'i_muscle_group_service.dart';

@LazySingleton(as: IMuscleGroupService)
class MuscleGroupService implements IMuscleGroupService {
  final IMuscleGroupRepository muscleGroupRepository;
  ILogger log;

  MuscleGroupService({
    required this.muscleGroupRepository,
    required this.log,
  });

  @override
  Future<void> create(MuscleGroupModel muscleGroup) async {
    return muscleGroupRepository.create(muscleGroup);
  }

  @override
  Future<List<MuscleGroupModel>> getAll() {
    return muscleGroupRepository.getAll();
  }

  @override
  Future<MuscleGroupModel> getDetail(int id) async {
    return muscleGroupRepository.getDetail(id);
  }
}
