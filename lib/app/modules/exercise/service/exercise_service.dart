import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../../models/exercise_model.dart';
import '../repository/i_exercise_repository.dart';
import 'i_exercise_service.dart';

@LazySingleton(as: IExerciseService)
class ExerciseService implements IExerciseService {
  IExerciseRepository exerciseRepository;
  ILogger log;

  ExerciseService({
    required this.exerciseRepository,
    required this.log,
  });

  @override
  Future<void> createExercise(ExerciseModel exercise) =>
      exerciseRepository.createExercise(exercise);

  @override
  Future<List<ExerciseModel>> getAll() => exerciseRepository.getAll();

  @override
  Future<ExerciseModel> getDetail(int id) => exerciseRepository.getDetail(id);

  @override
  Future<List<ExerciseModel>> getByMuscleGroup(int id) =>
      exerciseRepository.getByMuscleGroup(id);
}
