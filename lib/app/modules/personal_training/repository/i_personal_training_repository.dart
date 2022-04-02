import '../../../models/models.dart';

abstract class IPersonalTrainingRepository {
  Future<void> createPersonalTraining(PersonalTrainingModel personalTraining);
}
