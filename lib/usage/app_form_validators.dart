import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:flutter/material.dart';

class AppFormValidators {
  static String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  static String validateUsername(String value) {
    if (value.toString().trim() == "")
      return 'Enter a valid username';
    else
      return null;
  }

  static String validatePassword(String value) {
    if (value.toString().trim() == "") return 'Enter a password';
    if (value.toString().trim().length < 6)
      return 'Password must be 6 characters long';
    else
      return null;
  }

  static validateAndSave(
      GlobalKey<FormState> _formKey, Function() onValid) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await onValid();
    } else {
      print('Form is invalid');
    }
  }

  /*static List<EnumChangePasswordValidator> changePasswordTextFieldsValidators(String password){
    List<EnumChangePasswordValidator> invalidatedFields = [];
    if(password.length < 8 || password.length > 30)
      invalidatedFields.add(EnumChangePasswordValidator.MustBe8_30Characters);
    if(!password.toLowerCase().contains(new RegExp(r'[a-z]')))
      invalidatedFields.add(EnumChangePasswordValidator.MustIncludeALetter);
    if(!password.contains(new RegExp(r'[0-9]')))
      invalidatedFields.add(EnumChangePasswordValidator.MustIncludeNumbers);
    if(!password.contains(new RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]")))
      invalidatedFields.add(EnumChangePasswordValidator.MustIncludeSpecialCharacter);

    return invalidatedFields;
    return invalidatedFields.isEmpty ? null : invalidatedFields;
  }*/
}
