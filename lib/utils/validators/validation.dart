class DaVinciValidator {
  static String? validateEmptyText(String? fieldname, String? value) {
    if (value == null || value.isEmpty) {
      return 'Debes proporcionar un $fieldname';
    }

    return null;
  }

  static String? validateUsername(String? username) {
    return (username == null || username.isEmpty)
        ? 'Debes proporcionar un nombre de usuario'
        : (!RegExp(r'^[a-zA-Z0-9_-]{3,20}$').hasMatch(username))
            ? 'Nombre de usuario incorrecto'
            : (username.startsWith('_') ||
                    username.startsWith('-') ||
                    username.endsWith('_') ||
                    username.endsWith('-'))
                ? 'El nombre de usuario no puede comenzar ni terminar con guiones'
                : null;
  }

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
}
