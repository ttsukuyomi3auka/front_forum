// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: $enumDecode(_$ReviewStatusEnumMap, json['status']),
      author: json['author'] as String,
      date: DateTime.parse(json['date'] as String),
      likes: (json['likes'] as num).toInt(),
      comments:
          (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
      areas: (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$ReviewStatusEnumMap[instance.status]!,
      'author': instance.author,
      'date': instance.date.toIso8601String(),
      'likes': instance.likes,
      'comments': instance.comments,
      'areas': instance.areas,
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.pending: 'Pending',
  ReviewStatus.rejected: 'Rejected',
  ReviewStatus.approved: 'Approved',
};
