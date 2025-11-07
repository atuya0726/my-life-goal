// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mandala_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MandalaChartImpl _$$MandalaChartImplFromJson(Map<String, dynamic> json) =>
    _$MandalaChartImpl(
      id: json['id'] as String,
      centerGoal: json['centerGoal'] as String,
      middleGoals:
          (json['middleGoals'] as List<dynamic>?)
              ?.map((e) => MiddleGoal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MandalaChartImplToJson(_$MandalaChartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'centerGoal': instance.centerGoal,
      'middleGoals': instance.middleGoals,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
