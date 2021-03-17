import 'package:archivist/archivist.dart';
import 'package:test/test.dart';

import '../stub/all.dart';

const legitDocument = 'legit';
const docNotFound = 'not found';
const early = 42;
final timestamp = TimestampStub()..stub = () => early;
final interaction = Interaction(timestamp);

void main() {
  group('Interaction', () {
    test(
        'GIVEN `Interaction(timestammp).update(legitDocument)`'
        'WHEN Interaction[legitDocument]'
        'THEN create return `timestammp`', () {
      timestamp.reset;
      interaction.update(legitDocument);
      expect(
        interaction[legitDocument],
        early,
        reason: 'timestamp shoud match',
      );
      expect(
        timestamp.callCount,
        1,
        reason: 'timestamp should be called once',
      );
    });
    test(
        'GIVEN [NO!]`Interaction(timestammp).update(docNotFound)`'
        'WHEN Interaction[docNotFound]'
        'THEN create return `null`', () {
      timestamp.reset;
      expect(
        interaction[docNotFound],
        null,
        reason: 'timestamp shoud match',
      );
      expect(
        timestamp.callCount,
        0,
        reason: 'timestamp should not be called',
      );
    });
    test(
        'GIVEN Interaction.clear(legitDocument)'
        'WHEN Interaction[legitDocument]'
        'THEN create return `null`', () {
      timestamp.reset;
      interaction.clear(legitDocument);
      expect(
        interaction[legitDocument],
        null,
        reason: 'timestamp shoud match',
      );
      expect(
        timestamp.callCount,
        0,
        reason: 'timestamp should not be called',
      );
    });

    test(
        'GIVEN ...'
        'WHEN Interaction.close'
        'THEN return an archive', () {
      timestamp.stub = () => early;
      timestamp.reset;
      interaction.update(legitDocument);
      final archive = interaction.close();
      expect(
        archive,
        isA<Archive>(),
        reason: 'Interaction.close return an archive',
      );
    });
  });
}
