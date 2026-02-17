import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:equatable/equatable.dart';

class SignUpModel extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String password;
  final String image;
  final String phone;
  final bool isHidden;

  const SignUpModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.image,
    required this.phone,
    required this.isHidden,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> data) {
    return SignUpModel(
      id: data[ApiKey.id] ?? 0,
      userName: data[ApiKey.userName] ?? "default_name",
      email: data[ApiKey.email] ?? "default_email@gmail.com",
      password: data[ApiKey.password] ?? "default123",
      image: data[ApiKey.image] ?? "default_path",
      phone: data[ApiKey.phone] ?? "default",
      isHidden: true,
    );
  }

  SignUpModel copyWith({bool? isHidden}) {
    return SignUpModel(
      id: id,
      userName: userName,
      email: email,
      password: password,
      image: image,
      phone: phone,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  List<Object> get props => [
    id,
    userName,
    email,
    phone,
    password,
    image,
    phone,
  ];
}
