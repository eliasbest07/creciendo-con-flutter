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

class CommentPyStorageFailed implements Exception {
  final String message;

  CommentPyStorageFailed(this.message);

  @override
  String toString() {
    return "CommentPyStorageFailed: $message";
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

class ProyectSearchFailed implements Exception {
  final String message;

  ProyectSearchFailed(this.message);

  @override
  String toString() {
    return "ProyectSearchFailed: $message";
  }
}

class MetaSearchFailed implements Exception {
  final String message;

  MetaSearchFailed(this.message);

  @override
  String toString() {
    return "MetaSearchFailed: $message";
  }
}

class TareaSearchFailed implements Exception {
  final String message;

  TareaSearchFailed(this.message);

  @override
  String toString() {
    return "TareaSearchFailed: $message";
  }
}

class GetAllProyectsFailed implements Exception {
  final String message;

  GetAllProyectsFailed(this.message);

  @override
  String toString() {
    return "GetAllProyectsFailed: $message";
  }
}

class ProyectDeleteFailed implements Exception {
  final String message;

  ProyectDeleteFailed(this.message);

  @override
  String toString() {
    return "ProyectDeleteFailed: $message";
  }
}

class InsufficientPointsException implements Exception {
  final String message;

  InsufficientPointsException(this.message);

  @override
  String toString() {
    return "InsufficientPointsException: $message";
  }
}

class GetUserFailed implements Exception {
  final String message;

  GetUserFailed(this.message);

  @override
  String toString() {
    return "GetUserFailed: $message";
  }
}
