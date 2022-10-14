import '../../../models/models.dart';

abstract class IMuscularGroupRepository {
  Future<void> createMuscularGroup(MuscularGroupModel muscularGroup);
}
