class BadRequestException implements Exception {
  final String message;
  final Map<String, dynamic> errors;

  BadRequestException({
    required this.message,
    required this.errors,
  });
}