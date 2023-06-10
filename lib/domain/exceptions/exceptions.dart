class UserNotFound implements Exception {
  final String message;

  UserNotFound(this.message);
}

class SignUpFailed implements Exception {
  final String message;

  SignUpFailed(this.message);
}
