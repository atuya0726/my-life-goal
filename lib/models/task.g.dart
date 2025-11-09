// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  smallGoalId: json['smallGoalId'] as String,
  period: $enumDecode(_$TaskPeriodEnumMap, json['period']),
  status: $enumDecode(_$TaskStatusEnumMap, json['status']),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'smallGoalId': instance.smallGoalId,
      'period': _$TaskPeriodEnumMap[instance.period]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'dueDate': instance.dueDate?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TaskPeriodEnumMap = {
  TaskPeriod.daily: 'daily',
  TaskPeriod.weekly: 'weekly',
  TaskPeriod.monthly: 'monthly',
  TaskPeriod.yearly: 'yearly',
  TaskPeriod.awareness: 'awareness',
};

const _$TaskStatusEnumMap = {
  TaskStatus.notStarted: 'notStarted',
  TaskStatus.inProgress: 'inProgress',
  TaskStatus.completed: 'completed',
};
