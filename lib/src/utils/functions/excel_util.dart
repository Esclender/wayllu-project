import 'dart:io';
import 'package:wayllu_project/src/utils/extensions/excel_implementation.dart';

class ExcelUtil {
  Future<void> generateAndSaveExcel(
    String fileName,
  ) async {
    // Create an instance of ExcelLibrary
    final ExcelImplementation excelLibrary = ExcelImplementation();

    // Set headers with styles
    excelLibrary.setHeaders();

    // Add data to the Excel sheet
    excelLibrary.addData();

    // Save the Excel file to device storage
    await _saveExcelFile(excelLibrary.encode(), fileName);
    excelLibrary.dispose();
  }

  Future<void> _saveExcelFile(List<int>? bytes, String fileName) async {
    if (bytes == null) {
      throw Exception('Failed to generate Excel file.');
    }

    // Get the application's documents directory
    final Directory downloadsDir = Directory('/storage/emulated/0/Download');
    final String appDocPath = downloadsDir.path;

    // Specify the file path and name
    final String filePath = '$appDocPath/$fileName.xlsx';

    // Save the Excel file
    File(filePath).writeAsBytesSync(bytes);

    print('Excel file saved at: $filePath');
  }
}

// void main() async {
//   // Example usage of the ExcelUtil class
//   ExcelUtil excelUtil = ExcelUtil();

//   // Define the headers for the Excel file
//   List<String> headers = ['Name', 'Age', 'Occupation'];

//   // Define the data to be added to the Excel file
//   List<List<dynamic>> data = [
//     ['Alice', 28, 'Engineer'],
//     ['Bob', 34, 'Designer'],
//     ['Charlie', 22, 'Developer'],
//   ];

//   // Generate and save the Excel file
//   await excelUtil.generateAndSaveExcel('CustomExcel');
// }
