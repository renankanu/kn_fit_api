import 'dart:typed_data';

import 'package:dotenv/dotenv.dart';
import 'package:minio/minio.dart';

class MediaHelper {
  MediaHelper._();

  static Future<void> sendImageToS3(
    Uint8List data, {
    required String imageName,
    required String imageExt,
  }) async {
    final bucket = env['AWS_BUCKET_NAME'];
    final Minio minio = initS3();
    await minio.putObject(
      bucket!,
      '$imageName.$imageExt',
      Stream.value(data),
    );
  }

  static Future<void> deleteImageFromS3(
    String imageName, {
    String? imageExt = 'png',
  }) async {
    final bucket = env['AWS_BUCKET_NAME'];
    final minio = initS3();
    await minio.removeObject(
      bucket!,
      '$imageName.$imageExt',
    );
  }

  static Future<MinioByteStream> getObjectFromS3(String imageName) async {
    final bucket = env['AWS_BUCKET_NAME'];
    final minio = initS3();
    return minio.getObject(bucket!, imageName);
  }

  static Minio initS3() {
    final minio = Minio(
      endPoint: env['AWS_ENDPOINT']!,
      accessKey: env['AWS_ACCESS_KEY']!,
      secretKey: env['AWS_SECRET_KEY']!,
      region: env['AWS_BUCKET_REGION'],
    );
    return minio;
  }
}
