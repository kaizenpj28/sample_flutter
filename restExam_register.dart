class Register {
  final String email;
  final String password;
  final String deviceId;
  final String appName;
  final String trial;
  final String platform;

  Register({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.appName,
    required this.trial,
    required this.platform,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'],
      password: json['password'],
      deviceId: json['deviceId'],
      appName: json['appName'],
      trial: json['trial'],
      platform: json['platform'],
    );
  }
}