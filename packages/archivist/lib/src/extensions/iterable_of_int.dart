import 'package:collection/collection.dart';

/// an extension on iterable of int
extension IterableOfIntX on Iterable<int> {
  /// returns a sorted list of int
  List<int> get sorted => [...this]..sort();

  /// return the smallest int
  int? get smallest => sorted.firstOrNull;

  /// return the biggest int
  int? get biggest => sorted.lastOrNull;
}
