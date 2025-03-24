import 'dart:convert';
import 'package:intl/intl.dart';

class UserResult {
  UserResult({this.action, this.user});

  UserResult.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    if (json['user'] != null) {
      user = User.fromMap(json['user']);
    }
  }

  bool? action;
  User? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    if (user != null) {
      data['user'] = user?.toMap();
    }
    return data;
  }
}

class User {
  String? uM_CODE;
  String? uM_NAME;
  String? uM_MOBILE;
  DateTime? uM_DOB;
  bool? uM_CONSENT_STATUS;
  String? uM_ADDRESS;
  String? uM_ROLE;
  int? uM_MAX_BOOKS;
  DateTime? uM_LAST_LOGIN;
  DateTime? uM_REGISTRATION_DATE;
  String? uM_DEVICE_ID;

  User({
    this.uM_CODE,
    this.uM_NAME,
    this.uM_MOBILE,
    this.uM_DOB,
    this.uM_CONSENT_STATUS,
    this.uM_ADDRESS,
    this.uM_ROLE,
    this.uM_MAX_BOOKS,
    this.uM_LAST_LOGIN,
    this.uM_REGISTRATION_DATE,
    this.uM_DEVICE_ID,
  });

  Map<String, dynamic> toMap() {
    return {
      'uM_CODE': uM_CODE,
      'uM_NAME': uM_NAME,
      'uM_MOBILE': uM_MOBILE,
      'uM_DOB': uM_DOB?.toIso8601String(),
      'uM_CONSENT_STATUS': uM_CONSENT_STATUS,
      'uM_ADDRESS': uM_ADDRESS,
      'uM_ROLE': uM_ROLE,
      'uM_MAX_BOOKS': uM_MAX_BOOKS,
      'uM_LAST_LOGIN': uM_LAST_LOGIN?.toIso8601String(),
      'uM_REGISTRATION_DATE': uM_REGISTRATION_DATE?.toIso8601String(),
      'uM_DEVICE_ID': uM_DEVICE_ID,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uM_CODE: map['user_email'],
      uM_NAME: map['user_name'],
      uM_MOBILE: map['user_mobile'],
      uM_ADDRESS: map['user_address'],
      uM_DOB: map['user_dob'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['user_dob'])
          : null,
      uM_ROLE: map['user_role'],
      uM_CONSENT_STATUS: map['user_status'] == '1',
      uM_LAST_LOGIN: map['user_last_login'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(map['user_last_login'])
          : null,
      uM_DEVICE_ID: map['user_device_id'],
      uM_REGISTRATION_DATE: map['user_registration_date'] != null
          ? DateFormat('yyyy-MM-ddTHH:mm:ss')
              .parse(map['user_registration_date'])
          : null,
      uM_MAX_BOOKS: map['user_max_books'],
    );
  }
}
