import 'package:injectable/injectable.dart';

import '../../../core/logger/i_logger.dart';
import '../../../models/models.dart';
import '../repository/i_personal_training_repository.dart';
import '../view_models/personal_training_save_input.dart';
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
    PersonalTrainingSaveInput personalTraining,
  ) {
    final personalTrainingEntity = PersonalTrainingModel(
      fullName: personalTraining.fullName,
      email: personalTraining.email,
      password: personalTraining.password,
      crefType: personalTraining.crefType,
      crefNumber: personalTraining.crefNumber,
    );

    return personalTrainingRepository
        .createPersonalTraining(personalTrainingEntity);
  }

  @override
  Future<List<PersonalTrainingModel>> getAll() {
    return personalTrainingRepository.getAll();
  }

  @override
  Future<PersonalTrainingModel> login(String email, String password) {
    return personalTrainingRepository.login(email, password);
  }
}
