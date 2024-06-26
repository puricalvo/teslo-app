import "package:formz/formz.dart";
 
// Define input validation errors
// enum NameError {empty, length, format}
enum NameError {empty, length}
 
// Extend FormzInput and provide the input type and error type.
class FullName extends FormzInput<String, NameError> {
 
  // Call super.pure to represent an unmodified form input.
  const FullName.pure() : super.pure("");
 
  // Call super.dirty to represent a modified form input.
  const FullName.dirty( super.value) : super.dirty();
 
  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == NameError.empty) return "El campo es requerido";
    if (displayError == NameError.length) return "Mínimo 6 caracteres";
 
    return null;
  }
 
  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
 
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 6) return NameError.length;
 
    return null;
  }
}