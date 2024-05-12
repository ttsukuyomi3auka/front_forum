import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  factory ApiResponse.loading() = _Loading;
  factory ApiResponse.success(T data) = _Success<T>;
  factory ApiResponse.failed(String message, Object? exception) = _Failed;
}