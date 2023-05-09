abstract class Validator<T> {
  final T value;

  Validator(this.value);

  bool isValid();
}
