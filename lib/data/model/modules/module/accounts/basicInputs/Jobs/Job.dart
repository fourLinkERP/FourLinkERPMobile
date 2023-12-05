

class Job {
  int? id;
  String? jobCode;
  String? jobNameAra ;
  String? jobNameEng;




  Job({
    this.id,
    this.jobCode,
    this.jobNameAra,
    this.jobNameEng,
    });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: (json['id'] != null) ? json['id'] as int : 0,
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as String : " ",
      jobNameAra: (json['jobNameAra'] != null)? json['jobNameAra'] as String : " ",
      jobNameEng: (json['jobNameEng'] != null) ? json['jobNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $jobNameAra }';
  }
}


