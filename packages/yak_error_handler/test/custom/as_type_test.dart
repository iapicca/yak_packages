import 'package:test/test.dart';
import 'package:yak_error_handler/src/all.dart';

import '../stub/all.dart';

class Foo {}

class Bar {}

class Baz extends Bar {}

void main() {
  group('AsTypeError & asType<T>', () {
    final stub = HandleErrorDelegateStub();
    final handler = ErrorHandler<AsTypeError>(stub);
    final foo = Foo();
    final baz = Baz();
    test(
        'WHEN `Error` != AsTypeError is thrown '
        'THEN stub is not called', () {
      stub
        ..reset
        ..result = () {};
      try {
        throw Error();
      } on Error catch (e) {
        handler(e);
      }

      expect(
        stub.callCount,
        0,
        reason: 'stub should not be called',
      );
    });
    test(
        'GIVEN `Foo` does not extends nor implements `Bar`'
        'WHEN `Foo asType<Bar> should throw'
        'THEN should theow `AsTypeError`', () {
      stub
        ..reset
        ..result = () {};
      try {
        asType<Bar>(foo);
      } on Error catch (e) {
        handler(e);
      }

      expect(
        stub.callCount,
        1,
        reason: 'stub should be called',
      );
    });

    test(
        'GIVEN `Baz` does extends nor implements `Bar`'
        'WHEN `Baz asType<Bar> should succed'
        'THEN should theow `AsTypeError`', () {
      stub
        ..reset
        ..result = () {};
      try {
        asType<Bar>(baz);
      } on Error catch (e) {
        handler(e);
      }
      expect(
        stub.callCount,
        0,
        reason: 'stub should not be called',
      );
    });

    test(
        'WHEN `toString` is called'
        'THEN outputs a predictable result', () {
      stub
        ..reset
        ..result = () {};

      var err;
      try {
        asType<Bar>(foo);
      } on Error catch (e) {
        err = e;
      }
      expect(
          (err as AsTypeError).toString(), 'AsType failed: "object is a Foo"');

      try {
        throw AsTypeError();
      } on Error catch (e) {
        err = e;
      }
      expect((err as AsTypeError).toString(), 'AsType failed');
    });
  });
}
