String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return "Lütfen geçerli bir e-mail adresi giriniz.";
  }
  return null;
}

String? validatePassword(String? password) {
  RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,20}$');
  final isPasswordValid = passwordRegex.hasMatch(password ?? '');
  if (!isPasswordValid) {
    return "Şifre 6-20 karakter uzunluğunda ve alfanumerik olmalıdır.";
  }
  return null;
}

String? validateName(String? name) {
  RegExp nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');
  final isNameValid = nameRegex.hasMatch(name ?? '');
  if (!isNameValid) {
    return "Adınızı 'isim soyisim' şeklinde giriniz.";
  }
  return null;
}
