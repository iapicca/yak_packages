import 'package:archivist/archivist.dart';
import 'package:stub/stub.dart';

class TimestampStub extends Stub<int> implements TimestampDelegate {
  @override
  int call() => stub();
}
