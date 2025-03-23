class CustomBlocException {
  const CustomBlocException(this.message);

  final dynamic message;

  @override
  String toString() {
    return message.toString();
  }
}
