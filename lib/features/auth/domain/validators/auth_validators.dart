class AuthValidators {
  // Minimum age requirement constant
  static const int minAgeYears = 13;

  static String? validatePhone(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces, dashes, and +95 prefix if user typed it or local 0
    String cleaned = input.replaceAll(RegExp(r'[\s-]'), '');
    if (cleaned.startsWith('+95')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    // Result must start with 9 and contain digits only.
    final phoneRegex = RegExp(r'^9\d+$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Invalid phone number format (e.g., 09254135592)';
    }

    // Length must be between 8 and 10 digits after cleaning
    if (cleaned.length < 8 || cleaned.length > 10) {
      return 'Phone number must be between 8 and 10 digits';
    }

    return null;
  }

  static String? validateFirstName(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'First name is required';
    }

    // Name length must be under 50 characters
    final trimmed = input.trim();
    if (trimmed.length > 50) {
      return 'Must be under 50 characters';
    }

    // Allows letters, spaces, and Myanmar unicode blocks
    final nameRegex = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!nameRegex.hasMatch(trimmed)) {
      return 'Only letters and spaces are allowed';
    }

    return null;
  }

  static String? validateLastName(String? input) {
    if (input == null || input.trim().isEmpty) return null;

    return validateFirstName(input);
  }

  static String? validateDateOfBirth(DateTime? dob) {
    if (dob == null) {
      return 'Date of birth is required';
    }

    // Date of birth cannot be in the future
    final now = DateTime.now();
    if (dob.isAfter(now)) {
      return 'Date of birth cannot be in the future';
    }

    // Calculate age
    int age = now.year - dob.year;
    final birthdayThisYear = DateTime(now.year, dob.month, dob.day);
    if (now.isBefore(birthdayThisYear)) {
      age--;
    }

    // Age must be at least minAgeYears
    if (age < minAgeYears) {
      return 'You must be at least $minAgeYears years old';
    }
    return null;
  }
}
