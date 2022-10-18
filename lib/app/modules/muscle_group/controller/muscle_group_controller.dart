import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../service/i_muscle_group_service.dart';

part 'muscle_group_controller.g.dart';

@Injectable()
class MuscleGroupController {
  final IMuscleGroupService muscleGroupService;
  final ILogger log;

  MuscleGroupController({
    required this.muscleGroupService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> create(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final muscleGroup = MuscleGroupModel.requestMapping(body);
        await muscleGroupService.create(muscleGroup);
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: null,
            message: 'Grupo Muscular criado com sucesso',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/')
  Future<Response> listAll(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final muscleGroups = await muscleGroupService.getAll();
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: muscleGroups,
            message: 'Grupos Musculares buscados com sucesso',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/<id|[0-9]+>')
  Future<Response> getDetail(Request request, String id) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final muscleGroup = await muscleGroupService.getDetail(int.parse(id));
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: muscleGroup,
            message: 'Grupo Muscular buscado com sucesso',
          ),
        );
      },
      log: log,
    );
  }

  Router get router => _$MuscleGroupControllerRouter(this);
}
