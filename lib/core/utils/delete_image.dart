import 'dart:io';

Future<bool> deleteImage(String fullPath) async {
  try {
    // Creamos la instancia del File
    final file = File(fullPath);
    // verificamos que exista
    if (!await file.exists()) return false;
    // Eliminamos la imagen en caos de existir
    await file.delete();
    return true;
  } catch (_) {
    return false;
  }
}
