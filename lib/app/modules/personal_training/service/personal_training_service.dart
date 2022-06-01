import 'package:injectable/injectable.dart';

import '../../../core/logger/i_logger.dart';
import '../../../models/models.dart';
import '../repository/i_personal_training_repository.dart';
import 'i_personal_training_service.dart';

@LazySingleton(as: IPersonalTrainingService)
class PersonalTrainingService implements IPersonalTrainingService {
  IPersonalTrainingRepository personalTrainingRepository;
  ILogger log;

  PersonalTrainingService({
    required this.personalTrainingRepository,
    required this.log,
  });

  @override
  Future<void> createPersonalTraining(
    PersonalTrainingModel personalTraining,
  ) {
    return personalTrainingRepository.createPersonalTraining(personalTraining);
  }

  @override
  Future<List<PersonalTrainingModel>> getAll() {
    return personalTrainingRepository.getAll();
  }

  @override
  Future<PersonalTrainingModel> login(String email, String password) {
    return personalTrainingRepository.login(email, password);
  }

  @override
  Future<PersonalTrainingModel> getInfo(int id) {
    return personalTrainingRepository.getInfo(id);
  }

  @override
  Future<PersonalTrainingModel> getInfoByEmail(String email) =>
      personalTrainingRepository.getInfoByEmail(email);

  @override
  Future<void> updatePersonalTraining(PersonalTrainingModel personalTraining) =>
      personalTrainingRepository.updatePersonalTraining(personalTraining);
}
