class Validation {
  static String? validatePassword(String? passwordInput) {
    if (passwordInput == null) {
      return 'Password empty';
    }

    if (passwordInput.length < 6) {
      return 'Password required minimum 6 characters';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null) {
      return 'Email empty';
    }

    bool isValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!isValid) {
      return 'Email invalid';
    }
    return null;
  }
}