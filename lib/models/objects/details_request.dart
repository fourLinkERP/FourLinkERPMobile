// To parse this JSON data, do
//
//     final detailsRequest = detailsRequestFromJson(jsonString);

import 'dart:convert';

DetailsRequest detailsRequestFromJson(String str) => DetailsRequest.fromJson(json.decode(str));

String detailsRequestToJson(DetailsRequest data) => json.encode(data.toJson());

class DetailsRequest {
  DetailsRequest({
    required this.details,
  });

  List<Detail> details;

  factory DetailsRequest.fromJson(Map<String, dynamic> json) => DetailsRequest(
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.cost,
    required this.total,
  });

  int categoryId;
  String categoryName;
  int amount;
  double cost;
  double total;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    amount: json["amount"],
    cost: json["cost"].toDouble(),
    total: json["total"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "amount": amount,
    "cost": cost,
    "total": total,
  };
}
