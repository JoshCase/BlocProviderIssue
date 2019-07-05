class Topic {
  final String name;
  final String iconPath;
  final String id;

  Topic({
    this.name,
    this.iconPath = 'assets/levels/default.png',
    this.id = 'exampleTopicID',
  });

  Topic.fromJson(dynamic json)
      : this.name = json['name'],
        this.iconPath = 'assets/levels/default.png',
        this.id = json['id'];
}
