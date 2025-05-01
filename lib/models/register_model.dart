

import 'dart:io';

class RegisterModel {
  String fullName;
  String emailId;
  String heighestQualification;
  String password;
  String confirmPassword;
  String mobileNumber;
  File  profilePic;
  String prefferedLocation;
  String prefferedSallary;
  String skills;
  String prefferedShift;
  String empType;
  String description;

  RegisterModel({
    required this.fullName,
    required this.emailId,
    required this.heighestQualification,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
    required this.profilePic,
    required this.prefferedLocation,
    required this.prefferedSallary,
    required this.skills,
    required this.prefferedShift,
    required this.empType,
    required this.description
  });

}