import '../../../models/models.dart';

abstract class IMuscularGroupService {
  Future<void> create(MuscularGroupModel muscularGroup);
  Future<List<MuscularGroupModel>> getAll();
}
