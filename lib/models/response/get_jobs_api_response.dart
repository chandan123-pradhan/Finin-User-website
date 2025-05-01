import 'package:naukri_user/models/job_data_model.dart';

class GetJobsApiResponse {
  GetJobsApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });
  late final JobData data;
  late final String message;
  late final String status;
  
  GetJobsApiResponse.fromJson(Map<String, dynamic> json){
    data = JobData.fromJson(json['data']);
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

