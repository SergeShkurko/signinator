import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signinator/features/features.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse implements TokenResponse {
  @Implements<TokenResponse>()
  const factory LoginResponse({
    int? id,
    String? token,
    String? error,
  }) = _LoginResponse;

  const LoginResponse._();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Login toEntity() => Login(token: token);
}
