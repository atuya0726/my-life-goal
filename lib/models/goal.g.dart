// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmallGoalImpl _$$SmallGoalImplFromJson(Map<String, dynamic> json) =>
    _$SmallGoalImpl(
      id: json['id'] as String,
      position: (json['position'] as num).toInt(),
      title: json['title'] as String,
      status:
          $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
          GoalStatus.notStarted,
      memo: json['memo'] as String? ?? '',
    );

Map<String, dynamic> _$$SmallGoalImplToJson(_$SmallGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'title': instance.title,
      'status': _$GoalStatusEnumMap[instance.status]!,
      'memo': instance.memo,
    };

const _$GoalStatusEnumMap = {
  GoalStatus.notStarted: 'notStarted',
  GoalStatus.inProgress: 'inProgress',
  GoalStatus.completed: 'completed',
};

_$MiddleGoalImpl _$$MiddleGoalImplFromJson(Map<String, dynamic> json) =>
    _$MiddleGoalImpl(
      id: json['id'] as String,
      position: (json['position'] as num).toInt(),
      title: json['title'] as String,
      smallGoals:
          (json['smallGoals'] as List<dynamic>?)
              ?.map((e) => SmallGoal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status:
          $enumDecodeNullable(_$GoalStatusEnumMap, json['status']) ??
          GoalStatus.notStarted,
      memo: json['memo'] as String? ?? '',
    );

Map<String, dynamic> _$$MiddleGoalImplToJson(_$MiddleGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'title': instance.title,
      'smallGoals': instance.smallGoals,
      'status': _$GoalStatusEnumMap[instance.status]!,
      'memo': instance.memo,
    };
