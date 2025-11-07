// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FocusTaskListImpl _$$FocusTaskListImplFromJson(Map<String, dynamic> json) =>
    _$FocusTaskListImpl(
      pendingTaskIds:
          (json['pendingTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dailyTaskIds:
          (json['dailyTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      weeklyTaskIds:
          (json['weeklyTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      monthlyTaskIds:
          (json['monthlyTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      yearlyTaskIds:
          (json['yearlyTaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      pendingOriginalPeriods:
          (json['pendingOriginalPeriods'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FocusTaskListImplToJson(_$FocusTaskListImpl instance) =>
    <String, dynamic>{
      'pendingTaskIds': instance.pendingTaskIds,
      'dailyTaskIds': instance.dailyTaskIds,
      'weeklyTaskIds': instance.weeklyTaskIds,
      'monthlyTaskIds': instance.monthlyTaskIds,
      'yearlyTaskIds': instance.yearlyTaskIds,
      'pendingOriginalPeriods': instance.pendingOriginalPeriods,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
