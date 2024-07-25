// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ventas_excel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesData _$SalesDataFromJson(Map<String, dynamic> json) => SalesData(
      date: json['date'] as String,
      categoryProduct: json['categoryProduct'] as String,
      productCode: json['productCode'] as String,
      artisan: json['artisan'] as String,
      community: json['community'] as String,
      family: json['family'] as String,
      quantity: json['quantity'] as int,
      amount: (json['amount'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$SalesDataToJson(SalesData instance) => <String, dynamic>{
      'date': instance.date,
      'productCode': instance.productCode,
      'categoryProduct': instance.categoryProduct,
      'artisan': instance.artisan,
      'community': instance.community,
      'family': instance.family,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'unitPrice': instance.unitPrice,
    };
