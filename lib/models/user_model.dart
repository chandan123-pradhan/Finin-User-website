
import 'package:naukri_user/models/employment_data_model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.fullName,
    required this.emailId,
    required this.highestQualification,
    required this.mobileNumber,
    required this.profileImageUrl,
    required this.employmentHistory,
    required this.prefferedLocation,
    required this.prefferedSallary,
    required this.prefferedShift,
    required this.employmentType,
    required this.description,
    required this.skills,
  });
  late final int id;
  late final String fullName;
  late final String emailId;
  late final String highestQualification;
  late final String mobileNumber;
  late final String profileImageUrl;
  late final List<EmploymentHistory> employmentHistory;
  late final String prefferedLocation;
  late final String prefferedSallary;
  late final String prefferedShift;
  late final String employmentType;
  late final String description;
  late final String skills;
  
  
  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullName = json['full_name'];
    emailId = json['email_id'];
    highestQualification = json['highest_qualification'];
    mobileNumber = json['mobile_number'];
    profileImageUrl = json['profile_image_url'];
    prefferedLocation = json['preffered_location'];
    prefferedSallary = json['preffered_sallary'];
    prefferedShift = json['preffered_shift'];
    employmentType = json['employment_type'];
    description = json['description'];
    skills = json['skills'];
    employmentHistory = List.from(json['employment_history']??[]).map((e)=>EmploymentHistory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    _data['email_id'] = emailId;
    _data['highest_qualification'] = highestQualification;
    _data['mobile_number'] = mobileNumber;
    _data['profile_image_url'] = profileImageUrl;
    _data['preffered_location'] = prefferedLocation;
    _data['preffered_sallary'] = prefferedSallary;
    _data['preffered_shift'] = prefferedShift;
    _data['employment_type'] = employmentType;
    _data['description'] = description;
    _data['skills'] = skills;
    _data['employment_history'] = employmentHistory.map((e)=>e.toJson()).toList();
    return _data;
  }
}