import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/suggestions/allSuggestionsModel.dart';
import 'package:h2o_admin_app/service/suggestions/suggestions_service.dart';

class SuggestionNotifier
    extends StateNotifier<List<AllcommentsCustomerModels>> {
  SuggestionNotifier() : super([]) {
    loadSuggestion();
  }

  // Establecer
  void setSuggestion(List<AllcommentsCustomerModels> suggestion) {
    state = suggestion;
  }

  // Cargar
  Future<void> loadSuggestion() async {
    final response = await SuggestionsService().allSuggestionService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final suggestion =
          rawList.map((e) => AllcommentsCustomerModels.fromJson(e)).toList();
      state = suggestion;
    }
  }

  // Marcar una sugerencia como leída (isRead = true)
  Future<void> updateSuggestion(int idComment) async {
    final response = await SuggestionsService().updateSuggestion(idComment);

    if (response.success) {
      // Actualizar el estado localmente sin usar copyWith
      state =
          state.map((comment) {
            if (comment.idComments == idComment) {
              // Actualizamos directamente el campo isRead
              return AllcommentsCustomerModels(
                idComments: comment.idComments,
                idUser: comment.idUser,
                comment: comment.comment,
                dateCreate: comment.dateCreate,
                isRead: true, // Marcar como leído
              );
            }
            return comment;
          }).toList();
    } else {
      print('Error al marcar como leído: ${response.message}');
    }
  }
}

// como exportación del provider
final suggestionProvider =
    StateNotifierProvider<SuggestionNotifier, List<AllcommentsCustomerModels>>(
      (ref) => SuggestionNotifier(),
    );
