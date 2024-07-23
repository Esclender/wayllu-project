import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:wayllu_project/src/utils/extensions/excel_implementation.dart';

import '../../domain/models/venta/ventas_excel/ventas_excel.dart';

List<SalesData> salesDataList = [
  SalesData(
    date: '2024-17-20 14:30',
    item: 1,
    productCode: '013067001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
  SalesData(
    date: '2024-17-20 14:30',
    item: 2,
    productCode: '013048001',
    artisan: 'FELIPA RIOS',
    community: 'PATACANCHA',
    family: 'CAMINO DE MESA / PIE DE CAMA',
    quantity: 2,
    amount: 2.00,
    unitPrice: 1.00,
  ),
];

class ExcelUtil {
  Future<void> requestStoragePermission() async {
    // Check if storage permission is already granted
    if (await Permission.storage.isGranted) {
      print('Storage permission is already granted.');
      return;
    }

    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    // Handle the status of the permission request
    if (status.isGranted) {
      print('Storage permission granted.');
    } else if (status.isDenied) {
      print('Storage permission denied.');
    } else if (status.isPermanentlyDenied) {
      print(
          'Storage permission is permanently denied. Please enable it from settings.');
      // Optionally, open app settings so the user can grant permission manually
      openAppSettings();
    }
  }

  Future<void> generateAndSaveExcel(
    String fileName,
  ) async {
    final ExcelImplementation excelLibrary = ExcelImplementation();
    final int totalRows = excelLibrary.addData(salesDataList);
    excelLibrary.insertFooter(totalRows);
    excelLibrary.wrappingCells(totalRows);

    await requestStoragePermission();
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
    print('Excel file saved');
  }
}
