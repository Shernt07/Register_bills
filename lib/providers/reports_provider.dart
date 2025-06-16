import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/generateReports/generateReports_models.dart';
import 'package:h2o_admin_app/service/generateReports/reports_service.dart';

// Notifier que maneja el estado de un solo reporte generado
class GenerateReportNotifier
    extends StateNotifier<AsyncValue<GenerateReportsModels?>> {
  final GenerateReportService _service;

  // Estado inicial nulo (sin datos)
  GenerateReportNotifier(this._service) : super(const AsyncValue.data(null));

  Future<void> fetchReports({
    required String fechaInicio,
    required String fechaFin,
    required int idTypePayment,
    required int idStatusPayment,
  }) async {
    // Validaciones
    if (fechaInicio.isEmpty || fechaFin.isEmpty) {
      state = AsyncValue.error(
        'Las fechas no pueden estar vacías',
        StackTrace.current,
      );
      return;
    }

    final inicio = DateTime.tryParse(fechaInicio);
    final fin = DateTime.tryParse(fechaFin);

    if (inicio == null || fin == null) {
      state = AsyncValue.error('Formato de fecha inválido', StackTrace.current);
      return;
    }

    if (inicio.isAfter(fin)) {
      state = AsyncValue.error(
        'La fecha de inicio no puede ser posterior a la fecha final',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      final report = await _service.createReport(
        fechaInicio,
        fechaFin,
        idTypePayment,
        idStatusPayment,
      );
      state = AsyncValue.data(report);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Provider del servicio
final generateReportServiceProvider = Provider<GenerateReportService>((ref) {
  return GenerateReportService();
});

// Provider del notifier que maneja un solo GenerateReportsModels
final generateReportNotifierProvider = StateNotifierProvider<
  GenerateReportNotifier,
  AsyncValue<GenerateReportsModels?>
>((ref) {
  final service = ref.watch(generateReportServiceProvider);
  return GenerateReportNotifier(service);
});

// Provider de controladores de formulario
final reportsFormProvider = Provider<ReportsFormControllers>((ref) {
  return ReportsFormControllers();
});

// Controladores del formulario
class ReportsFormControllers {
  final dateInit = TextEditingController(); // Fecha inicial
  final dateFinal = TextEditingController(); // Fecha final
  final pago = TextEditingController(); // Método de pago
  final estado = TextEditingController(); // Estado del pedido

  void dispose() {
    dateInit.dispose();
    dateFinal.dispose();
    pago.dispose();
    estado.dispose();
  }

  void clear() {
    dateInit.clear();
    dateFinal.clear();
    pago.clear();
    estado.clear();
  }
}
