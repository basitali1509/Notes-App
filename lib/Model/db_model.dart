class Notes {
  int? id;
  String title;
  String subtitle;
  String description;
  int? priority;

  Notes({
     this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.priority,
  }) ;


  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'subtitle' : subtitle,
      'description' : description,
      'priority' : priority,
    };
  }
}
