class Major {
  final int? id;
  final int? universityId;
  final String? majorName;

  Major({
    this.id,
    this.universityId,
    this.majorName,
  });

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      id: json['majorId'],
      universityId: json['universityId'],
      majorName: json['majorName'],
    );
  }
}
