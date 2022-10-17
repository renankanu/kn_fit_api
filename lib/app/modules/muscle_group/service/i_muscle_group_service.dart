import '../../../models/models.dart';

abstract class IMuscleGroupService {
  Future<void> create(MuscleGroupModel muscleGroup);
  Future<List<MuscleGroupModel>> getAll();
}
