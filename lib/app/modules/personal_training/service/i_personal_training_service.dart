import '../../../models/models.dart';
import '../view_models/personal_training_save_input.dart';

abstract class IPersonalTrainingService {
  Future<void> createPersonalTraining(
    PersonalTrainingSaveInput personalTraining,
  );
  Future<PersonalTrainingModel> login(String email, String password);
  Future<List<PersonalTrainingModel>> getAll();
}
