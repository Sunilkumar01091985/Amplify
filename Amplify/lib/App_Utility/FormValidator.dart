class FormValidator {
  static FormValidator _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

String formValidationWithIndex(int index,String value,int section){
  switch (index) {
    case 2:
      return (section == 0) ? validateEmail(value) : validatePassword(value);
      break;  
    case 4:
      return validatePassword(value);
      break;  
    default:
      return (value.length <= 0) ? "Please enter valid input" : null;
      break;
  }
}

  String validateEmail(String value) {
    String pattern =
        r'^(([^&<>()[\]\\.,;:\s@\"]+(\.[^&<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length < 8) {
      return "Password must contain minimum eight characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password enter valid password";
    }
    return null;
  }
  
}