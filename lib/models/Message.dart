class NewsPost {
  String id;
  String title;
  String description;
  String location;
  String publishTime;
  String image;
  List<String> arrangement;

  NewsPost(
      {this.id,
      this.title,
      this.description,
      this.location,
      this.publishTime,
      this.image,
      this.arrangement});

  NewsPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    publishTime = json['publishTime'];
    image = json['image'];
    arrangement = json['arrangement'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['publishTime'] = this.publishTime;
    data['image'] = this.image;
    data['arrangement'] = this.arrangement;
    return data;
  }
}
