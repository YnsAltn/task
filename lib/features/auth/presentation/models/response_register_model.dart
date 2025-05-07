class RegisterResponseModel {
  String? token;
  RegisterResponseModel({this.token});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
