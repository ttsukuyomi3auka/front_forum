// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      status: $enumDecode(_$ReviewStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'status': _$ReviewStatusEnumMap[instance.status]!,
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.pending: 'pending',
  ReviewStatus.rejected: 'rejected',
  ReviewStatus.approved: 'approved',
};
