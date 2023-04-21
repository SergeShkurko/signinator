import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signinator/features/features.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse implements TokenResponse {
  @Implements<TokenResponse>()
  const factory RegisterResponse({
    int? id,
    String? token,
    String? error,
  }) = _RegisterResponse;

  const RegisterResponse._();

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Register toEntity() => Register(token: token);
}
