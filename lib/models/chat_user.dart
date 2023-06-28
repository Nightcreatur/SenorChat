class ChatUser {
  ChatUser({
    required this.isOnline,
    required this.id,
    required this.createdAt,
    required this.pushToken,
    required this.image,
    required this.email,
    required this.about,
    required this.lastActive,
    required this.name,
  });
  late String id;
  late bool isOnline;
  late String createdAt;
  late String pushToken;
  late String image;
  late String email;
  late String about;
  late String lastActive;
  late String name;

  ChatUser.fromJson(Map<String, dynamic> json) {
    isOnline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    createdAt = json['created_at'] ?? '';
    pushToken = json['push_token'] ?? '';
    image = json['image'] ?? '';
    email = json['email'] ?? '';
    about = json['about'] ?? '';
    lastActive = json['last_active'] ?? '';
    name = json['name'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_online'] = isOnline;
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['push_token'] = pushToken;
    _data['image'] = image;
    _data['email'] = email;
    _data['about'] = about;
    _data['last_active'] = lastActive;
    _data['name'] = name;
    return _data;
  }
}
