class DaVinciValidator {
  static String? validateEmail(String? email) {
    return (email == null || email.isEmpty)
        ? 'Debes proporcionar un email'
        : (!RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                .hasMatch(email))
            ? 'Email incorrecto'
            : null;
  }

  static String? validatePassword(String? password) {
    return (password == null || password.isEmpty)
        ? 'Debes proporcionar una contraseña'
        : (password.length < 8)
            ? 'La contraseña debe tener mínimo 8 caracteres'
            : (!password.contains(RegExp(r'[A-Z]')))
                ? 'La contraseña debe tener mínimo una letra mayúscula'
                : (!password.contains(RegExp(r'[0-9]')))
                    ? 'La contraseña debe tener mínimo un número'
                    : (!password.contains(RegExp(r'[!@#$%&*(),.?":{}|<>]')))
                        ? 'La contraseña debe tener mínimo un carácter especial'
                        : null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    return (phoneNumber == null || phoneNumber.isEmpty)
        ? 'Debes proporcionar un teléfono'
        : (!RegExp(r'^\+54\d{10}$').hasMatch(phoneNumber))
            ? 'Teléfono incorrecto'
            : null;
  }
}
