

class ConnectionTimeout implements Exception {}
class InvalidToken implements Exception {}
class WrongCredentials implements Exception {}

class CustomError implements Exception {
  final String message;
  // final bool loggedRequired; [this.loggedRequired = false]

  // final int errorCode;
  CustomError(this.message, );
}