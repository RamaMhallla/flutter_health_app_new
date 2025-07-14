/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Patient type in your schema. */
class Patient extends amplify_core.Model {
  static const classType = const _PatientModelType();
  final String id;
  final String? _name;
  final int? _age;
  final String? _gender;
  final String? _chestPainType;
  final bool? _exerciseAngina;
  final double? _cholesterol;
  final bool? _fbs;
  final int? _restecg;
  final int? _trestbps;
  final int? _thalach;
  final double? _oldpeak;
  final int? _slope;
  final int? _ca;
  final int? _thal;
  final String? _result;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PatientModelIdentifier get modelIdentifier {
      return PatientModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get age {
    try {
      return _age!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get gender {
    try {
      return _gender!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get chestPainType {
    try {
      return _chestPainType!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get exerciseAngina {
    try {
      return _exerciseAngina!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get cholesterol {
    try {
      return _cholesterol!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get fbs {
    try {
      return _fbs!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get restecg {
    try {
      return _restecg!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get trestbps {
    try {
      return _trestbps!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get thalach {
    try {
      return _thalach!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get oldpeak {
    try {
      return _oldpeak!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get slope {
    try {
      return _slope!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get ca {
    try {
      return _ca!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get thal {
    try {
      return _thal!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get result {
    try {
      return _result!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Patient._internal({required this.id, required name, required age, required gender, required chestPainType, required exerciseAngina, required cholesterol, required fbs, required restecg, required trestbps, required thalach, required oldpeak, required slope, required ca, required thal, required result, createdAt, updatedAt}): _name = name, _age = age, _gender = gender, _chestPainType = chestPainType, _exerciseAngina = exerciseAngina, _cholesterol = cholesterol, _fbs = fbs, _restecg = restecg, _trestbps = trestbps, _thalach = thalach, _oldpeak = oldpeak, _slope = slope, _ca = ca, _thal = thal, _result = result, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Patient({String? id, required String name, required int age, required String gender, required String chestPainType, required bool exerciseAngina, required double cholesterol, required bool fbs, required int restecg, required int trestbps, required int thalach, required double oldpeak, required int slope, required int ca, required int thal, required String result, amplify_core.TemporalDateTime? createdAt}) {
    return Patient._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      age: age,
      gender: gender,
      chestPainType: chestPainType,
      exerciseAngina: exerciseAngina,
      cholesterol: cholesterol,
      fbs: fbs,
      restecg: restecg,
      trestbps: trestbps,
      thalach: thalach,
      oldpeak: oldpeak,
      slope: slope,
      ca: ca,
      thal: thal,
      result: result,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Patient &&
      id == other.id &&
      _name == other._name &&
      _age == other._age &&
      _gender == other._gender &&
      _chestPainType == other._chestPainType &&
      _exerciseAngina == other._exerciseAngina &&
      _cholesterol == other._cholesterol &&
      _fbs == other._fbs &&
      _restecg == other._restecg &&
      _trestbps == other._trestbps &&
      _thalach == other._thalach &&
      _oldpeak == other._oldpeak &&
      _slope == other._slope &&
      _ca == other._ca &&
      _thal == other._thal &&
      _result == other._result &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Patient {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("age=" + (_age != null ? _age!.toString() : "null") + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("chestPainType=" + "$_chestPainType" + ", ");
    buffer.write("exerciseAngina=" + (_exerciseAngina != null ? _exerciseAngina!.toString() : "null") + ", ");
    buffer.write("cholesterol=" + (_cholesterol != null ? _cholesterol!.toString() : "null") + ", ");
    buffer.write("fbs=" + (_fbs != null ? _fbs!.toString() : "null") + ", ");
    buffer.write("restecg=" + (_restecg != null ? _restecg!.toString() : "null") + ", ");
    buffer.write("trestbps=" + (_trestbps != null ? _trestbps!.toString() : "null") + ", ");
    buffer.write("thalach=" + (_thalach != null ? _thalach!.toString() : "null") + ", ");
    buffer.write("oldpeak=" + (_oldpeak != null ? _oldpeak!.toString() : "null") + ", ");
    buffer.write("slope=" + (_slope != null ? _slope!.toString() : "null") + ", ");
    buffer.write("ca=" + (_ca != null ? _ca!.toString() : "null") + ", ");
    buffer.write("thal=" + (_thal != null ? _thal!.toString() : "null") + ", ");
    buffer.write("result=" + "$_result" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Patient copyWith({String? name, int? age, String? gender, String? chestPainType, bool? exerciseAngina, double? cholesterol, bool? fbs, int? restecg, int? trestbps, int? thalach, double? oldpeak, int? slope, int? ca, int? thal, String? result, amplify_core.TemporalDateTime? createdAt}) {
    return Patient._internal(
      id: id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      chestPainType: chestPainType ?? this.chestPainType,
      exerciseAngina: exerciseAngina ?? this.exerciseAngina,
      cholesterol: cholesterol ?? this.cholesterol,
      fbs: fbs ?? this.fbs,
      restecg: restecg ?? this.restecg,
      trestbps: trestbps ?? this.trestbps,
      thalach: thalach ?? this.thalach,
      oldpeak: oldpeak ?? this.oldpeak,
      slope: slope ?? this.slope,
      ca: ca ?? this.ca,
      thal: thal ?? this.thal,
      result: result ?? this.result,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Patient copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<int>? age,
    ModelFieldValue<String>? gender,
    ModelFieldValue<String>? chestPainType,
    ModelFieldValue<bool>? exerciseAngina,
    ModelFieldValue<double>? cholesterol,
    ModelFieldValue<bool>? fbs,
    ModelFieldValue<int>? restecg,
    ModelFieldValue<int>? trestbps,
    ModelFieldValue<int>? thalach,
    ModelFieldValue<double>? oldpeak,
    ModelFieldValue<int>? slope,
    ModelFieldValue<int>? ca,
    ModelFieldValue<int>? thal,
    ModelFieldValue<String>? result,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdAt
  }) {
    return Patient._internal(
      id: id,
      name: name == null ? this.name : name.value,
      age: age == null ? this.age : age.value,
      gender: gender == null ? this.gender : gender.value,
      chestPainType: chestPainType == null ? this.chestPainType : chestPainType.value,
      exerciseAngina: exerciseAngina == null ? this.exerciseAngina : exerciseAngina.value,
      cholesterol: cholesterol == null ? this.cholesterol : cholesterol.value,
      fbs: fbs == null ? this.fbs : fbs.value,
      restecg: restecg == null ? this.restecg : restecg.value,
      trestbps: trestbps == null ? this.trestbps : trestbps.value,
      thalach: thalach == null ? this.thalach : thalach.value,
      oldpeak: oldpeak == null ? this.oldpeak : oldpeak.value,
      slope: slope == null ? this.slope : slope.value,
      ca: ca == null ? this.ca : ca.value,
      thal: thal == null ? this.thal : thal.value,
      result: result == null ? this.result : result.value,
      createdAt: createdAt == null ? this.createdAt : createdAt.value
    );
  }
  
  Patient.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _age = (json['age'] as num?)?.toInt(),
      _gender = json['gender'],
      _chestPainType = json['chestPainType'],
      _exerciseAngina = json['exerciseAngina'],
      _cholesterol = (json['cholesterol'] as num?)?.toDouble(),
      _fbs = json['fbs'],
      _restecg = (json['restecg'] as num?)?.toInt(),
      _trestbps = (json['trestbps'] as num?)?.toInt(),
      _thalach = (json['thalach'] as num?)?.toInt(),
      _oldpeak = (json['oldpeak'] as num?)?.toDouble(),
      _slope = (json['slope'] as num?)?.toInt(),
      _ca = (json['ca'] as num?)?.toInt(),
      _thal = (json['thal'] as num?)?.toInt(),
      _result = json['result'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'age': _age, 'gender': _gender, 'chestPainType': _chestPainType, 'exerciseAngina': _exerciseAngina, 'cholesterol': _cholesterol, 'fbs': _fbs, 'restecg': _restecg, 'trestbps': _trestbps, 'thalach': _thalach, 'oldpeak': _oldpeak, 'slope': _slope, 'ca': _ca, 'thal': _thal, 'result': _result, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'age': _age,
    'gender': _gender,
    'chestPainType': _chestPainType,
    'exerciseAngina': _exerciseAngina,
    'cholesterol': _cholesterol,
    'fbs': _fbs,
    'restecg': _restecg,
    'trestbps': _trestbps,
    'thalach': _thalach,
    'oldpeak': _oldpeak,
    'slope': _slope,
    'ca': _ca,
    'thal': _thal,
    'result': _result,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PatientModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PatientModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final AGE = amplify_core.QueryField(fieldName: "age");
  static final GENDER = amplify_core.QueryField(fieldName: "gender");
  static final CHESTPAINTYPE = amplify_core.QueryField(fieldName: "chestPainType");
  static final EXERCISEANGINA = amplify_core.QueryField(fieldName: "exerciseAngina");
  static final CHOLESTEROL = amplify_core.QueryField(fieldName: "cholesterol");
  static final FBS = amplify_core.QueryField(fieldName: "fbs");
  static final RESTECG = amplify_core.QueryField(fieldName: "restecg");
  static final TRESTBPS = amplify_core.QueryField(fieldName: "trestbps");
  static final THALACH = amplify_core.QueryField(fieldName: "thalach");
  static final OLDPEAK = amplify_core.QueryField(fieldName: "oldpeak");
  static final SLOPE = amplify_core.QueryField(fieldName: "slope");
  static final CA = amplify_core.QueryField(fieldName: "ca");
  static final THAL = amplify_core.QueryField(fieldName: "thal");
  static final RESULT = amplify_core.QueryField(fieldName: "result");
  static final CREATEDAT = amplify_core.QueryField(fieldName: "createdAt");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Patient";
    modelSchemaDefinition.pluralName = "Patients";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.AGE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.GENDER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.CHESTPAINTYPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.EXERCISEANGINA,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.CHOLESTEROL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.FBS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.RESTECG,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.TRESTBPS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.THALACH,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.OLDPEAK,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.SLOPE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.CA,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.THAL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.RESULT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Patient.CREATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _PatientModelType extends amplify_core.ModelType<Patient> {
  const _PatientModelType();
  
  @override
  Patient fromJson(Map<String, dynamic> jsonData) {
    return Patient.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Patient';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Patient] in your schema.
 */
class PatientModelIdentifier implements amplify_core.ModelIdentifier<Patient> {
  final String id;

  /** Create an instance of PatientModelIdentifier using [id] the primary key. */
  const PatientModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PatientModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PatientModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}