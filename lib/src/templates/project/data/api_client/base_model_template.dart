String baseModelTemplate() => '''
import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  const BaseModel({
    required this.id,
    this.dateCreated,
    this.lastUpdated,
  });
  final String id;
  final DateTime? dateCreated;
  final DateTime? lastUpdated;

  @override
  List<Object?> get props => [id, dateCreated, lastUpdated];
}
''';
