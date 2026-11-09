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

  static String? validateBirthMonth(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Month is required';
    }

    final month = _monthNumber(input.trim());
    if (month == null) {
      return 'Enter a valid month name, such as May';
    }

    return null;
  }

  static String? validateBirthDay(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Day is required';
    }

    final day = int.tryParse(input.trim());
    if (day == null || day < 1 || day > 31) {
      return 'Enter a day between 1 and 31';
    }

    return null;
  }

  static String? validateBirthYear(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Year is required';
    }

    final year = int.tryParse(input.trim());
    final currentYear = DateTime.now().year;
    if (year == null || year < 1900 || year > currentYear) {
      return 'Enter a valid year';
    }

    return null;
  }

  static int? parseBirthMonth(String input) => _monthNumber(input.trim());

  static int? _monthNumber(String input) {
    final numericMonth = int.tryParse(input);
    if (numericMonth != null && numericMonth >= 1 && numericMonth <= 12) {
      return numericMonth;
    }

    final normalized = input.toLowerCase();
    const monthNames = <String, int>{
      'january': 1,
      'jan': 1,
      'february': 2,
      'feb': 2,
      'march': 3,
      'mar': 3,
      'april': 4,
      'apr': 4,
      'may': 5,
      'june': 6,
      'jun': 6,
      'july': 7,
      'jul': 7,
      'august': 8,
      'aug': 8,
      'september': 9,
      'sep': 9,
      'october': 10,
      'oct': 10,
      'november': 11,
      'nov': 11,
      'december': 12,
      'dec': 12,
    };
    return monthNames[normalized];
  }
}
