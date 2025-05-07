import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? validateEmail(BuildContext context, String? email) {
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return AppLocalizations.of(context)!.mailAlert;
  }
  return null;
}

String? validatePassword(BuildContext context, String? password) {
  RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,20}$');
  final isPasswordValid = passwordRegex.hasMatch(password ?? '');
  if (!isPasswordValid) {
    return AppLocalizations.of(context)!.passwordAlert;
  }
  return null;
}

String? validateName(BuildContext context, String? name) {
  RegExp nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');
  final isNameValid = nameRegex.hasMatch(name ?? '');
  if (!isNameValid) {
    return AppLocalizations.of(context)!.nameAlert;
  }
  return null;
}
