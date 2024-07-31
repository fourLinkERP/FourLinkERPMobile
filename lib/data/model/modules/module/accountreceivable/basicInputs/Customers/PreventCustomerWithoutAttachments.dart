
class PreventCustomerWithoutAttachments{
  bool? isPreventCustomerWithoutAttachments;

  PreventCustomerWithoutAttachments({
    this.isPreventCustomerWithoutAttachments
});

  factory PreventCustomerWithoutAttachments.fromJson(Map<String, dynamic> json) {
    return PreventCustomerWithoutAttachments(
      isPreventCustomerWithoutAttachments: (json['isPreventCustomerWithoutAttachments'] != null)?  json['isPreventCustomerWithoutAttachments'] as bool : true,
    );
  }
}