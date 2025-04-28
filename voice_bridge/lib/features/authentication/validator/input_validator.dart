class InputValidator {
  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return "Name cannot be empty.";
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return "Email cannot be empty.";
    }
    // Simple regex for email
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty.";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters.";
    }
    return null;
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Please confirm your password.";
    }
    if (password != confirmPassword) {
      return "Passwords do not match.";
    }
    return null;
  }
}
