import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? code;
  @JsonKey(name: 'data')
  final Map<String, dynamic>? errors;
  ApiErrorModel({
    this.message,
    this.code,
    this.errors,
  });
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    if (errors != null && errors!.isNotEmpty) {
      return message ?? 'Unknown error';
    }
    final errorMessage = errors!.values.map((value) {
      return "${value.join(',')}";
    }).join('\n');
    return errorMessage;
  }
}
