import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/profile_models.dart';
import 'package:h2o_admin_app/service/profile_service.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier();
});

class ProfileState {
  final ProfileModel? profile;
  final bool loading;
  final String error;

  ProfileState({this.profile, this.loading = false, this.error = ''});

  ProfileState copyWith({ProfileModel? profile, bool? loading, String? error}) {
    return ProfileState(
      profile: profile ?? this.profile,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState(loading: true));

  final ProfileService _profileService = ProfileService();

  Future<void> loadProfile(int userId) async {
    state = state.copyWith(loading: true);
    try {
      final profile = await _profileService.fetchProfile(userId);
      if (profile != null) {
        state = state.copyWith(profile: profile, loading: false);
      } else {
        state = state.copyWith(
          loading: false,
          error: 'No se pudo cargar el perfil',
        );
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Error al cargar el perfil',
      );
    }
  }
}
