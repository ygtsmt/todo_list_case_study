class TodoModel {
  String? id;
  String? title;
  String? description;
  String? address;
  String? startDate;
  String? finishDate;
  String? location;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.startDate,
    required this.finishDate,
    required this.location,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? address,
    String? startDate,
    String? finishDate,
    String? location,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? title,
      description: description ?? description,
      address: address ?? address,
      startDate: startDate ?? startDate,
      finishDate: finishDate ?? finishDate,
      location: location ?? location,
      
    );
  }
}
