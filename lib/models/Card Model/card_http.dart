class Post {
  String? id;
  String? name;
  String? about;
  String? photo;

  Post({this.id, this.name, this.about, this.photo});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        about = json['about'],
        photo = json['photo'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'about': about,
        'userId': photo,
      };
}
