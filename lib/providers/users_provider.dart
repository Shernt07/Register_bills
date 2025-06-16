import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/usersdata_models.dart';
import 'package:h2o_admin_app/service/sharedPreferences/shared_preferences_service.dart';
import 'package:h2o_admin_app/providers/auth_provider.dart';

class UserNotifier extends StateNotifier<UserData?> {
  UserNotifier(this._prefsService) : super(null);

  final SharedPreferencesService _prefsService;

  void login(UserData user, String token) async {
    state = user;
    await _prefsService.saveToken(token);
    await _prefsService.saveUser(user);
    await _prefsService.saveIdTypeUser(user.idTypeUser);

    final storedToken = await _prefsService.getToken();
    print('Token JWT guardado: $storedToken');
  }

  Future<void> logout(WidgetRef ref) async {
    state = null;
    await _prefsService.deleteToken();
    await _prefsService.deleteUser();
    await _prefsService.deleteIdTypeUser();
    ref.read(authProvider.notifier).state = false;
  }

  Future<void> loadUserFromPrefs() async {
    final user = await _prefsService.getUser();
    if (user != null) {
      state = user;
      await _prefsService.printSavedUser();
      print(
        'lo que guarda sharedPreferences ${_prefsService.printSavedUser()}',
      );
    }
  }
}

final usersProvider = StateNotifierProvider<UserNotifier, UserData?>((ref) {
  return UserNotifier(SharedPreferencesService());
});
