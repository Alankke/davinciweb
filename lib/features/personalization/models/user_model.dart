import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.profilePicture});

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Username': username,
      'Email': email,
      'ProfilePicture': profilePicture
    };
  }

  static UserModel emptyUser() =>
      UserModel(id: '', name: '', username: '', email: '', profilePicture: '');

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return emptyUser();
    }
  }
}
