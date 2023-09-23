import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  String? description;
  String? address;
  Timestamp? startDate;
  Timestamp? finishDate;
  String? location;
  String? imageUrl;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.startDate,
    required this.finishDate,
    required this.location,
    required this.imageUrl,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? address,
    Timestamp? startDate,
    Timestamp? finishDate,
    String? location,
    String? imageUrl,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? title,
      description: description ?? description,
      address: address ?? address,
      startDate: startDate ?? startDate,
      finishDate: finishDate ?? finishDate,
      location: location ?? location,
      imageUrl: imageUrl ?? imageUrl,
    );
  }
}
