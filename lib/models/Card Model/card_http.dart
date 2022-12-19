class Post {
  String? id;
  String? name;
  String? about;
  String? photo;
  String? header;
  Post({this.id, this.name, this.about, this.photo, this.header});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        about = json['about'],
        photo = json['photo'],
        header = json['header'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'about': about,
        'photo': photo,
        'header': header,
      };
}
