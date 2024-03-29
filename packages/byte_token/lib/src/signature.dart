import 'package:yak_utils/yak_utils.dart';

import 'encoder.dart';
import 'extensions.dart';
import 'payload.dart';
import 'secret.dart';
import 'typedefs.dart';

/// a callable class that generates a signature [Bytes]
class ByteSignature extends UnaryDelegate<Bytes, Payload> {
  final Secret secret;
  final BytesEncoder encoder;

  /// the constructor takes a [Secret] as argument
  /// default encoder is [HmacEncoder]
  const ByteSignature(
    this.secret, {
    this.encoder = const HmacEncoder(),
  });

  @override
  Bytes call(Payload p0) {
    if (p0.isExpired) {
      throw Exception('token expired\n$p0');
    }
    final payload = p0.toBuffer();
    return encoder(payload, secret());
  }
}
