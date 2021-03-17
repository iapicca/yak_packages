// ignore_for_file: one_member_abstracts

import 'package:meta/meta.dart';

import '../../archivist.dart';

/// an interface a read only map of `timestamp` for documents
abstract class Archive {
  /// allow const constructors
  /// doesn't use `const Archive._();` othwrwise extended classes complains
  @internal
  const Archive();

  /// returns a `timestamp` for a document
  int? operator [](String documentId);

  /// provide the lowest `timestamp` or null
  int? get first;

  /// provide the higher `timestamp` or null
  int? get last;

  /// create a read only Archive
  factory Archive.archive(Map<String, int> map) => _Archive(map);
}

class _Archive extends Archive {
  final Map<String, int> _map;

  @override
  final int? first;

  @override
  final int? last;

  _Archive(Map<String, int> map)
      : _map = Map.unmodifiable(map),
        first = map.values.sorted.first,
        last = map.values.sorted.last;

  @override
  int? operator [](String documentId) => _map[documentId];
}
