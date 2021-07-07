import 'dart:io';

import 'package:minio/minio.dart';

class MinioStorage {
  final String accessKey;
  final String secretKey;
  final String sessionToken;
  final String endPoint;
  final String bucket;
  final String region;
  final int port;
  final bool useSSL;
  final bool enableTrace;

  MinioStorage({
    this.accessKey = '',
    this.secretKey = '',
    this.sessionToken,
    this.endPoint,
    this.bucket,
    this.region,
    this.port,
    this.useSSL = true,
    this.enableTrace = false,
  });

  Future<String> uploadImage(String uid, File file) async {
    String imageUrl = '';

    try {
      final minio = Minio(
          endPoint: endPoint,
          accessKey: accessKey,
          secretKey: secretKey,
          sessionToken: sessionToken,
          useSSL: useSSL,
          enableTrace: enableTrace,
          region: region,
          port: port);

      bool bucketExists = await minio.bucketExists(bucket);

      if (!bucketExists) await minio.makeBucket(bucket);

      Stream<List<int>> stream = file.openRead();

      final size = await file.length();

      var metaData = {
        'Content-Type': 'image/png',
      };

      final etag = await minio.putObject(bucket, '$uid.png', stream, size,
          metadata: metaData);

      imageUrl = 'https://$endPoint/pub/$uid.png';
    } catch (_) {
      return 'error';
    }
    return imageUrl;
  }
}
