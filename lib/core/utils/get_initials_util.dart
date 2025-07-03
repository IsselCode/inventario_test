String getInitialsUtil(String fullName) {
  // Split: Elimina los espacios en blanco al principio y al final del string.
  // la expresion: Divide el texto usando un expresión regular que detecta uno o más espacios (\s+).
  // \s significa "cualquier espacio en blanco".
  final names = fullName.trim().split(RegExp(r"\s+"));
  final initials = <String>[];

  // Solo obtener 4 iniciales
  for (var i = 0; i < names.length && initials.length < 4; i++) {
    final name = names[i];
    if (name.isNotEmpty) {
      initials.add(name[0].toUpperCase());
    }
  }

  return initials.join();
}