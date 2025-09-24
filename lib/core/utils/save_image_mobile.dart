import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Guarda bytes de imagen en una carpeta de la app y devuelve la ruta absoluta.
Future<String> saveImageMobile(Uint8List bytes) async {

  // 1) Directorio base propio de la app
  final Directory baseDir = await getApplicationSupportDirectory();

  // 2) Subcarpeta para imágenes
  final Directory imagesDir = Directory(p.join(baseDir.path, "images"));
  if (!await imagesDir.exists()) {
    await imagesDir.create(recursive: true);
  }

  // 3) Nombre de archivo
  String name = 'img_${DateTime.now().microsecondsSinceEpoch}';
  String extension = ".png";
  String safeName = '$name$extension';

  final String fullPath = p.join(imagesDir.path, safeName);

  // 4) Escribir bytes
  final file = File(fullPath);
  await file.writeAsBytes(bytes, flush: true);

  return file.path;
}