
class PreventCustomerWithoutAttachments{
  bool? isPreventAddNewCustomerWithoutAttachments;

  PreventCustomerWithoutAttachments({
    this.isPreventAddNewCustomerWithoutAttachments
});

  factory PreventCustomerWithoutAttachments.fromJson(Map<String, dynamic> json) {
    return PreventCustomerWithoutAttachments(
      isPreventAddNewCustomerWithoutAttachments: (json['isPreventAddNewCustomerWithoutAttachments'] != null)?  json['isPreventAddNewCustomerWithoutAttachments'] as bool : true,
    );
  }
}