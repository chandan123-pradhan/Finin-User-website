
import 'package:naukri_user/models/job_model.dart';
import 'package:naukri_user/models/response/get_jobs_api_response.dart';

class JobData {
  JobData({
    required this.jobs,
  });
  late final List<JobModel> jobs;
  
  JobData.fromJson(Map<String, dynamic> json){
    jobs = List.from(json['jobs']).map((e)=>JobModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jobs'] = jobs.map((e)=>e.toJson()).toList();
    return _data;
  }
}