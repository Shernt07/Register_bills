import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/controllers/dashboard_controller.dart';
import 'package:h2o_admin_app/models/dashboard_models.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_infoDashboard_custom.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(dashboardControllerProvider.notifier).startAutoUpdate();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _fetchManualDate() {
    final dateString = _dateController.text;
    try {
      final DateTime parsedDate = DateTime.parse(dateString);
      final formattedDate =
          "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
      ref
          .read(dashboardControllerProvider.notifier)
          .updateDashboardWithDate(formattedDate);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fecha inválida. Usa el formato YYYY-MM-DD.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = ref.watch(dashboardControllerProvider);
    final notifier = ref.read(dashboardControllerProvider.notifier);

    // final entries = dashboard?.productosVendidos.toMap().entries.toList() ?? [];
    final entries =
        dashboard?.productosVendidos
            .toMap()
            .entries
            .where((entry) => entry.value != 0) // filtra los que no sean cero
            .toList() ??
        [];

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 500),
          ); // forzar una pequeña espera
          notifier.startAutoUpdate();
        },

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  const SizedBox(height: 35),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 4,
                      color: const Color(0xFF08A5C0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 350,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(),
                                const Text(
                                  'Ventas al día',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Divider(color: Colors.white),
                                ),
                                Text(
                                  "\$ ${dashboard?.totalVentas ?? 0}.00",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // DEUDA
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 4,
                      color: Color.fromARGB(255, 213, 197, 46),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 350,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(),
                                const Text(
                                  'Deuda',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Divider(color: Colors.white),
                                ),
                                Text(
                                  "\$ ${dashboard?.deuda ?? 0}.00",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Mostar dianimcamente las card de los productos vendidos
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate((entries.length / 2).ceil(), (i) {
                      final first = entries[i * 2];
                      final second =
                          (i * 2 + 1) < entries.length
                              ? entries[i * 2 + 1]
                              : null;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          infoCard(title: first.key, value: first.value),
                          if (second != null)
                            infoCard(title: second.key, value: second.value),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: 45),
                  //HCER CONDICIONAL DE QUE SI NO HAY VENTAS REALIZADAS, NO LO MUESTRA
                  if (dashboard?.pedidosCliente.toMap().entries.isEmpty ?? true)
                    const Text(
                      'Pedidos por tipo de cliente',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  const SizedBox(height: 90),

                  SizedBox(
                    height: 80,
                    width: 80,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(
                            color: Colors.black,
                            width: 10,
                            style: BorderStyle.solid,
                          ),
                        ),
                        sections:
                            (dashboard?.pedidosCliente
                                        .toMap()
                                        .entries
                                        .isEmpty ??
                                    true)
                                ? [
                                  // Si no hay datos, agrega una sección gris
                                  PieChartSectionData(
                                    value: 100,
                                    title: "",
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                    showTitle: true,
                                    color: Colors.grey, //  color gris
                                  ),
                                ]
                                : dashboard?.pedidosCliente.toMap().entries.map(
                                      (entry) {
                                        return PieChartSectionData(
                                          value: entry.value.toDouble(),
                                          title: "${entry.value}",
                                          titleStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                          showTitle: true,
                                          color: _getColorForClientType(
                                            entry.key,
                                          ),
                                        );
                                      },
                                    ).toList() ??
                                    [],
                        sectionsSpace: 0.2,
                        centerSpaceRadius: 60,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  //aquí la misma condición de que si viene vacio, no lo muestre...
                  // if (dashboard?.pedidosCliente.toMap().entries.isEmpty ?? true)
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ), // Limita el ancho si deseas
                      child: _colorList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForClientType(String clientType) {
    switch (clientType) {
      case 'cliente publico general':
        return Colors.pink;
      case 'cliente institucional':
        return Colors.blue;
      case 'cliente mayoreo general':
        return Colors.green;
      case 'cliente departamento':
        return Colors.purple;
      case 'cliente mayoreo institucional':
        return Colors.yellow;
      case 'sin ventas':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

Widget _colorList() {
  return Align(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _colorItem('Institucional', Colors.blue),
        _colorItem('Departamentos', Colors.purple),
        _colorItem('Público General', Colors.pink),
        _colorItem('Mayoreo General', Colors.green),
        _colorItem('Mayoreo Institucional', Colors.yellow),
      ],
    ),
  );
}

Widget _colorItem(String name, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Ajusta el ancho al contenido
      mainAxisAlignment: MainAxisAlignment.start, // Alinea todo a la izquierda
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 10),
        Text(name, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}
