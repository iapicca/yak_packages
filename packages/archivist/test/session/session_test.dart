import 'package:archivist/archivist.dart';
import 'package:test/test.dart';

import '../stub/all.dart';

const legitDocument = 'legit';
const docNotFound = 'not found';
const version = 'latest version';
const early = 42;
const later = 9000;
final timestamp = TimestampStub()..stub = () => early;
late Session session;
void main() {
  group('Session', () {
    timestamp.reset;

    session = Session(
      ConnectivityStatus.wifi(),
      timestamp,
      version,
    );
    test(
        'GIVEN `Session(timestammp)`'
        'WHEN session.started'
        'THEN returns timestammp', () {
      expect(
        session.started,
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
        'GIVEN ...'
        'WHEN session.end'
        'THEN returns timestammp', () {
      timestamp.reset;
      session.end();
      expect(
        session.ended,
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
        'GIVEN session has already ended'
        'WHEN session.end'
        'THEN returns previous timestammp', () {
      timestamp.reset;
      timestamp.stub = () => later;
      session.end();
      expect(
        session.ended,
        early,
        reason: 'timestamp shoud match',
      );
      expect(
        timestamp.callCount,
        0,
        reason: 'timestamp should not be called',
      );
    });

    test(
        'GIVEN Session(ConnectivityStatus.wifi())'
        'WHEN session.connectivity'
        'THEN is `WifiConnection`', () {
      expect(
        session.connectivity,
        isA<WifiConnection>(),
        reason: 'connectivity should be a `WifiConnection`',
      );
    });

    test(
        'GIVEN Session(version)'
        'WHEN session.appVersion'
        'THEN is `version`', () {
      expect(
        session.appVersion,
        version,
        reason: 'appVersion should matcch `version`',
      );
    });

    test(
        'GIVEN Session(version)'
        'WHEN session.appVersion'
        'THEN is `version`', () {
      expect(
        session.appVersion,
        version,
        reason: 'appVersion should matcch `version`',
      );
    });
  });
}
