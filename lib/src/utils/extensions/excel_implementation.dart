// ignore_for_file: all

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:wayllu_project/src/domain/models/venta/ventas_excel/ventas_excel.dart';

class ExcelImplementation {
  late Workbook excel;
  late Worksheet sheet;

  final double dateColumn = 18.00;
  final double firstColumns = 17.00;
  final double secondsColumns = 13.00;

  ExcelImplementation() {
    excel = Workbook();
    sheet = excel.worksheets[0];
    sheet.showGridlines = false;

    _setupExcel();
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> insertImage(String imagePath, int row, int column) async {
    final Picture picture = sheet.pictures
        .addStream(row, column, await _readImageData('LOGOTIPO.png'));
    picture.lastRow = row + 1;
    picture.lastColumn = column + 3;
  }

  void _insertHeader() {
    sheet.getRangeByName('A1').cellStyle.backColor = '#b80000';
    sheet.getRangeByName('A1').rowHeight = 26;
  }

  void insertFooter(int row) {
    final footerRow = row + 3;
    sheet
        .getRangeByName('A$footerRow')
        .setText('7 de Julio del 2024 | Lima, Peru | Wayllu aplicativo');
    sheet.getRangeByName('A$footerRow').cellStyle.fontSize = 12;
    sheet.getRangeByName('A$footerRow').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('A$footerRow').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('A$footerRow').cellStyle.backColor = '#FFA743';
    sheet.getRangeByName('A$footerRow').rowHeight = 26;

    sheet.getRangeByName('A$footerRow:K$footerRow').merge();
  }

  void wrappingCells(int row) {
    sheet.getRangeByName('A1:K$row').cellStyle.wrapText = true;
  }

  Future<void> _setupExcel() async {
    // Set column widths
    sheet.getRangeByName('A1:A1').columnWidth = 5.00;
    sheet.getRangeByName('B1:B1').columnWidth = dateColumn;
    sheet.getRangeByName('C1:G1').columnWidth = firstColumns;
    sheet.getRangeByName('H1:J1').columnWidth = secondsColumns;
    sheet.getRangeByName('K1:K1').columnWidth = 5.00;

    // Set row heights
    sheet.getRangeByName('A5:A5').rowHeight = 40.00;
    sheet.getRangeByName('A6:A6').rowHeight = 38.00;

    // Add title
    sheet.getRangeByName('B2').setText('REPORTE DE VENTAS');
    sheet.getRangeByName('B2').cellStyle.fontSize = 35;
    sheet.getRangeByName('B2').cellStyle.bold = true;
    sheet.getRangeByName('B2').rowHeight = 105;
    sheet.getRangeByName('B3').rowHeight = 38;

    // Set Headers Style
    sheet.getRangeByName('B5:J5').cellStyle.borders.top.lineStyle =
        LineStyle.thin;
    sheet.getRangeByName('B5:J5').cellStyle.bold = true;
    sheet.getRangeByName('B5:G5').cellStyle.hAlign = HAlignType.left;
    sheet.getRangeByName('H5:J5').cellStyle.hAlign = HAlignType.right;

    // Add headers
    sheet.getRangeByName('B5').setText('FECHA');
    sheet.getRangeByName('C5').setText('CODIGO PRODUCTO');
    sheet.getRangeByName('D5').setText('CATEGORIA PRODUCTO');
    sheet.getRangeByName('E5').setText('ARTESANA');
    sheet.getRangeByName('F5').setText('COMUNIDAD');
    sheet.getRangeByName('G5').setText('FAMILIA');
    sheet.getRangeByName('H5').setText('CANTIDAD');
    sheet.getRangeByName('I5').setText('MONTO');
    sheet.getRangeByName('J5').setText('PRECIO U');

    // Merge cells for header and title
    sheet.getRangeByName('A1:K1').merge();
    sheet.getRangeByName('B2:E2').merge();

    _insertHeader();
    await insertImage('/assets/LOGOTIPO.png', 2, 8);
  }

  int addData(List<SalesData> salesDataList) {
    int currentRow = 6;
    for (var data in salesDataList) {
      sheet.getRangeByName('B$currentRow').setText(data.date);
      sheet.getRangeByName('C$currentRow').setValue(data.productCode);
      sheet.getRangeByName('D$currentRow').setText(data.categoryProduct);
      sheet.getRangeByName('E$currentRow').setText(data.artisan);
      sheet.getRangeByName('F$currentRow').setText(data.community);
      sheet.getRangeByName('G$currentRow').setText(data.family);
      sheet.getRangeByName('H$currentRow').setValue(data.quantity);
      sheet.getRangeByName('I$currentRow').setNumber(data.amount);
      sheet.getRangeByName('J$currentRow').setNumber(data.unitPrice);

      // Set currency format for "MONTO" and "PRECIO U" columns
      final montoCell = sheet.getRangeByName('I$currentRow');
      montoCell.setNumber(data.amount);
      montoCell.cellStyle.numberFormat = '"S/"#,##0.00';

      final totalCell = sheet.getRangeByName('J$currentRow');
      totalCell.setNumber(data.unitPrice);
      totalCell.cellStyle.numberFormat = '"S/"#,##0.00';

      // Set columns data alignment
      sheet.getRangeByName('B$currentRow:G$currentRow').cellStyle.hAlign =
          HAlignType.left;
      sheet.getRangeByName('B$currentRow:G$currentRow').cellStyle.vAlign =
          VAlignType.center;
      sheet.getRangeByName('H$currentRow:J$currentRow').cellStyle.hAlign =
          HAlignType.right;
      sheet.getRangeByName('H$currentRow:J$currentRow').cellStyle.vAlign =
          VAlignType.center;

      currentRow++;
    }

    // Add total
    sheet.getRangeByName('J${currentRow + 1}').setText('TOTAL');
    sheet.getRangeByName('J${currentRow + 1}').cellStyle.fontSize = 11;
    sheet.getRangeByName('J${currentRow + 1}').cellStyle.fontColor = '#b80000';
    sheet.getRangeByName('J${currentRow + 1}').cellStyle.bold = true;
    sheet.getRangeByName('J${currentRow + 1}').cellStyle.hAlign =
        HAlignType.right;

    final totalCell = sheet.getRangeByName('H${currentRow + 2}');
    totalCell.setFormula('=SUM(I6:I$currentRow)');
    totalCell.cellStyle.fontSize = 40;
    totalCell.cellStyle.hAlign = HAlignType.right;

    totalCell.cellStyle.numberFormat = '"S/"#,##0.00';

    // Merge total cells
    sheet.getRangeByName('H${currentRow + 2}:J${currentRow + 2}').merge();

    return currentRow;
  }

  List<int>? encode() {
    return excel.saveAsStream();
  }

  void dispose() {
    excel.dispose();
  }
}
