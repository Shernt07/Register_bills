//  Transforma el valor que se recibe en String a una forma agradeble
// de visualización para las fechas.

class DateFormatter {
  /// Convierte una fecha en formato 'yyyy-mm-dd' a 'dd/mm/yyyy'
  static String formatDateDMY(String date) {
    final parts = date.split('-'); // [yyyy, mm, dd]
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}/${parts[0]}'; // dd/mm/yyyy
    }
    return date; // Si no cumple el formato esperado
  }

  /// Convierte 'yyyy-mm-dd' a 'dd/mm'
  static String formatDayMonth(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      return '${parts[2]}/${parts[1]}';
    }
    return date;
  }

  /// Convierte 'yyyy-MM-dd HH:mm:ss' a 'dd de mes de yyyy, HH:mm'
  static String formatEleganteCards(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final months = [
        'enero',
        'febrero',
        'marzo',
        'abril',
        'mayo',
        'junio',
        'julio',
        'agosto',
        'septiembre',
        'octubre',
        'noviembre',
        'diciembre',
      ];
      final day = dateTime.day.toString().padLeft(2, '0');
      final monthName = months[dateTime.month - 1];
      final year = dateTime.year;
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$day de $monthName de $year, $hour:$minute';
    } catch (_) {
      return dateTimeStr; // Retorna sin cambios si falla el parseo
    }
  }
}

/// clase para convertir las fechas
