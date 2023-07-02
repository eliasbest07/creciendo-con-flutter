abstract class UsuarioRepository {
  Future<void> gastarPuntos(String userId, int cantidad);
  Future<bool> verificarPuntosSuficientes();
  Stream<int> obtenerPuntos();
}
