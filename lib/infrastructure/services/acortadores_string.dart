class Acortador{

  // Función para obtener la primera palabra del nombre
String getFirstWord(String fullName) {
  final firstSpaceIndex = fullName.indexOf(' ');
  return firstSpaceIndex != -1 ? fullName.substring(0, firstSpaceIndex) : fullName;
}

String getFixDate(String date) {
  final firstSpaceIndex = date.indexOf(' ');
  return firstSpaceIndex != -1 ? date.substring(0, firstSpaceIndex) : date;
}
}