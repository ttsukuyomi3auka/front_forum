// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['_id'] as String,
      data: json['data'] as String,
      likes: (json['likes'] as num).toInt(),
      status: $enumDecode(_$ReviewStatusEnumMap, json['status']),
      author: json['author'] as Map<String, dynamic>,
      date: DateTime.parse(json['date'] as String),
      post: json['post'] as String,
      children:
          (json['children'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'data': instance.data,
      'likes': instance.likes,
      'status': _$ReviewStatusEnumMap[instance.status]!,
      'author': instance.author,
      'date': instance.date.toIso8601String(),
      'post': instance.post,
      'children': instance.children,
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.pending: 'Pending',
  ReviewStatus.rejected: 'Rejected',
  ReviewStatus.approved: 'Approved',
};
