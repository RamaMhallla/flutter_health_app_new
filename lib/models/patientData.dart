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


/** This is an auto generated class representing the PatientData type in your schema. */
class PatientData extends amplify_core.Model {
  static const classType = const _PatientDataModelType();
  final String id;
  final amplify_core.TemporalDateTime? _timestamp;
  final int? _age;
  final Gender? _gender;
  final ChestPain? _chestPain;
  final bool? _exerciseAngina;
  final double? _cholesterol;
  final int? _numberOfVessels;
  final Thalassemia? _thalassemia;
  final bool? _fastingBloodSugar;
  final int? _bloodPressure;
  final int? _restingEcg;
  final int? _maxHeartRate;
  final double? _stDepression;
  final int? _slope;
  final double? _output;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PatientDataModelIdentifier get modelIdentifier {
    try {
      return PatientDataModelIdentifier(
        id: id,
        timestamp: _timestamp!
      );
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get timestamp {
    try {
      return _timestamp!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get age {
    return _age;
  }
  
  Gender? get gender {
    return _gender;
  }
  
  ChestPain? get chestPain {
    return _chestPain;
  }
  
  bool? get exerciseAngina {
    return _exerciseAngina;
  }
  
  double? get cholesterol {
    return _cholesterol;
  }
  
  int? get numberOfVessels {
    return _numberOfVessels;
  }
  
  Thalassemia? get thalassemia {
    return _thalassemia;
  }
  
  bool? get fastingBloodSugar {
    return _fastingBloodSugar;
  }
  
  int? get bloodPressure {
    return _bloodPressure;
  }
  
  int? get restingEcg {
    return _restingEcg;
  }
  
  int? get maxHeartRate {
    return _maxHeartRate;
  }
  
  double? get stDepression {
    return _stDepression;
  }
  
  int? get slope {
    return _slope;
  }
  
  double? get output {
    return _output;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const PatientData._internal({required this.id, required timestamp, age, gender, chestPain, exerciseAngina, cholesterol, numberOfVessels, thalassemia, fastingBloodSugar, bloodPressure, restingEcg, maxHeartRate, stDepression, slope, output, createdAt, updatedAt}): _timestamp = timestamp, _age = age, _gender = gender, _chestPain = chestPain, _exerciseAngina = exerciseAngina, _cholesterol = cholesterol, _numberOfVessels = numberOfVessels, _thalassemia = thalassemia, _fastingBloodSugar = fastingBloodSugar, _bloodPressure = bloodPressure, _restingEcg = restingEcg, _maxHeartRate = maxHeartRate, _stDepression = stDepression, _slope = slope, _output = output, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory PatientData({String? id, required amplify_core.TemporalDateTime timestamp, int? age, Gender? gender, ChestPain? chestPain, bool? exerciseAngina, double? cholesterol, int? numberOfVessels, Thalassemia? thalassemia, bool? fastingBloodSugar, int? bloodPressure, int? restingEcg, int? maxHeartRate, double? stDepression, int? slope, double? output}) {
    return PatientData._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      timestamp: timestamp,
      age: age,
      gender: gender,
      chestPain: chestPain,
      exerciseAngina: exerciseAngina,
      cholesterol: cholesterol,
      numberOfVessels: numberOfVessels,
      thalassemia: thalassemia,
      fastingBloodSugar: fastingBloodSugar,
      bloodPressure: bloodPressure,
      restingEcg: restingEcg,
      maxHeartRate: maxHeartRate,
      stDepression: stDepression,
      slope: slope,
      output: output);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PatientData &&
      id == other.id &&
      _timestamp == other._timestamp &&
      _age == other._age &&
      _gender == other._gender &&
      _chestPain == other._chestPain &&
      _exerciseAngina == other._exerciseAngina &&
      _cholesterol == other._cholesterol &&
      _numberOfVessels == other._numberOfVessels &&
      _thalassemia == other._thalassemia &&
      _fastingBloodSugar == other._fastingBloodSugar &&
      _bloodPressure == other._bloodPressure &&
      _restingEcg == other._restingEcg &&
      _maxHeartRate == other._maxHeartRate &&
      _stDepression == other._stDepression &&
      _slope == other._slope &&
      _output == other._output;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PatientData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.format() : "null") + ", ");
    buffer.write("age=" + (_age != null ? _age!.toString() : "null") + ", ");
    buffer.write("gender=" + (_gender != null ? amplify_core.enumToString(_gender)! : "null") + ", ");
    buffer.write("chestPain=" + (_chestPain != null ? amplify_core.enumToString(_chestPain)! : "null") + ", ");
    buffer.write("exerciseAngina=" + (_exerciseAngina != null ? _exerciseAngina!.toString() : "null") + ", ");
    buffer.write("cholesterol=" + (_cholesterol != null ? _cholesterol!.toString() : "null") + ", ");
    buffer.write("numberOfVessels=" + (_numberOfVessels != null ? _numberOfVessels!.toString() : "null") + ", ");
    buffer.write("thalassemia=" + (_thalassemia != null ? amplify_core.enumToString(_thalassemia)! : "null") + ", ");
    buffer.write("fastingBloodSugar=" + (_fastingBloodSugar != null ? _fastingBloodSugar!.toString() : "null") + ", ");
    buffer.write("bloodPressure=" + (_bloodPressure != null ? _bloodPressure!.toString() : "null") + ", ");
    buffer.write("restingEcg=" + (_restingEcg != null ? _restingEcg!.toString() : "null") + ", ");
    buffer.write("maxHeartRate=" + (_maxHeartRate != null ? _maxHeartRate!.toString() : "null") + ", ");
    buffer.write("stDepression=" + (_stDepression != null ? _stDepression!.toString() : "null") + ", ");
    buffer.write("slope=" + (_slope != null ? _slope!.toString() : "null") + ", ");
    buffer.write("output=" + (_output != null ? _output!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PatientData copyWith({int? age, Gender? gender, ChestPain? chestPain, bool? exerciseAngina, double? cholesterol, int? numberOfVessels, Thalassemia? thalassemia, bool? fastingBloodSugar, int? bloodPressure, int? restingEcg, int? maxHeartRate, double? stDepression, int? slope, double? output}) {
    return PatientData._internal(
      id: id,
      timestamp: timestamp,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      chestPain: chestPain ?? this.chestPain,
      exerciseAngina: exerciseAngina ?? this.exerciseAngina,
      cholesterol: cholesterol ?? this.cholesterol,
      numberOfVessels: numberOfVessels ?? this.numberOfVessels,
      thalassemia: thalassemia ?? this.thalassemia,
      fastingBloodSugar: fastingBloodSugar ?? this.fastingBloodSugar,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      restingEcg: restingEcg ?? this.restingEcg,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      stDepression: stDepression ?? this.stDepression,
      slope: slope ?? this.slope,
      output: output ?? this.output);
  }
  
  PatientData copyWithModelFieldValues({
    ModelFieldValue<int?>? age,
    ModelFieldValue<Gender?>? gender,
    ModelFieldValue<ChestPain?>? chestPain,
    ModelFieldValue<bool?>? exerciseAngina,
    ModelFieldValue<double?>? cholesterol,
    ModelFieldValue<int?>? numberOfVessels,
    ModelFieldValue<Thalassemia?>? thalassemia,
    ModelFieldValue<bool?>? fastingBloodSugar,
    ModelFieldValue<int?>? bloodPressure,
    ModelFieldValue<int?>? restingEcg,
    ModelFieldValue<int?>? maxHeartRate,
    ModelFieldValue<double?>? stDepression,
    ModelFieldValue<int?>? slope,
    ModelFieldValue<double?>? output
  }) {
    return PatientData._internal(
      id: id,
      timestamp: timestamp,
      age: age == null ? this.age : age.value,
      gender: gender == null ? this.gender : gender.value,
      chestPain: chestPain == null ? this.chestPain : chestPain.value,
      exerciseAngina: exerciseAngina == null ? this.exerciseAngina : exerciseAngina.value,
      cholesterol: cholesterol == null ? this.cholesterol : cholesterol.value,
      numberOfVessels: numberOfVessels == null ? this.numberOfVessels : numberOfVessels.value,
      thalassemia: thalassemia == null ? this.thalassemia : thalassemia.value,
      fastingBloodSugar: fastingBloodSugar == null ? this.fastingBloodSugar : fastingBloodSugar.value,
      bloodPressure: bloodPressure == null ? this.bloodPressure : bloodPressure.value,
      restingEcg: restingEcg == null ? this.restingEcg : restingEcg.value,
      maxHeartRate: maxHeartRate == null ? this.maxHeartRate : maxHeartRate.value,
      stDepression: stDepression == null ? this.stDepression : stDepression.value,
      slope: slope == null ? this.slope : slope.value,
      output: output == null ? this.output : output.value
    );
  }
  
  PatientData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalDateTime.fromString(json['timestamp']) : null,
      _age = (json['age'] as num?)?.toInt(),
      _gender = amplify_core.enumFromString<Gender>(json['gender'], Gender.values),
      _chestPain = amplify_core.enumFromString<ChestPain>(json['chestPain'], ChestPain.values),
      _exerciseAngina = json['exerciseAngina'],
      _cholesterol = (json['cholesterol'] as num?)?.toDouble(),
      _numberOfVessels = (json['numberOfVessels'] as num?)?.toInt(),
      _thalassemia = amplify_core.enumFromString<Thalassemia>(json['thalassemia'], Thalassemia.values),
      _fastingBloodSugar = json['fastingBloodSugar'],
      _bloodPressure = (json['bloodPressure'] as num?)?.toInt(),
      _restingEcg = (json['restingEcg'] as num?)?.toInt(),
      _maxHeartRate = (json['maxHeartRate'] as num?)?.toInt(),
      _stDepression = (json['stDepression'] as num?)?.toDouble(),
      _slope = (json['slope'] as num?)?.toInt(),
      _output = (json['output'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'timestamp': _timestamp?.format(), 'age': _age, 'gender': amplify_core.enumToString(_gender), 'chestPain': amplify_core.enumToString(_chestPain), 'exerciseAngina': _exerciseAngina, 'cholesterol': _cholesterol, 'numberOfVessels': _numberOfVessels, 'thalassemia': amplify_core.enumToString(_thalassemia), 'fastingBloodSugar': _fastingBloodSugar, 'bloodPressure': _bloodPressure, 'restingEcg': _restingEcg, 'maxHeartRate': _maxHeartRate, 'stDepression': _stDepression, 'slope': _slope, 'output': _output, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'timestamp': _timestamp,
    'age': _age,
    'gender': _gender,
    'chestPain': _chestPain,
    'exerciseAngina': _exerciseAngina,
    'cholesterol': _cholesterol,
    'numberOfVessels': _numberOfVessels,
    'thalassemia': _thalassemia,
    'fastingBloodSugar': _fastingBloodSugar,
    'bloodPressure': _bloodPressure,
    'restingEcg': _restingEcg,
    'maxHeartRate': _maxHeartRate,
    'stDepression': _stDepression,
    'slope': _slope,
    'output': _output,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PatientDataModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PatientDataModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static final AGE = amplify_core.QueryField(fieldName: "age");
  static final GENDER = amplify_core.QueryField(fieldName: "gender");
  static final CHESTPAIN = amplify_core.QueryField(fieldName: "chestPain");
  static final EXERCISEANGINA = amplify_core.QueryField(fieldName: "exerciseAngina");
  static final CHOLESTEROL = amplify_core.QueryField(fieldName: "cholesterol");
  static final NUMBEROFVESSELS = amplify_core.QueryField(fieldName: "numberOfVessels");
  static final THALASSEMIA = amplify_core.QueryField(fieldName: "thalassemia");
  static final FASTINGBLOODSUGAR = amplify_core.QueryField(fieldName: "fastingBloodSugar");
  static final BLOODPRESSURE = amplify_core.QueryField(fieldName: "bloodPressure");
  static final RESTINGECG = amplify_core.QueryField(fieldName: "restingEcg");
  static final MAXHEARTRATE = amplify_core.QueryField(fieldName: "maxHeartRate");
  static final STDEPRESSION = amplify_core.QueryField(fieldName: "stDepression");
  static final SLOPE = amplify_core.QueryField(fieldName: "slope");
  static final OUTPUT = amplify_core.QueryField(fieldName: "output");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PatientData";
    modelSchemaDefinition.pluralName = "PatientData";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.READ,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id", "timestamp"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.TIMESTAMP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.AGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.GENDER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.CHESTPAIN,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.EXERCISEANGINA,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.CHOLESTEROL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.NUMBEROFVESSELS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.THALASSEMIA,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.FASTINGBLOODSUGAR,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.BLOODPRESSURE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.RESTINGECG,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.MAXHEARTRATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.STDEPRESSION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.SLOPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: PatientData.OUTPUT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
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

class _PatientDataModelType extends amplify_core.ModelType<PatientData> {
  const _PatientDataModelType();
  
  @override
  PatientData fromJson(Map<String, dynamic> jsonData) {
    return PatientData.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'PatientData';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [PatientData] in your schema.
 */
class PatientDataModelIdentifier implements amplify_core.ModelIdentifier<PatientData> {
  final String id;
  final amplify_core.TemporalDateTime timestamp;

  /**
   * Create an instance of PatientDataModelIdentifier using [id] the primary key.
   * And [timestamp] the sort key.
   */
  const PatientDataModelIdentifier({
    required this.id,
    required this.timestamp});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id,
    'timestamp': timestamp
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PatientDataModelIdentifier(id: $id, timestamp: $timestamp)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PatientDataModelIdentifier &&
      id == other.id &&
      timestamp == other.timestamp;
  }
  
  @override
  int get hashCode =>
    id.hashCode ^
    timestamp.hashCode;
}