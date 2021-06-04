import 'package:json_annotation/json_annotation.dart';

part 'questionnaire.g.dart';

@JsonSerializable(explicitToJson: true)
class Questionnaire {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'Sequence', defaultValue: null, includeIfNull: false)
  final int sequence;

  @JsonKey(name: 'QuestionnaireGroup', defaultValue: null, includeIfNull: false)
  final String questionnaireGroup;

  @JsonKey(name: 'Question', defaultValue: null, includeIfNull: false)
  final String question;

  @JsonKey(name: 'IsEnabled', defaultValue: null, includeIfNull: false)
  final bool isEnabled;

  @JsonKey(name: 'IsDeleted', defaultValue: null, includeIfNull: false)
  final bool isDeleted;

  @JsonKey(name: 'Options', defaultValue: null, includeIfNull: false)
  final List<Answer> answer;

  @JsonKey(name: 'UserOption', defaultValue: null, includeIfNull: false)
  List<Option> userOption;

  @JsonKey(defaultValue: null)
  Option userOptionTemp;

  Questionnaire(
      {this.id,
      this.sequence,
      this.questionnaireGroup,
      this.question,
      this.isEnabled,
      this.isDeleted,
      this.answer,
      this.userOption});

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Answer {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(
      name: 'MasterQuestionnaireId', defaultValue: null, includeIfNull: false)
  final int masterQuestionnaireId;

  @JsonKey(name: 'Value', defaultValue: null, includeIfNull: false)
  final String value;

  @JsonKey(name: 'Description', defaultValue: null, includeIfNull: false)
  final String description;

  @JsonKey(name: 'IsEnabled', defaultValue: null, includeIfNull: false)
  bool isEnabled;

  @JsonKey(name: 'IsDeleted', defaultValue: null, includeIfNull: false)
  bool isDeleted;

  @JsonKey(defaultValue: false)
  bool isSelected;

  Answer(
      {this.id,
      this.masterQuestionnaireId,
      this.value,
      this.description,
      this.isEnabled,
      this.isDeleted,
      this.isSelected});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Option {
  @JsonKey(name: 'Id', defaultValue: null, includeIfNull: false)
  int id;

  @JsonKey(name: 'UserId', defaultValue: null, includeIfNull: false)
  String userId;

  @JsonKey(
      name: 'MasterQuestionnaireId', defaultValue: null, includeIfNull: false)
  int masterQuestionnaireId;

  @JsonKey(
      name: 'MasterQuestionnaireOptionId',
      defaultValue: null,
      includeIfNull: false)
  int masterQuestionnaireOptionId;

  Option(
      {this.id,
      this.userId,
      this.masterQuestionnaireId,
      this.masterQuestionnaireOptionId});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnswerBody {
  @JsonKey(name: 'id', defaultValue: null, includeIfNull: false)
  final int id;

  @JsonKey(name: 'userId', defaultValue: null, includeIfNull: false)
  final String userId;

  @JsonKey(
      name: 'masterQuestionnaireId', defaultValue: null, includeIfNull: false)
  final int masterQuestionnaireId;

  @JsonKey(
      name: 'masterQuestionnaireOptionId',
      defaultValue: null,
      includeIfNull: false)
  final int masterQuestionnaireOptionId;

  AnswerBody(
      {this.id,
      this.userId,
      this.masterQuestionnaireId,
      this.masterQuestionnaireOptionId});

  factory AnswerBody.fromJson(Map<String, dynamic> json) =>
      _$AnswerBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResponseListQuestionnaire {
  @JsonKey(name: 'Status', defaultValue: null, nullable: true)
  bool status;

  @JsonKey(name: 'Messages', defaultValue: null, nullable: true)
  String message;

  @JsonKey(name: 'Code', defaultValue: null, nullable: true)
  String code;

  @JsonKey(name: 'Result', defaultValue: null, nullable: true)
  List<Questionnaire> result;

  ResponseListQuestionnaire(
      {this.status, this.message, this.code, this.result});

  factory ResponseListQuestionnaire.fromJson(Map<String, dynamic> json) =>
      _$ResponseListQuestionnaireFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseListQuestionnaireToJson(this);
}
