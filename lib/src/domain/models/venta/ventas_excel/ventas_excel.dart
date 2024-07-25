import 'package:json_annotation/json_annotation.dart';

part 'ventas_excel.g.dart';

@JsonSerializable()
class SalesData {
  final String date;
  final String productCode;
  final String categoryProduct;
  final String artisan;
  final String community;
  final String family;
  final int quantity;
  final double amount;
  final double unitPrice;

  SalesData({
    required this.date,
    required this.categoryProduct,
    required this.productCode,
    required this.artisan,
    required this.community,
    required this.family,
    required this.quantity,
    required this.amount,
    required this.unitPrice,
  });

  factory SalesData.fromJson(Map<String, dynamic> json) =>
      _$SalesDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalesDataToJson(this);
}
