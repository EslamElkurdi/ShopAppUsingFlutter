

class CreateUserModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  bool? isEmailVerified;

  CreateUserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified,
});

  CreateUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    email = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'phone' : phone,
      'email' : email,
      'isEmailVerified' : isEmailVerified,
    };
  }

}