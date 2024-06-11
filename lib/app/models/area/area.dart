import 'package:freezed_annotation/freezed_annotation.dart';

part 'area.freezed.dart';
part 'area.g.dart';

@freezed
class AreaOfActivity with _$AreaOfActivity {
  factory AreaOfActivity({
    @JsonKey(name: "_id") required String id,
    required String title,
  }) = _AreaOfActivity;

  factory AreaOfActivity.fromJson(Map<String, dynamic> json) =>
      _$AreaOfActivityFromJson(json);
}
