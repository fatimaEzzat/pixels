class Validator {
  static String? validateName(String? value) {
    if (value!.isEmpty || value.length < 3) {
      return 'Enter valid name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Can't be empty";
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Can't be empty";
    } else if (value.length < 6) {
      return 'The password must be at least 6 characters';
    }
    return null;
  }
}
