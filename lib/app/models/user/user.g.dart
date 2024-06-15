// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      username: json['username'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      aboutMe: json['aboutMe'] as String? ?? "",
      role: $enumDecode(_$RolesEnumMap, json['role']),
      posts:
          (json['posts'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      areas:
          (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'surname': instance.surname,
      'aboutMe': instance.aboutMe,
      'role': _$RolesEnumMap[instance.role]!,
      'posts': instance.posts,
      'comments': instance.comments,
      'areas': instance.areas,
    };

const _$RolesEnumMap = {
  Roles.admin: 'admin',
  Roles.moderator: 'moderator',
  Roles.user: 'user',
  Roles.baned: 'baned',
  Roles.unknow: 'unknow',
};
