import '../../archivist.dart';

/// an interface for interaction
abstract class Interaction extends Archive {
  const Interaction._();

  /// returns the `timestamp` for a document interaction`
  int? operator [](String documentId);

  /// update the document interaction
  void update(String documentId);

  /// delete the document interaction
  void clear(String documentId);

  /// an implementation of `Interaction`
  /// `now defailts to `nowUtcUnix`
  factory Interaction({TimeStamp? timeStamp}) = _Interaction._;

  /// "archives" the interaction making it read-only
  /// and disallowing update and clear
  Archive get archive;
}

class _Interaction extends Interaction {
  final TimeStamp _now;

  final Map<String, int> _map;

  _Interaction._({TimeStamp? timeStamp})
      : _now = timeStamp ?? nowUtcUnix,
        _map = {},
        super._();

  @override
  int? operator [](String documentId) => _map[documentId];

  @override
  void update(String documentId) => _map.containsKey(documentId)
      ? _map.putIfAbsent(documentId, _now)
      : _map[documentId] = _now();

  @override
  void clear(String documentId) => _map.remove(documentId);

  @override
  int? get first => _map.values.first;

  @override
  int? get last => _map.values.last;

  @override
  Archive get archive => Archive.archive(_map);
}
