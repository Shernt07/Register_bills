import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h2o_admin_app/config/utils/date_formatter.dart';
import 'package:h2o_admin_app/models/generateReports/generateReports_models.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportPreviewScreen extends StatelessWidget {
  static const String name = 'reportesPDF_screen';

  // final List<Map<String, dynamic>> reportes; // acepta la lista como parametros
  // final List<GenerateReportsModels> reportes;
  final GenerateReportsModels reporte;

  const ReportPreviewScreen({
    super.key,
    required this.reporte,
    // required this.totalGeneral,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa del reporte')),

      // Genera el formato del PDF a generar
      body: PdfPreview(
        build: (format) => generateReportPdf(),
        canChangePageFormat: false,
        canChangeOrientation: false,
        pdfFileName: 'reporte_dinamico.pdf',
      ),
    );
  }

  Future<Uint8List> generateReportPdf() async {
    final pdf = pw.Document();
    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/img/Logo_ULV2.png')).buffer.asUint8List(),
    );

    // Número de filas que se mostrarán en cada página
    const int rowsPerPage = 28;

    // Encabezados de las tablas
    final headers = [
      'No.', //NUM
      'FECHA',
      // 'CARGO AL DEPARTAMENTO DE:',
      // '${reporte.tipoIngreso} A:',
      'NOMBRE DE CLIENTE:',

      'FOLIO',
      'MONTO',
    ];

    // Son solo datos simulados por el momento
    // final dataRows = List.generate(120, (index) {
    //   return [
    //     '${index + 1}',
    //     '01/12/2023',
    //     'Depto. Ejemplo DEPARTAMENTO DE SUPER PLANTA DE AGUA: DEPARTAMENTO DE SUPER PLANTA DE AGUA',
    //     '${index + 1}',
    //     '\$34.00',
    //   ];
    // });
    final dataRows =
        reporte.datos.map<List<String>>((item) {
          return [
            item.numeroItem.toString(),
            DateFormatter.formatDateDMY(item.dataSale),
            item.nameClient,
            item.folio.toString(),
            '\$${item.monto.toString()}',
          ];
        }).toList();

    pw.Widget buildHeader() => pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Logo alineado a la izquierda
            pw.Image(logoImage, width: 60),

            // Texto centrado horizontalmente en el espacio restante
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment:
                    pw
                        .CrossAxisAlignment
                        .center, // ← Centra el texto dentro del espacio
                children: [
                  pw.Text(
                    'UNIVERSIDAD LINDA VISTA A.C.',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text('FORMATO DE INGRESOS POR ${reporte.tipoIngreso}'),
                  pw.Text('DEPARTAMENTO DE SUPER PLANTA DE AGUA'),
                  // pw.Text(
                  //   'INGRESOS DEL ${reporte.fechaInicio} AL ${reporte.fechaFin}',
                  // ),
                  // pw.Text('INGRESOS DEL 01 AL 15 DE DICIEMBRE DEL 2023'),
                  pw.SizedBox(height: 10),

                  // pw.Text(
                  //   'CARGOS DEL: 01 AL 15 DE DICIEMBRE DEL 2023',
                  //   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  // ),
                  pw.Text(
                    'INFORME DEL: ${DateFormatter.formatDateDMY(reporte.fechaInicio)} AL ${DateFormatter.formatDateDMY(reporte.fechaFin)}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
      ],
    );

    // buildTable construye la tabla con TableHelper.fromTextArray
    pw.Widget buildTable(List<List<String>> rows) =>
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: rows,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headerDecoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#d2f9ff'), // Fondo azul
          ),
          cellAlignment: pw.Alignment.centerLeft,
          columnWidths: {
            0: const pw.FixedColumnWidth(35),
            1: const pw.FixedColumnWidth(75),
            2: const pw.FlexColumnWidth(),
            3: const pw.FixedColumnWidth(55),
            4: const pw.FixedColumnWidth(61),
          },
          // Borde la tabla
          border: pw.TableBorder.all(),
        );
    // Construye el pie de página
    pw.Widget buildFooter() => pw.Column(
      children: [
        pw.SizedBox(height: 180),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              children: [
                pw.Container(
                  width: 150,
                  height: 1,
                  color: PdfColors.black,
                  margin: const pw.EdgeInsets.only(bottom: 4),
                ),
                pw.Text(reporte.realizo),
                // pw.Text('EDGAR ALENCAR'),
                // pw.Text('GONZALEZ'),
                pw.Text(
                  'REALIZÓ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.Column(
              children: [
                pw.Container(
                  width: 150,
                  height: 1,
                  color: PdfColors.black,
                  margin: const pw.EdgeInsets.only(bottom: 4),
                ),
                // pw.Text('CP. RAUL ELI MEZA'),
                // pw.Text('LANDAVERDE'),
                pw.Text(reporte.vistoBueno),
                pw.Text(
                  'VISTO BUENO',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    // Calcula cuántas páginas se necesitan, dividiendo el número total de filas por las filas por página
    int totalPages = (dataRows.length / rowsPerPage).ceil();
    // final totalGenerall = reporte.datos.fold<int>(
    //   0,
    //   (sum, item) => sum + item.monto,
    // );

    // Se itera sobre cada página, dividiendo las filas de datos en grupos de rowsPerPage
    for (int page = 0; page < totalPages; page++) {
      final start = page * rowsPerPage;
      final end = (start + rowsPerPage).clamp(0, dataRows.length);
      final pageRows = dataRows.sublist(start, end);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              children: [
                if (page == 0) buildHeader(),
                // buildHeader(),
                pw.Expanded(child: buildTable(pageRows)),

                // Si es la última página, se agrega el total acumulado y el pie de página con las firmas
                if (page == totalPages - 1) ...[
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        // 'TOTAL: \$${dataRows.length * 100}.00',
                        'TOTAL: \$${reporte.totalGeneral}.00',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                  buildFooter(),
                ],
              ],
            );
          },
        ),
      );
    }

    return pdf.save();
  }
}
