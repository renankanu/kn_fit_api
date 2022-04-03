import '../../../models/models.dart';

abstract class IPersonalTrainingRepository {
  Future<void> createPersonalTraining(PersonalTrainingModel personalTraining);
  Future<List<PersonalTrainingModel>> getAll();
}
