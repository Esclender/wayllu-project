import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wayllu_project/src/presentation/cubit/ventas_list_cubit.dart';
import 'package:wayllu_project/src/utils/extensions/excel_implementation.dart';

class GenerateExcelParams {
  final List<Map<String, dynamic>> salesDataList;
  final SendPort sendPort;
  final ExcelImplementation excelImplementation;

  GenerateExcelParams(
    this.salesDataList,
    this.sendPort,
    this.excelImplementation,
  );
}

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

  String generateRandomFileName() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);
    return 'REPORTE_$formattedDate';
  }

  Future<void> generateAndSaveExcel(
    List<Map<String, dynamic>> salesDataList,
    ExcelImplementation excelLibrary,
  ) async {
    // final ExcelImplementation excelLibrary = ExcelImplementation();
    final int totalRows = excelLibrary.addData(salesDataList);
    excelLibrary.insertFooter(totalRows);
    excelLibrary.wrappingCells(totalRows);

    await _saveExcelFile(excelLibrary.encode(), generateRandomFileName());
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

  Future<void> generateAndSaveExcelEntryPoint(
    GenerateExcelParams params,
  ) async {
    await generateAndSaveExcel(
      params.salesDataList,
      params.excelImplementation,
    );

    params.sendPort.send(true);
  }

  Future<void> generateExcelInBackground(
    BuildContext context,
    ExcelImplementation excelLibrary,
  ) async {
    final ventasListCubit = context.read<VentasListCubit>();
    final salesDataList = await ventasListCubit.getSalesData();

    final ReceivePort receivePort = ReceivePort();
    // Spawn the isolate
    await Isolate.spawn(
      generateAndSaveExcelEntryPoint,
      // receivePort.sendPort,
      GenerateExcelParams(
        salesDataList,
        receivePort.sendPort,
        excelLibrary,
      ),
    );

    // Listen for messages from the isolate
    receivePort.listen((message) {
      receivePort.close();
    });
  }
}
