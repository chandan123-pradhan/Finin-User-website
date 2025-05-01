
class EmploymentHistory {
  EmploymentHistory({
    required this.employerName,
    required this.designation,
    required this.startDate,
    required this.endDate,
  });
  late final String employerName;
  late final String designation;
  late final String startDate;
  late final String endDate;
  
  EmploymentHistory.fromJson(Map<String, dynamic> json){
    employerName = json['employer_name'];
    designation = json['designation'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer_name'] = employerName;
    _data['designation'] = designation;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    return _data;
  }
}