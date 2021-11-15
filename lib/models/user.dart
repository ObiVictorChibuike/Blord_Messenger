
class UserField {
  static final String lastMessageTime = '';
}

class AuthUser {
  String idUser;
  String email;
  String username;
  String? name;
  String? phoneNumber;
  bool? isOnline;
  String urlAvatar;
  String? lastMessageTime;

  AuthUser({
    required this.idUser,
    required this.email,
    required this.username,
    required this.phoneNumber,
    this.isOnline = true,
    required this.name,
    required this.urlAvatar,
    this.lastMessageTime,
  });

  static AuthUser fromJson(Map<String, dynamic> json) => AuthUser(
        idUser: json['idUser'],
        email: json['email'],
        username: json['username'],
        phoneNumber: json['phoneNumber'] ?? null,
        isOnline: json['isOnline'],
        name: json['name'] ?? null,
        urlAvatar: json['urlAvatar'],
        lastMessageTime: json['lastMessageTime'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'email': email,
        'username': username,
        'phoneNumber': phoneNumber ?? null,
        'isOnline': isOnline,
        'name': name ?? null,
        'urlAvatar': urlAvatar,
        'lastMessageTime': lastMessageTime ?? null,
      };
}
