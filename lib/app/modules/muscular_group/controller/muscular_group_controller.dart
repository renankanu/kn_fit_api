import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../service/i_muscular_group_service.dart';

part 'muscular_group_controller.g.dart';

@Injectable()
class MuscularGroupController {
  final IMuscularGroupService muscularGroupService;
  final ILogger log;

  MuscularGroupController({
    required this.muscularGroupService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> create(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final muscularGroup = MuscularGroupModel.requestMapping(body);
        await muscularGroupService.create(muscularGroup);
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
        final muscularGroups = await muscularGroupService.getAll();
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: muscularGroups,
            message: 'Grupos Musculares buscados com sucesso',
          ),
        );
      },
      log: log,
    );
  }

  Router get router => _$MuscularGroupControllerRouter(this);
}
