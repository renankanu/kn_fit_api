import '../../../models/models.dart';

abstract class IExerciseRepository {
  Future<void> createExercise(ExerciseModel exercise);
  Future<List<ExerciseModel>> getAll();
  Future<ExerciseModel> getDetail(int id);
  Future<List<ExerciseModel>> getByMuscleGroup(int id);
}
