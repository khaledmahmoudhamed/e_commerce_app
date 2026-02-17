import 'package:equatable/equatable.dart';

class SignInModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String userName;
  final String email;
  final String image;
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final int age;
  final String birthDate;
  final Address address;
  const SignInModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.userName,
    required this.email,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.age,
    required this.birthDate,
    required this.address,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      accessToken: json['accessToken'] ?? "",
      refreshToken: json['refreshToken'] ?? "",
      id: json['id'] ?? 0,
      userName: json['username'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      gender: json['gender'] ?? "",
      phone: json['phone'] ?? "01202715677",
      age: json['age'] ?? 25,
      birthDate: json['birthDate'] ?? "1-2-2002",
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address.fromJson({}),
    );
  }
  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    id,
    userName,
    email,
    image,
    firstName,
    lastName,
    gender,
  ];
}

class Address extends Equatable {
  final String address;
  final String city;
  final String state;
  final String stateCode;

  const Address({
    required this.state,
    required this.address,
    required this.city,
    required this.stateCode,
  });

  factory Address.fromJson(Map<String, dynamic> data) {
    return Address(
      state: data['state'] ?? "default_state",
      address: data['address'] ?? "default_address",
      city: data['city'] ?? "default_city",
      stateCode: data['stateCode'] ?? "default_state code",
    );
  }
  @override
  List<Object> get props => [state, stateCode, address, city];
}
