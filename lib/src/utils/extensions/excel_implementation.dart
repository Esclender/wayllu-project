// ignore_for_file: all

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelImplementation {
  late Workbook excel;
  late Worksheet sheet;

  ExcelImplementation() {
    excel = Workbook();
    sheet = excel.worksheets[0];
    sheet.showGridlines = false;
  }

  void setHeaders({CellStyle? style}) {
    //Set data in the worksheet.
    sheet.getRangeByName('A1:I1').columnWidth = 5.00;
  }

  void addRow() {
    sheet.getRangeByName('A1').setText('FECHA');
  }

  void addData() {
    addRow();
  }

  List<int>? encode() {
    return excel.saveAsStream();
  }

  void dispose() {
    excel.dispose();
  }
}
