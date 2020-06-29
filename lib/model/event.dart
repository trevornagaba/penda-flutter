import 'package:flutter/foundation.dart';

/*
TO-DO Define event categories on expansion
 */
// enum Category {
//   all,
//   accessories,
//   clothing,
//   home,
// }

class Event {
  const Event({
    @required this.category,
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.targetAmount,
    @required this.currentAmount,
    @required this.dueDate,
    @required this.creator,
    @required this.contributors,
  })  : assert(category != null),
        assert(id != null),
        assert(description != null),
        assert(title != null),
        assert(targetAmount != null),
        assert(currentAmount != null),
        assert(dueDate != null),
        assert(creator != null),
        assert(contributors != null);

  final String category;
  final int id;
  final String title;
  final String description;
  final int targetAmount;
  final int currentAmount;
  final String dueDate;
  final String creator;
  final Map<String, int> contributors;

/*
TO-DO: Include image upload
 */
  // String get assetName => '$id-0.jpg';
  // String get assetPackage => 'shrine_images';

  // @override
  // String toString() => '$name (id=$id)';
}