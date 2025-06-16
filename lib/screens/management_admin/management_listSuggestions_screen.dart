import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/suggestions_provider.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_order_custom.dart';
import 'package:h2o_admin_app/controllers/list_orders_controllers.dart';
import 'package:h2o_admin_app/widgets/cards/card_suggestion_custom%20copy.dart';
import 'package:h2o_admin_app/widgets/cards/card_suggestion_custom.dart';
import 'package:intl/intl.dart';

class ListSuggestionsScreen extends ConsumerStatefulWidget {
  static String name = 'management_suggestions_screen';

  const ListSuggestionsScreen({super.key});

  @override
  ConsumerState<ListSuggestionsScreen> createState() =>
      ListSuggestionsScreenState();
}

class ListSuggestionsScreenState extends ConsumerState<ListSuggestionsScreen> {
  bool isloading = false;

  final Map<String, String> statusMap = {
    "Sin leer": "1",
    "Leidos": '2',
    "Todos": '3',
  };
  String selectedStatus = 'Sin leer'; // estado seleccionado por defecto

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSuggestions();
    });
  }

  Future<void> fetchSuggestions() async {
    setState(() => isloading = true);
    final suggestionController = ref.read(suggestionProvider.notifier);
    await suggestionController.loadSuggestion();
    setState(() => isloading = false);
  }

  String getStatusKey(String value) {
    return statusMap.entries.firstWhere((entry) => entry.value == value).key;
  }

  @override
  Widget build(BuildContext context) {
    // intancio el provider para ser usado en la card

    final suggestion = ref.watch(suggestionProvider);

    // Filtrado local según el estado seleccionado
    final filteredSuggestions =
        selectedStatus == 'Todos'
            ? suggestion
            : suggestion.where((sugg) {
              if (selectedStatus == 'Leidos') return sugg.isRead == true;
              if (selectedStatus == 'Sin leer') return sugg.isRead == false;
              return true;
            }).toList();

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: selectedStatus,
                  items:
                      statusMap.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      setState(() {
                        selectedStatus = newValue;
                      });
                      // await fetchSuggestions();
                    }
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await fetchSuggestions(),
                child:
                    isloading
                        ? const Center(child: CircularProgressIndicator())
                        : filteredSuggestions.isEmpty
                        ? ListView(
                          // physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(
                              height: 300,
                            ), // para centrarlo un poco más abajo
                            Center(
                              child: Text(
                                'No hay comentarios disponibles',
                                // style: TextStyle(
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w400,
                                //   color: Colors.grey,
                                // ),
                              ),
                            ),
                          ],
                        )
                        : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            final sugg = filteredSuggestions[index];
                            return CardSuggestionCopyCustom(
                              clientName: sugg.comment,
                              isRead: sugg.isRead,
                              fechaPedido: sugg.dateCreate,
                              onDetailsPressed: () {
                                ref
                                    .read(suggestionProvider.notifier)
                                    .updateSuggestion(sugg.idComments);
                              },
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
