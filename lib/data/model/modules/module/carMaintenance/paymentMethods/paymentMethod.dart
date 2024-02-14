
class PaymentMethod{
  int? id;
  String? paymentMethodCode;
  String? paymentMethodNameAra;
  String? paymentMethodNameEng;

  PaymentMethod({
    this.id,
    this.paymentMethodCode ,
    this.paymentMethodNameAra,
    this.paymentMethodNameEng,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: (json['id'] != null) ? json['id'] as int : 0,
      paymentMethodCode: (json['paymentMethodCode'] != null) ? json['paymentMethodCode'] as String : " ",
      paymentMethodNameAra: (json['paymentMethodNameAra'] != null) ? json['paymentMethodNameAra'] as String : " ",
      paymentMethodNameEng: (json['paymentMethodNameEng'] != null) ? json['paymentMethodNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $paymentMethodNameAra }';
  }
}