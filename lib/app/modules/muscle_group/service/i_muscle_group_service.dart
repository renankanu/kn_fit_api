import '../../../models/models.dart';

abstract class IMuscleGroupService {
  Future<void> create(MuscleGroupModel muscleGroup);
  Future<List<MuscleGroupModel>> getAll();
  Future<MuscleGroupModel> getDetail(int id);
}
