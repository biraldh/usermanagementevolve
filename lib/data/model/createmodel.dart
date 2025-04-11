class CreateJobModel {
  final String name;
  final String job;

  CreateJobModel({required this.job,required this.name});

  factory CreateJobModel.fromJson(Map<String, dynamic> json) {
    return CreateJobModel(
      job: json['job'],
      name: json['name'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job' : job,
      'name': name,

    };
  }
}
