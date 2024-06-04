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

  static String? validateCvv(String? cvv) {
    return (cvv == null || cvv.isEmpty)
        ? 'Debes proporcionar un CVV'
        : (cvv.length != 3)
            ? 'El CVV debe tener exactamente 3 números'
            : !RegExp(r'^\d{3}$').hasMatch(cvv)
                ? 'El CVV solo puede contener números'
                : null;
  }

  static String? validateExpiryDate(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return 'Debes proporcionar una fecha de vencimiento';
    }
    final dateRegex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    if (!dateRegex.hasMatch(expiryDate)) {
      return 'El formato del vencimiento debe ser MM/AA';
    }
    final now = DateTime.now();
    final parts = expiryDate.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');
    final expiry = DateTime(year, month);

    if (expiry.isBefore(DateTime(now.year, now.month))) {
      return 'La fecha de vencimiento debe ser futura';
    }
    return null;
  }

  static String? validateCardNumber(String? cardNumber) {
    return (cardNumber == null || cardNumber.isEmpty)
        ? 'Debes proporcionar un número de tarjeta'
        : (cardNumber.length != 16)
            ? 'El número de tarjeta debe tener exactamente 16 dígitos'
            : !RegExp(r'^\d{16}$').hasMatch(cardNumber)
                ? 'El número de tarjeta solo puede contener números'
                : null;
  }
}
