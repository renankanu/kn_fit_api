import '../../../core/helpers/helpers.dart';

class StudentSaveInputModel extends RequestMapping {
  late String fullName;
  late String email;
  late String password;
  late int personalTrainingId;

  StudentSaveInputModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.personalTrainingId,
  }) : super.empty();

  StudentSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    ValidFields.nullChecker(
      data,
      requiredKeys: ['fullName', 'email', 'password', 'personalTrainingId'],
      nonNullKeys: ['fullName', 'email', 'password', 'personalTrainingId'],
    );
    fullName = data['fullName'] as String;
    email = data['email'] as String;
    password = data['password'] as String;
    personalTrainingId = data['personalTrainingId'] as int;
  }
}
