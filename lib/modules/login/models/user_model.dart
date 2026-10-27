

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String userCd;
    final String userName;

    UserModel({
        required this.userCd,
        required this.userName,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userCd: json["USER_CD"],
        userName: json["USER_NAME"],
    );

    Map<String, dynamic> toJson() => {
        "USER_CD": userCd,
        "USER_NAME": userName,
    };
}
