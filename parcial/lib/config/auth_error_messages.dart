import 'package:firebase_auth/firebase_auth.dart';

String authErrorInSpanish(FirebaseAuthException error) {
  return switch (error.code) {
    'invalid-email' => 'El correo electrónico no tiene un formato válido.',
    'invalid-credential' ||
    'wrong-password' ||
    'user-not-found' => 'Correo o contraseña incorrectos.',
    'email-already-in-use' => 'Este correo ya está registrado.',
    'weak-password' => 'La contraseña es débil. Usa al menos 6 caracteres.',
    'too-many-requests' || 'too-many-attempts-try-later' =>
      'Demasiados intentos. Espera un momento e intenta nuevamente.',
    'network-request-failed' =>
      'No hay conexión. Revisa tu red e intenta nuevamente.',
    'operation-not-allowed' =>
      'Este método de inicio de sesión no está habilitado.',
    'unauthorized-domain' =>
      'Este dominio no está autorizado en Firebase Authentication.',
    'popup-blocked' || 'web-popup-blocked' =>
      'El navegador bloqueó la ventana de inicio de sesión.',
    'popup-cancelled-by-user' ||
    'popup-closed-by-user' ||
    'cancelled-popup-request' ||
    'facebook-login-cancelled' => 'Inicio de sesión cancelado.',
    'account-exists-with-different-credential' =>
      'Ya existe una cuenta con este correo usando otro proveedor.',
    'credential-already-in-use' =>
      'Estas credenciales ya están vinculadas a otra cuenta.',
    'missing-google-id-token' =>
      'Google no devolvió una identificación válida.',
    'facebook-login-failed' => 'No fue posible iniciar sesión con Facebook.',
    _ =>
      error.message ??
          'No fue posible completar la operación. Intenta nuevamente.',
  };
}
