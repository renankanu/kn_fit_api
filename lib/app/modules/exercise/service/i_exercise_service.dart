import '../../../models/models.dart';

abstract class IExerciseService {
  Future<void> createExercise(ExerciseModel exercise);
  Future<List<ExerciseModel>> getAll();
  Future<ExerciseModel> getDetail(int id);
}
