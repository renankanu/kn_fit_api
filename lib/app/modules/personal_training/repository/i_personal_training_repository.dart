import '../../../models/models.dart';

abstract class IPersonalTrainingRepository {
  Future<void> createPersonalTraining(PersonalTrainingModel personalTraining);
  Future<PersonalTrainingModel> login(String email, String password);
  Future<List<PersonalTrainingModel>> getAll();
}
