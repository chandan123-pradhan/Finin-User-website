import 'package:naukri_user/models/job_data_model.dart';
import 'package:naukri_user/models/job_details_model.dart';

class GetJobDetailsApiResponse {
  GetJobDetailsApiResponse({
    required this.data,
    required this.message,
    required this.status,
  });
  late final JobDetails data;
  late final String message;
  late final String status;
  
  GetJobDetailsApiResponse.fromJson(Map<String, dynamic> json){
    data = JobDetails.fromJson(json['data']);
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

