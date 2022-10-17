import '../../../models/models.dart';

abstract class IMuscularGroupRepository {
  Future<void> create(MuscularGroupModel muscularGroup);
  Future<List<MuscularGroupModel>> getAll();
}
