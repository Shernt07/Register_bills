import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/dashboard_models.dart';
import 'package:h2o_admin_app/service/dashboard_service.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardModel?>(
      (ref) => DashboardController(),
    );

class DashboardController extends StateNotifier<DashboardModel?> {
  final DashboardService dashboardService = DashboardService();
  Timer? _timer;
  bool _isManualUpdate = false;
  String _currentDate = '';
  DashboardModel? _previousData;

  DashboardController() : super(null) {
    _currentDate = _getCurrentDateFormatted();
  }

  String _getCurrentDateFormatted() {
    final now = DateTime.now();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  Future<void> fetchDashboard(String date) async {
    final response = await dashboardService.dashboardService(date);
    if (response.success) {
      final dashboardData = DashboardModel.fromJson(response.data);

      // Compara los datos actuales con los previos antes de actualizar
      if (_previousData == null ||
          !_areDataEqual(dashboardData, _previousData!)) {
        state = dashboardData;
        _previousData =
            dashboardData; // Guarda los nuevos datos para la próxima comparación
      }
    } else {
      print('Error al obtener el dashboard: ${response.message}');
    }
  }

  bool _areDataEqual(DashboardModel newData, DashboardModel oldData) {
    // Comparación simple de datos,  esto según la estructura del modelo
    return newData.totalVentas == oldData.totalVentas &&
        newData.productosVendidos == oldData.productosVendidos &&
        newData.pedidosCliente == oldData.pedidosCliente;
  }

  void cleanUp() {
    stopAutoUpdate();
  }

  void startAutoUpdate() {
    _currentDate = _getCurrentDateFormatted();
    fetchDashboard(_currentDate); // Cargar datos inmediatamente

    _timer = Timer.periodic(Duration(seconds: 1000), (timer) {
      if (!_isManualUpdate) {
        fetchDashboard(
          _currentDate,
        ); // Solo actualizar si no hay consulta manual
      }
    });
  }

  void stopAutoUpdate() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopAutoUpdate();
    super.dispose();
  }

  // este solo es para pruebas manuales (en la screen ya no se utiliza)
  void updateDashboardWithDate(String formattedDate) {
    _isManualUpdate = true; // Indicamos que es una consulta manual
    fetchDashboard(formattedDate).then((_) {
      _isManualUpdate = false; // Restauramos la actualización automática
    });
  }
}
