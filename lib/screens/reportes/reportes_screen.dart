import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/models/generateReports/generateReports_models.dart';
import 'package:h2o_admin_app/providers/reports_provider.dart';
import 'package:h2o_admin_app/screens/reportes/reportPDF_screen.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:intl/intl.dart';

class ReportGenerationScreen extends ConsumerStatefulWidget {
  static const String name = 'report_generation_screen';

  const ReportGenerationScreen({super.key});

  @override
  ConsumerState<ReportGenerationScreen> createState() =>
      _ReportGenerationScreenState();
}

class _ReportGenerationScreenState
    extends ConsumerState<ReportGenerationScreen> {
  String _selectedReportType = 'Efectivo';
  String _selectedStatus = 'Ventas';
  // String _selectedFormat = 'PDF';
  bool _isConfirmed = false;
  DateTime? _startDate;
  DateTime? _endDate;

  late ReportsFormControllers _controllers;
  late TextEditingController _selectedDatesController;

  @override
  void initState() {
    super.initState();
    final formProvider = ref.read(reportsFormProvider);

    // Inicializa los controladores con la fecha actual
    final now = DateTime.now();
    formProvider.dateInit.text = DateFormat('yyyy-MM-dd').format(now);
    formProvider.dateFinal.text = DateFormat('yyyy-MM-dd').format(now);

    _controllers = formProvider;
    _selectedDatesController = TextEditingController();

    // Inicializa con la fecha actual
    _startDate = now;
    _endDate = now;
    _selectedDatesController.text =
        'Inicio: ${DateFormat('dd/MM/yyyy').format(_startDate!)} - Fin: ${DateFormat('dd/MM/yyyy').format(_endDate!)}';
  }

  @override
  void dispose() {
    _selectedDatesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _controllers.dateInit.text = DateFormat(
            'yyyy-MM-dd',
          ).format(picked); // actualiza
        } else {
          _endDate = picked;
          _controllers.dateFinal.text = DateFormat(
            'yyyy-MM-dd',
          ).format(picked); // actualiza
        }

        if (_startDate != null && _endDate != null) {
          _selectedDatesController.text =
              'Inicio: ${DateFormat('dd/MM/yyyy').format(_startDate!)} - Fin: ${DateFormat('dd/MM/yyyy').format(_endDate!)}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF08A5C0),
                    endIndent: 10,
                  ),
                ),
                Text(
                  'Generar reportes',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF08A5C0),
                    indent: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/img/logo.png', height: 50),
                  const SizedBox(height: 8),
                  const Text(
                    'Linda Vista',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'A G U A  P U R I F I C A D A',
                    style: TextStyle(
                      color: Color(0xFF08A5C0),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Seleccione las fechas deseadas para su reporte',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF08A5C0),
                    size: 18.0,
                  ),
                  label: Text(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0,
                    ),
                    _startDate == null
                        ? 'Fecha de inicio'
                        : DateFormat('dd/MM/yyyy').format(_startDate!),
                  ),
                  onPressed: () => _selectDate(context, true),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF08A5C0),
                    size: 18,
                  ),
                  label: Text(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0,
                    ),
                    _endDate == null
                        ? 'Fecha de fin'
                        : DateFormat('dd/MM/yyyy').format(_endDate!),
                  ),
                  onPressed: () => _selectDate(context, false),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Fechas seleccionadas',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                controller: _selectedDatesController,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDropdown(
                  'Pago',
                  ['Efectivo', 'Cargos'],
                  _selectedReportType,
                  (value) {
                    setState(() {
                      _selectedReportType = value!;
                    });
                  },
                ),
                _buildDropdown('Estado', ['Ventas', 'Deuda'], _selectedStatus, (
                  value,
                ) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),

            //ESTE ES PARA EL TIPO DE FORMATO A DESCARGAR
            // _buildDropdown('Formato', ['PDF', 'Excel'], _selectedFormat, (
            //   value,
            // ) {
            //   setState(() {
            //     _selectedFormat = value!;
            //   });
            // }),
            // CheckboxListTile(
            //   activeColor: const Color(0xFF08A5C0),
            //   title: const Text("Confirmar"),
            //   value: _isConfirmed,
            //   onChanged: (bool? value) {
            //     setState(() {
            //       _isConfirmed = value!;
            //     });
            //   },
            // ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // context.pushNamed("reportesPDF_screen");
                    final notifier = ref.read(
                      generateReportNotifierProvider.notifier,
                    );
                    final fechaInicio = _controllers.dateInit.text;
                    final fechaFin = _controllers.dateFinal.text;
                    final idPago =
                        _selectedReportType == 'Efectivo'
                            ? 1
                            : _selectedReportType == 'Cargos'
                            ? 2
                            : 0;
                    final idEstado =
                        _selectedStatus == 'Ventas'
                            ? 1
                            : _selectedStatus == 'Deuda'
                            ? 0
                            : 2;

                    await notifier.fetchReports(
                      fechaInicio: fechaInicio,
                      fechaFin: fechaFin,
                      idTypePayment: idPago,
                      idStatusPayment: idEstado,
                    );
                    final state = ref.read(generateReportNotifierProvider);
                    state.when(
                      loading: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Generando reporte...')),
                        );
                      },
                      error: (err, _) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(err.toString())));
                      },
                      data: (report) {
                        if (report?.totalGeneral != 0) {
                          final reportsJson = generateReportsModelsToJson(
                            report!,
                          );
                          context.pushNamed(
                            "reportesPDF_screen",
                            extra: reportsJson,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No se encontraron resultados."),
                            ),
                          );
                        }
                      },
                    );
                  },
                  // _isConfirmed
                  //     ? () {
                  //       _showConfirmationDialog(context);
                  //     }
                  //     : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF08A5C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Descargar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String selectedItem,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: selectedItem,
          onChanged: onChanged,
          dropdownColor: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(5),
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('Su reporte se ha descargado de manera exitosa.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                ('Aceptar'),
                style: TextStyle(color: Color(0xFF08A5C0)),
              ),
            ),
          ],
        );
      },
    );
  }
}
