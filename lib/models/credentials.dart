class Credentials {
  final String? title;
  final String? username;
  final String? password;
  final String? note;
  final bool? favorited;
  final DateTime? dateCreated;

  const Credentials({this.title, this.username, this.password, this.note, this.favorited = false, this.dateCreated});

  Credentials.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      username = json['username'],
      password = json['password'],
      note = json['note'],
      favorited = json['favorited'],
      dateCreated = DateTime.tryParse(json['dateCreated']);

  Map<String, dynamic> toJson() => {
    'title': title,
    'username': username,
    'password': password,
    'note': note,
    'favorited': favorited,
    'dateCreated': dateCreated.toString(),
  };

  @override
  String toString() {
    return 'Credentials{title: $title, username: $username, password: $username, note: $note, favorited: $favorited, dateCreated: $dateCreated}';
  }
}
