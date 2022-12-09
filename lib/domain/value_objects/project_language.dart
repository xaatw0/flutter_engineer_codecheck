import 'package:flutter_engineer_codecheck/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// 該当リポジトリのプロジェクト言語
class ProjectLanguage extends ValueObject<String?> {
  ProjectLanguage(super.value);
}

class ProjectLanguageConverter
    implements JsonConverter<ProjectLanguage, String?> {
  const ProjectLanguageConverter();

  @override
  ProjectLanguage fromJson(String? jsonData) {
    return ProjectLanguage(jsonData);
  }

  @override
  String toJson(ProjectLanguage object) {
    return object.toString();
  }
}
