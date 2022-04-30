import '../../../models/models.dart';

abstract class IPersonalTrainingService {
  Future<void> createPersonalTraining(PersonalTrainingModel personalTraining);
  Future<PersonalTrainingModel> login(String email, String password);
  Future<List<PersonalTrainingModel>> getAll();
  Future<PersonalTrainingModel> getInfo(int id);
  Future<PersonalTrainingModel> getInfoByEmail(String email);
  Future<void> updatePersonalTraining(PersonalTrainingModel personalTraining);
}
