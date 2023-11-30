

import 'package:inventory_control/ui/utils/string_extensions.dart';

class ValidatorTextField {
  static String? genericDecimalValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Campo requerido";
    } else if (double.tryParse(s) != null) {
      double? value = double.tryParse(s);
      if (value! <= 0) {
        return "No puede ser menor o igual que 0";
      }
    }
  }

  static String? genericNumberValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Campo requerido";
    } else if (int.tryParse(s) != null) {
      int? value = int.tryParse(s);
      if (value! < 0) {
        return "No puede ser menor que 0";
      }
    } else {
      return "Campo debe de ser un número entero";
    }
  }

  static String? genericStringValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Campo requerido";
    }
  }

  String? password;
  static String? userNameValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Nombre de usuario es requerido";
    }
    if (s.length < 5) {
      return "Nombre de usuario no es lo suficientemente largo";
    }
  }

  static String? emailValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Correo es requerido";
    }
    if (!s.isValidEmail()) {
      return "Correo electronico invalido";
    }
  }

  static String? passwordValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Contraseña es requerida";
    }
    if (!s.isValidPassword()) {
      return "Tu contraseña no es lo suficientemente grande";
    }
  }

  String? passwordConfirmationValidator(String? s, String? password) {
    if (s == null || s.isWhitespace()) {
      return "Confirmación de contraseña es requerida";
    }
    if (s != password) {
      return "Confirmación mala, intenta de nuevo";
    }
  }

  static String? telephoneValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Número de celular requerido.";
    }
    if (!RegExp(r"^(\+505)?[578]\d{7}$").hasMatch(s)) {
      return "Número telefónico no es correcto.";
    }
  }
    
  static String? dniValidator(String? s) {
    if (s == null || s.isWhitespace()) {
      return "Cédula requerida.";
    }
    if (!RegExp(r'^\d{3}-\d{6}-\d{4}[A-Z]$').hasMatch(s)) {
      return "Cédula no es correcta";
    }
  }
}
