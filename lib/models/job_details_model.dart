import 'package:naukri_user/models/job_model.dart';

class JobDetails {
  JobDetails({
    required this.jobPost,
    required this.applicantCount,
    required this.isApplied,
  });
  late final JobModel jobPost;
  late final int applicantCount;
  late final bool isApplied;
  
  JobDetails.fromJson(Map<String, dynamic> json){
    jobPost = JobModel.fromJson(json['jobPost']);
    applicantCount = json['applicantCount'];
    isApplied = json['isApplied'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jobPost'] = jobPost.toJson();
    _data['applicantCount'] = applicantCount;
    _data['isApplied'] = isApplied;
    return _data;
  }
}
