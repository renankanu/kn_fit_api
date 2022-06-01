import 'package:json_annotation/json_annotation.dart';

part 'gender_enum.g.dart';

@JsonEnum(alwaysCreate: true)
enum Gender {
  @JsonValue(1)
  female,
  @JsonValue(2)
  male,
  @JsonValue(3)
  other,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.female:
        return 'Feminino';
      case Gender.male:
        return 'Masculino';
      default:
        return 'Outro';
    }
  }

  int get value {
    switch (this) {
      case Gender.female:
        return 1;
      case Gender.male:
        return 2;
      default:
        return 3;
    }
  }
}

extension EnumGenderType on String {
  Gender get enumType {
    switch (toString()) {
      case 'female':
        return Gender.female;
      case 'male':
        return Gender.male;
      default:
        return Gender.other;
    }
  }
}
