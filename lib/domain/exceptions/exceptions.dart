class UserNotFound implements Exception {
  final String message;

  UserNotFound(this.message);

  @override
  String toString() {
    return "UserNotFound: $message";
  }
}

class SignUpFailed implements Exception {
  final String message;

  SignUpFailed(this.message);

  @override
  String toString() {
    return "SignUpFailed: $message";
  }
}

class UserStorageFailed implements Exception {
  final String message;

  UserStorageFailed(this.message);

  @override
  String toString() {
    return "UserStorageFailed: $message";
  }
}
