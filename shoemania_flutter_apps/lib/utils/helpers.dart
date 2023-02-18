import 'package:intl/intl.dart';

class Helpers {
  static String convertToIdr(dynamic number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }

  static bool passwordValidate(String password) {
    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password)) {
      return false;
    }
    return true;
  }

  static bool phoneValidate(String phone) {
    if (phone.length > 13) {
      return false;
    }
    if (!RegExp(r'^(?=.*?[0-9])$').hasMatch(phone)) {
      return false;
    }
    return true;
  }

  static bool postalCodeValidate(String postalCode) {
    if (!RegExp(r'^(?=.*?[0-9])$').hasMatch(postalCode)) {
      return false;
    }
    return true;
  }

  static bool emailValidate(String email) {
    final pattern = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!pattern.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool nameValidate(String name) {
    if (RegExp(r'[a-zA-Z ]+$').hasMatch(name)) {
      return false;
    }
    return true;
  }

  // static bool postalCodeValidate(String name) {
  //   if (RegExp(r'[0-9]+$').hasMatch(name)) {
  //     return false;
  //   }
  //   return true;
  // }
}
