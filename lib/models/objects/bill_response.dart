// To parse this JSON data, do
//
//     final billResponse = billResponseFromJson(jsonString);

import 'dart:convert';

BillResponse billResponseFromJson(String str) => BillResponse.fromJson(json.decode(str));

String billResponseToJson(BillResponse data) => json.encode(data.toJson());

class BillResponse {
  BillResponse({
    required this.code,
    required this.message,
    required this.result,
  });

  int code;
  String message;
  Data result;

  factory BillResponse.fromJson(Map<String, dynamic> json) => BillResponse(
    code: json["code"],
    message: json["message"],
    result: Data.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.technicalId,
    required this.couponId,
    required this.cost,
    required this.fat,
    required this.afterFat,
    required this.discountAmount,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.fisitaCost,
    required this.partsCost,
    required this.otherDetailsCost,
    required this.beforediscount,
    required this.afterDiscount,
    required this.fatValue,
    required this.discounted_wallet,
    required this.needed_cash,
    required this.tax_number,
    required this.cust_points,
    required this.is_edit,
    required this.technical_cost,
    required this.min_cost,
    required this.paid
  });

  int id;
  int orderId;
  int customerId;
  int technicalId;
  int couponId;
  double cost;
  double fat;
  double afterFat;
  double discountAmount;
  double total;
  DateTime createdAt;
  DateTime updatedAt;
  double fisitaCost;
  double partsCost;
  double otherDetailsCost;
  double beforediscount;
  double afterDiscount;
  double fatValue;
  double discounted_wallet;
  double needed_cash;
  double tax_number;
  double cust_points;
  double min_cost;
  double technical_cost;
  bool is_edit;
  int paid;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    technicalId: json["technical_id"],
    couponId: json["coupon_id"],
    is_edit: json["is_edit"],
    cost:( json["cost"] as num).toDouble(),
    fat: (json["fat"]as num).toDouble(),
    afterFat: (json["after_fat"]as num).toDouble(),
    discountAmount: (json["discount_amount"]as num).toDouble(),
    total: (json["total"]as num).toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fisitaCost: (json["fisita_cost"]as num).toDouble(),
    partsCost: (json["parts_cost"]as num).toDouble(),
    otherDetailsCost: (json["other_details_cost"]as num).toDouble(),
    beforediscount: (json["beforediscount"]as num).toDouble(),
    afterDiscount: (json["after_discount"]as num).toDouble(),
    fatValue: json["fat_value"].toDouble(),
    discounted_wallet: (json["discounted_wallet"]as num).toDouble(),
    needed_cash: (json["needed_cash"]as num).toDouble(),
    tax_number: (json["tax_number"]as num).toDouble(),
    cust_points: (json["cust_points"]as num).toDouble(),
    min_cost: (json["min_cost"]as num).toDouble(),
    technical_cost: (json["technical_cost"]as num).toDouble(),
    paid: json["paid"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "customer_id": customerId,
    "technical_id": technicalId,
    "coupon_id": couponId,
    "cost": cost,
    "fat": fat,
    "after_fat": afterFat,
    "discount_amount": discountAmount,
    "total": total,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "fisita_cost": fisitaCost,
    "parts_cost": partsCost,
    "other_details_cost": otherDetailsCost,
    "beforediscount": beforediscount,
    "after_discount": afterDiscount,
    "fat_value": fatValue,
    "is_edit": is_edit,

  };
}
