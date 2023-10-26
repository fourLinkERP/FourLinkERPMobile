// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromJson(jsonString);

import 'dart:convert';

OffersResponse offersResponseFromJson(String str) => OffersResponse.fromJson(json.decode(str));

String offersResponseToJson(OffersResponse data) => json.encode(data.toJson());

class OffersResponse {
    OffersResponse({
        required this.code,
        required this.message,
        required this.result,
    });

    int code;
    String message;
    List<ResultOffers> result;

    factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
        code: json["code"],
        message: json["message"],
        result: List<ResultOffers>.from(json["result"].map((x) => ResultOffers.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class ResultOffers {
    ResultOffers({
        required this.id,
        required this.orderId,
        required this.technicalId,
        required this.cost,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.category,
        required this.technical,
        required this.order,
    });

    int id;
    int orderId;
    int technicalId;
    double cost;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    Category category;
    Technical technical;
    Order order;

    factory ResultOffers.fromJson(Map<String, dynamic> json) => ResultOffers(
        id: json["id"],
        orderId: json["order_id"],
        technicalId: json["technical_id"],
        cost: json["cost"].toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        technical: Technical.fromJson(json["technical"]),
        order: Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "technical_id": technicalId,
        "cost": cost,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "technical": technical.toJson(),
        "order": order.toJson(),
    };
}

class Category {
    Category({
        required this.id,
        required this.nameAr,
        required this.nameEn,
        required this.nameRd,
        required this.parentId,
        this.cost,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nameAr;
    String nameEn;
    String nameRd;
    int parentId;
    dynamic cost;
    dynamic createdAt;
    dynamic updatedAt;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        nameRd: json["name_rd"],
        parentId: json["parent_id"],
        cost: json["cost"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "name_rd": nameRd,
        "parent_id": parentId,
        "cost": cost,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Order {
    Order({
        required this.id,
        required this.customerId,
        required this.categoryId,
        this.technicalId,
        required this.type,
        required this.state,
        required this.getParts,
        required this.paymentMethodId,
        this.notes,
        required this.address,
        required this.rate,
        required this.createdAt,
        required this.updatedAt,
        required this.date,
        this.customerConfirm,
        this.technicalConfirm,
        this.code,
        this.codeDate,
        required this.category,
    });

    int id;
    int customerId;
    int categoryId;
    dynamic technicalId;
    int type;
    int state;
    int getParts;
    int paymentMethodId;
    dynamic notes;
    String address;
    int rate;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime date;
    dynamic customerConfirm;
    dynamic technicalConfirm;
    dynamic code;
    dynamic codeDate;
    Category category;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        customerId: json["customer_id"],
        categoryId: json["category_id"],
        technicalId: json["technical_id"],
        type: json["type"],
        state: json["state"],
        getParts: json["get_parts"],
        paymentMethodId: json["payment_method_id"],
        notes: json["notes"],
        address: json["address"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        date: DateTime.parse(json["date"]),
        customerConfirm: json["customer_confirm"],
        technicalConfirm: json["technical_confirm"],
        code: json["code"],
        codeDate: json["code_date"],
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "category_id": categoryId,
        "technical_id": technicalId,
        "type": type,
        "state": state,
        "get_parts": getParts,
        "payment_method_id": paymentMethodId,
        "notes": notes,
        "address": address,
        "rate": rate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "date": date.toIso8601String(),
        "customer_confirm": customerConfirm,
        "technical_confirm": technicalConfirm,
        "code": code,
        "code_date": codeDate,
        "category": category.toJson(),
    };
}

class Technical {
    Technical({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.image,
        required this.balance,
        required this.mobile,
        required this.code,
        required this.jobId,
        required this.latitude,
        required this.longitude,
        required this.lang,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.nationalityId,
        required this.path,
        required this.address,
    });

    int id;
    String firstName;
    String lastName;
    String image;
    double balance;
    String mobile;
    String code;
    int jobId;
    String latitude;
    String longitude;
    String lang;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    int nationalityId;
    String path;
    String address;

    factory Technical.fromJson(Map<String, dynamic> json) => Technical(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        balance: (json["balance"]as num).toDouble(),
        mobile: json["mobile"],
        code: json["code"],
        jobId: json["job_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lang: json["lang"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nationalityId: json["nationality_id"],
        path: json["path"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "balance": balance,
        "mobile": mobile,
        "code": code,
        "job_id": jobId,
        "latitude": latitude,
        "longitude": longitude,
        "lang": lang,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nationality_id": nationalityId,
        "path": path,
        "address": address,
    };
}
