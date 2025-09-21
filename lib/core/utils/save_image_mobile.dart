import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

/// Guarda una imagen (Uint8List) en una carpeta privada de la app
/// y devuelve la ruta absoluta (String).
/// Plataforma: Android / iOS.
Future<String> saveImageMobile(Uint8List bytes) async {
  if (bytes.isEmpty) {
    throw ArgumentError('bytes está vacío');
  }

  // Directorio de documentos de la app
  final dir = await getApplicationDocumentsDirectory();

  // Subcarpeta para imágenes
  final imagesDir = Directory('${dir.path}/images');
  if (!await imagesDir.exists()) {
    await imagesDir.create(recursive: true);
  }

  // Nombre sencillo con timestamp
  final fileName = 'img_${DateTime.now().millisecondsSinceEpoch}.png';
  final filePath = '${imagesDir.path}/$fileName';

  // Guardar
  final file = File(filePath);
  await file.writeAsBytes(bytes, flush: true);

  return file.path;
}
