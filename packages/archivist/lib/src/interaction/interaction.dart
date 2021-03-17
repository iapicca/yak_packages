import '../../archivist.dart';

/// an interface for interaction
abstract class Interaction {
  const Interaction._();

  /// returns the `timestamp` for a document interaction`
  int? operator [](String documentId);

  /// update the document interaction
  void update(String documentId);

  /// delete the document interaction
  void clear(String documentId);

  /// an implementation of `Interaction`
  /// `now defailts to `nowUtcUnix`
  const factory Interaction([TimeStamp now]) = _Interaction._;
}

class _Interaction extends Interaction {
  final TimeStamp _now;

  final Map<String, int> _map;

  const _Interaction._([this._now = nowUtcUnix])
      : _map = const {},
        super._();

  @override
  int? operator [](String documentId) => _map[documentId];

  @override
  void update(String documentId) => _map.containsKey(documentId)
      ? _map.putIfAbsent(documentId, _now)
      : _map[documentId] = _now();

  @override
  void clear(String documentId) => _map.remove(documentId);
}
