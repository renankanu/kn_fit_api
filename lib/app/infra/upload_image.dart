import 'dart:typed_data';

import 'package:dotenv/dotenv.dart';
import 'package:minio/minio.dart';

class UploadImage {
  UploadImage._();

  static Future<void> sendImageToS3(
    Uint8List data, {
    required String imageName,
    String? imageExt = 'png',
  }) async {
    final bucket = env['AWS_BUCKET_NAME'];
    final minio = Minio(
      endPoint: env['AWS_ENDPOINT']!,
      accessKey: env['AWS_ACCESS_KEY']!,
      secretKey: env['AWS_SECRET_KEY']!,
      region: env['AWS_REGION'],
    );
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
    final minio = Minio(
      endPoint: env['AWS_ENDPOINT']!,
      accessKey: env['AWS_ACCESS_KEY']!,
      secretKey: env['AWS_SECRET_KEY']!,
      region: env['AWS_REGION'],
    );
    await minio.removeObject(
      bucket!,
      '$imageName.$imageExt',
    );
  }

  static Future<MinioByteStream> getObjectFromS3(String imageName) async {
    final bucket = env['AWS_BUCKET_NAME'];
    final minio = Minio(
      endPoint: env['AWS_ENDPOINT']!,
      accessKey: env['AWS_ACCESS_KEY']!,
      secretKey: env['AWS_SECRET_KEY']!,
      region: env['AWS_REGION'],
    );
    return minio.getObject(bucket!, imageName);
  }
}
