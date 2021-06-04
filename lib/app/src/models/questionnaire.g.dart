// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questionnaire _$QuestionnaireFromJson(Map<String, dynamic> json) {
  return Questionnaire(
    id: json['Id'] as int,
    sequence: json['Sequence'] as int,
    questionnaireGroup: json['QuestionnaireGroup'] as String,
    question: json['Question'] as String,
    isEnabled: json['IsEnabled'] as bool,
    isDeleted: json['IsDeleted'] as bool,
    answer: (json['Options'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userOption: (json['UserOption'] as List)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..userOptionTemp = json['userOptionTemp'] == null
      ? null
      : Option.fromJson(json['userOptionTemp'] as Map<String, dynamic>);
}

Map<String, dynamic> _$QuestionnaireToJson(Questionnaire instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Sequence', instance.sequence);
  writeNotNull('QuestionnaireGroup', instance.questionnaireGroup);
  writeNotNull('Question', instance.question);
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('IsDeleted', instance.isDeleted);
  writeNotNull('Options', instance.answer?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'UserOption', instance.userOption?.map((e) => e?.toJson())?.toList());
  val['userOptionTemp'] = instance.userOptionTemp?.toJson();
  return val;
}

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['Id'] as int,
    masterQuestionnaireId: json['MasterQuestionnaireId'] as int,
    value: json['Value'] as String,
    description: json['Description'] as String,
    isEnabled: json['IsEnabled'] as bool,
    isDeleted: json['IsDeleted'] as bool,
    isSelected: json['isSelected'] as bool ?? false,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('MasterQuestionnaireId', instance.masterQuestionnaireId);
  writeNotNull('Value', instance.value);
  writeNotNull('Description', instance.description);
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('IsDeleted', instance.isDeleted);
  val['isSelected'] = instance.isSelected;
  return val;
}

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    id: json['Id'] as int,
    userId: json['UserId'] as String,
    masterQuestionnaireId: json['MasterQuestionnaireId'] as int,
    masterQuestionnaireOptionId: json['MasterQuestionnaireOptionId'] as int,
  );
}

Map<String, dynamic> _$OptionToJson(Option instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('UserId', instance.userId);
  writeNotNull('MasterQuestionnaireId', instance.masterQuestionnaireId);
  writeNotNull(
      'MasterQuestionnaireOptionId', instance.masterQuestionnaireOptionId);
  return val;
}

AnswerBody _$AnswerBodyFromJson(Map<String, dynamic> json) {
  return AnswerBody(
    id: json['id'] as int,
    userId: json['userId'] as String,
    masterQuestionnaireId: json['masterQuestionnaireId'] as int,
    masterQuestionnaireOptionId: json['masterQuestionnaireOptionId'] as int,
  );
}

Map<String, dynamic> _$AnswerBodyToJson(AnswerBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('masterQuestionnaireId', instance.masterQuestionnaireId);
  writeNotNull(
      'masterQuestionnaireOptionId', instance.masterQuestionnaireOptionId);
  return val;
}

ResponseListQuestionnaire _$ResponseListQuestionnaireFromJson(
    Map<String, dynamic> json) {
  return ResponseListQuestionnaire(
    status: json['Status'] as bool,
    message: json['Messages'] as String,
    code: json['Code'] as String,
    result: (json['Result'] as List)
        ?.map((e) => e == null
            ? null
            : Questionnaire.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseListQuestionnaireToJson(
        ResponseListQuestionnaire instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Messages': instance.message,
      'Code': instance.code,
      'Result': instance.result?.map((e) => e?.toJson())?.toList(),
    };
