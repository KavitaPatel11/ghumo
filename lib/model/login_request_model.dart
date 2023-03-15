class LoginRequestModel {
  LoginRequestModel({
    this.phone,
  
  });
  late final String? phone;
 

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    
    return _data;
  }
}