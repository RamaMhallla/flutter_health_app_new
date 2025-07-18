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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the patientData type in your schema. */
class patientData extends amplify_core.Model {
  static const classType = const _patientDataModelType();
  final String id;
  final String? _time;
  final List<String>? _input;
  final String? _output;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  patientDataModelIdentifier get modelIdentifier {
      return patientDataModelIdentifier(
        id: id
      );
  }
  
  String get time {
    try {
      return _time!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get input {
    return _input;
  }
  
  String? get output {
    return _output;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const patientData._internal({required this.id, required time, input, output, createdAt, updatedAt}): _time = time, _input = input, _output = output, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory patientData({String? id, required String time, List<String>? input, String? output}) {
    return patientData._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      time: time,
      input: input != null ? List<String>.unmodifiable(input) : input,
      output: output);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is patientData &&
      id == other.id &&
      _time == other._time &&
      DeepCollectionEquality().equals(_input, other._input) &&
      _output == other._output;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("patientData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("time=" + "$_time" + ", ");
    buffer.write("input=" + (_input != null ? _input!.toString() : "null") + ", ");
    buffer.write("output=" + "$_output" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  patientData copyWith({String? time, List<String>? input, String? output}) {
    return patientData._internal(
      id: id,
      time: time ?? this.time,
      input: input ?? this.input,
      output: output ?? this.output);
  }
  
  patientData copyWithModelFieldValues({
    ModelFieldValue<String>? time,
    ModelFieldValue<List<String>?>? input,
    ModelFieldValue<String?>? output
  }) {
    return patientData._internal(
      id: id,
      time: time == null ? this.time : time.value,
      input: input == null ? this.input : input.value,
      output: output == null ? this.output : output.value
    );
  }
  
  patientData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _time = json['time'],
      _input = json['input']?.cast<String>(),
      _output = json['output'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'time': _time, 'input': _input, 'output': _output, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'time': _time,
    'input': _input,
    'output': _output,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<patientDataModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<patientDataModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TIME = amplify_core.QueryField(fieldName: "time");
  static final INPUT = amplify_core.QueryField(fieldName: "input");
  static final OUTPUT = amplify_core.QueryField(fieldName: "output");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "patientData";
    modelSchemaDefinition.pluralName = "patientData";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: patientData.TIME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: patientData.INPUT,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: patientData.OUTPUT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _patientDataModelType extends amplify_core.ModelType<patientData> {
  const _patientDataModelType();
  
  @override
  patientData fromJson(Map<String, dynamic> jsonData) {
    return patientData.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'patientData';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [patientData] in your schema.
 */
class patientDataModelIdentifier implements amplify_core.ModelIdentifier<patientData> {
  final String id;

  /** Create an instance of patientDataModelIdentifier using [id] the primary key. */
  const patientDataModelIdentifier({
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
  String toString() => 'patientDataModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is patientDataModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}