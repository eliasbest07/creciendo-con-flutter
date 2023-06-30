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

class ProyectStorageFailed implements Exception {
  final String message;

  ProyectStorageFailed(this.message);

  @override
  String toString() {
    return "ProyectStorageFailed: $message";
  }
}

class MetaStorageFailed implements Exception {
  final String message;

  MetaStorageFailed(this.message);

  @override
  String toString() {
    return "MetaStorageFailed: $message";
  }
}

class TareaStorageFailed implements Exception {
  final String message;

  TareaStorageFailed(this.message);

  @override
  String toString() {
    return "TareaStorageFailed: $message";
  }
}

class CommentMetaStorageFailed implements Exception {
  final String message;

  CommentMetaStorageFailed(this.message);

  @override
  String toString() {
    return "CommentMetaStorageFailed: $message";
  }
}

class CommentTareaStorageFailed implements Exception {
  final String message;

  CommentTareaStorageFailed(this.message);

  @override
  String toString() {
    return "CommentTareaStorageFailed: $message";
  }
}
