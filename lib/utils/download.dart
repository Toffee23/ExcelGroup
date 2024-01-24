import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:course_view/utils/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Download {
  late Directory _thumbnailDir;
  late Directory _videosDir;
  final Dio _dio = Dio();
  final Crypto _crypto = Crypto();
  bool isInitialized = false;

  Future<void> initialize() async {
    // final root = await getApplicationDocumentsDirectory();
    final root = await getDownloadsDirectory();
    _thumbnailDir = Directory(join(root!.path, 'thumbnail'));
    _videosDir = Directory(join(root.path, 'videos'));

    if (!await _thumbnailDir.exists()) {
      await _thumbnailDir.create();
    }

    if (!await _videosDir.exists()) {
      await _videosDir.create();
    }

    isInitialized = true;
  }

  static Future<Directory> get downloadDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<bool> downloadForOffline(String url, String id) async {
    final Dio dio = Dio();

    try {
      final Response<List<int>> response = await dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final Directory dir = await downloadDirectory;
      final videoPath = '${dir.path}/$id.mp4';

      await File(videoPath).writeAsBytes(response.data!);

      log('Video downloaded successfully to: $videoPath');
      return true;
    } catch (error) {
      log('Error downloading video: $error');
      return false;
    }
  }

  Future<File?> getThumbnail(String url, String id, String ext) async {
    final file = File(join(_thumbnailDir.path, '$id.$ext'));

    if (await file.exists()) {
      // File already download into file_path.
      return file;
    } else {
      // Download file into file_path.
      final data = await _downloadFile(url);

      if (data != null) {
        final bytes = _crypto.decryptBytes(data);
        await file.writeAsBytes(bytes);
        return file;
      }
      return null;
    }
  }

  Future<File?> getVideo(String url, String id, String ext) async {
    final file = File(join(_videosDir.path, '$id.$ext'));

    if (await file.exists()) {
      log('Already exits');
      // if (false) {
      // File already download into file_path.
      return file;
    } else {
      log('Just downloading');
      // Download file into file_path.
      final data = await _downloadFile(url);
      log('done here');

      if (data != null) {
        log('Encrypting starts');
        final bytes = _crypto.decryptBytes(data);
        log('Encrypting ends, saving...');
        await file.writeAsBytes(bytes);
        log('saving ends');

        return file;
      }
      return null;
    }
  }

  Future<Uint8List?> _downloadFile(String url) async {
    try {
      log('Download about to start');
      final Response<Uint8List> response = await _dio.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      log('Download complete');

      return response.data!;
    } catch (error) {
      log('Error downloading video: $error');
      return null;
    }
  }
}
