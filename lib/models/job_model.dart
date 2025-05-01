
class JobModel {
  JobModel({
    required this.jobId,
    required this.jobTitle,
    required this.jobDescription,
    required this.qualification,
    required this.noOfRequirements,
    required this.contactEmail,
    required this.contactNumber,
    required this.jobLocation,
    required this.skills,
    required this.status,
    required this.companyId,
    required this.companyLogo,
    required this.companyName,
  });
  late final int jobId;
  late final String jobTitle;
  late final String jobDescription;
  late final String qualification;
  late final int noOfRequirements;
  late final String contactEmail;
  late final String contactNumber;
  late final String jobLocation;
  late final String skills;
  late final String status;
  late final int companyId;
  late final String companyLogo;
  late final String companyName;
  
  JobModel.fromJson(Map<String, dynamic> json){
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    jobDescription = json['job_description'];
    qualification = json['qualification'];
    noOfRequirements = json['no_of_requirements'];
    contactEmail = json['contact_email'];
    contactNumber = json['contact_number'];
    jobLocation = json['job_location'];
    skills = json['skills'];
    status = json['status'];
    companyId = json['company_id'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['job_id'] = jobId;
    _data['job_title'] = jobTitle;
    _data['job_description'] = jobDescription;
    _data['qualification'] = qualification;
    _data['no_of_requirements'] = noOfRequirements;
    _data['contact_email'] = contactEmail;
    _data['contact_number'] = contactNumber;
    _data['job_location'] = jobLocation;
    _data['skills'] = skills;
    _data['status'] = status;
    _data['company_id'] = companyId;
    _data['company_logo'] = companyLogo;
    _data['company_name'] = companyName;
    return _data;
  }
}