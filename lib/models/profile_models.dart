class ProfileModel {
  final String name;
  final String telephone;
  final String email;
  final String urlImg;

  ProfileModel({
    required this.name,
    required this.telephone,
    required this.email,
    required this.urlImg,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      telephone: json['telephone'],
      email: json['email'],
      urlImg: json['urlImg'],
    );
  }
}
