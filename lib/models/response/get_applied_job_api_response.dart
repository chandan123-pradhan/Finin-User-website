class GetAppliedJobApiResponse {
  GetAppliedJobApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });
  late final AppliedJobData data;
  late final String message;
  late final String status;
  
  GetAppliedJobApiResponse.fromJson(Map<String, dynamic> json){
    data = AppliedJobData.fromJson(json['data']);
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}

class AppliedJobData {
  AppliedJobData({
    required this.jobs,
  });
  late final List<AppliedJob> jobs;
  
  AppliedJobData.fromJson(Map<String, dynamic> json){
    jobs = List.from(json['jobs']).map((e)=>AppliedJob.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jobs'] = jobs.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AppliedJob {
  AppliedJob({
    required this.JobID,
    required this.JobTitle,
    required this.JobDescription,
    required this.Qualification,
    required this.NoOfRequirements,
    required this.ContactEmail,
    required this.ContactNumber,
    required this.JobLocation,
    required this.Skills,
    required this.Status,
    required this.CompanyID,
    required this.CompanyName,
    required this.CompanyLogo,
    required this.ApplicationDate,
    required this.ApplicationStatus,
  });
  late final int JobID;
  late final String JobTitle;
  late final String JobDescription;
  late final String Qualification;
  late final int NoOfRequirements;
  late final String ContactEmail;
  late final String ContactNumber;
  late final String JobLocation;
  late final String Skills;
  late final String Status;
  late final int CompanyID;
  late final String CompanyName;
  late final String CompanyLogo;
  late final String ApplicationDate;
  late final String ApplicationStatus;
  
  AppliedJob.fromJson(Map<String, dynamic> json){
    JobID = json['JobID'];
    JobTitle = json['JobTitle'];
    JobDescription = json['JobDescription'];
    Qualification = json['Qualification'];
    NoOfRequirements = json['NoOfRequirements'];
    ContactEmail = json['ContactEmail'];
    ContactNumber = json['ContactNumber'];
    JobLocation = json['JobLocation'];
    Skills = json['Skills'];
    Status = json['Status'];
    CompanyID = json['CompanyID'];
    CompanyName = json['CompanyName'];
    CompanyLogo = json['CompanyLogo'];
    ApplicationDate = json['ApplicationDate'];
    ApplicationStatus = json['ApplicationStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['JobID'] = JobID;
    _data['JobTitle'] = JobTitle;
    _data['JobDescription'] = JobDescription;
    _data['Qualification'] = Qualification;
    _data['NoOfRequirements'] = NoOfRequirements;
    _data['ContactEmail'] = ContactEmail;
    _data['ContactNumber'] = ContactNumber;
    _data['JobLocation'] = JobLocation;
    _data['Skills'] = Skills;
    _data['Status'] = Status;
    _data['CompanyID'] = CompanyID;
    _data['CompanyName'] = CompanyName;
    _data['CompanyLogo'] = CompanyLogo;
    _data['ApplicationDate'] = ApplicationDate;
    _data['ApplicationStatus'] = ApplicationStatus;
    return _data;
  }
}