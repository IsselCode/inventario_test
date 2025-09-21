import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Guarda bytes de imagen en una carpeta de la app y devuelve la ruta absoluta.
/// [bytes]: contenido de la imagen.
/// [fileName]: opcional, nombre con extensión (ej. "foto.png").
/// [subdir]: subcarpeta dentro del directorio de la app (por defecto: "images").
/// [forceExtension]: si el nombre no trae extensión, se forzará esta (por defecto: ".png").
Future<String> saveImageBytes(
    Uint8List bytes, {
      String? fileName,
      String subdir = 'images',
      String forceExtension = '.png',
    }) async {
  if (kIsWeb) {
    throw UnsupportedError('No se puede escribir en el sistema de archivos en Flutter Web.');
  }

  // 1) Directorio base propio de la app (documentos/soporte según plataforma)
  final Directory baseDir = await _getAppWritableDir();

  // 2) Subcarpeta para imágenes
  final Directory imagesDir = Directory(p.join(baseDir.path, subdir));
  if (!await imagesDir.exists()) {
    await imagesDir.create(recursive: true);
  }

  // 3) Nombre de archivo
  final String safeName = _ensureFileName(
    fileName: fileName,
    extension: forceExtension,
  );

  final String fullPath = p.join(imagesDir.path, safeName);

  // 4) Escribir bytes
  final file = File(fullPath);
  await file.writeAsBytes(bytes, flush: true);

  return file.path;
}

/// Intenta usar Documents cuando existe (iOS/macOS/Windows/Linux),
/// y en Android usa ApplicationSupport (scope de app) para evitar problemas de almacenamiento con Android 10+.
Future<Directory> _getAppWritableDir() async {
  if (Platform.isAndroid) {
    // En Android, Support dir es seguro y privado para la app.
    return await getApplicationSupportDirectory();
  } else if (Platform.isIOS || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    return await getApplicationDocumentsDirectory();
  } else {
    // Fallback genérico
    return await getApplicationSupportDirectory();
  }
}

String _ensureFileName({String? fileName, String extension = '.png'}) {
  String name = (fileName?.trim().isNotEmpty ?? false)
      ? fileName!.trim()
      : 'img_${DateTime.now().millisecondsSinceEpoch}';

  // Agregar extensión si no viene
  if (p.extension(name).isEmpty) {
    if (!extension.startsWith('.')) extension = '.${extension}';
    name = '$name$extension';
  }
  return name;
}