import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String role;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.role,
      required this.profilePicture});

  //Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Username': username,
      'Email': email,
      'Role': role,
      'ProfilePicture': profilePicture
    };
  }

  //Función para crear usuario vacío
  static UserModel emptyUser() => UserModel(
      id: '',
      name: '',
      username: '',
      email: '',
      profilePicture: '',
      role: 'cliente');

  //Función para crear un UserModel desde un documento(registro) de Firebase
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        role: data['Role'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return emptyUser();
    }
  }
}
