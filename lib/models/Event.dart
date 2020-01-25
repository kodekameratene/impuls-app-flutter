class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final String image;
  final List<dynamic> arrangement;

  Event({
    this.id,
    this.title,
    this.startTime,
    this.endTime,
    this.location,
    this.image,
    this.description,
    this.arrangement,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var startTime = json['startTime'].runtimeType == String
        ? DateTime.parse(json['startTime'])
        : null;
    var endTime = json['endTime'].runtimeType == String
        ? DateTime.parse(json['endTime'])
        : null;

    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      startTime: startTime,
      endTime: endTime,
      image: json['image'] as String,
      arrangement: json['arrangement'],
    );
  }
}
