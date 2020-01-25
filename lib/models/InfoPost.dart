class InfoPost {
  String id;
  String title;
  String description;
  int index;
  bool published;
  String image;
  List<String> arrangement;

  InfoPost(
      {this.id,
      this.title,
      this.description,
      this.index,
      this.published,
      this.image,
      this.arrangement});

  InfoPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    index = json['index'];
    published = json['published'];
    image = json['image'];
    arrangement = json['arrangement'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['index'] = this.index;
    data['published'] = this.published;
    data['image'] = this.image;
    data['arrangement'] = this.arrangement;
    return data;
  }
}
