import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/usersdata_models.dart';

/// Provider global para el usuario actual logueado
final userProvider = StateProvider<UserData?>(
  (ref) => null,
); //almacena lso datos que el login manda al loguerase con todos los campos de UserData

// Este archivo define el provider global que guarda los datos del usuario logueado. 
//Lo vas a usar en muchas partes de la app: menú, dashboard, filtros, etc.


// EN MIGRACIÓN A USERS_PROVIDER... ESTE QUEDARA DEPRECADO EN EL FUTURO
// POR NO CONTAR CON EL ALMACENAMIENTO DE LOS SHARED PREFERENCES