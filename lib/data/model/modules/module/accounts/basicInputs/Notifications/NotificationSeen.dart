
class NotificationSeenData{
  int? id;
  String? workFlowTransactionsId;
  bool? isSeen;

  NotificationSeenData({
    this.id,
    this.workFlowTransactionsId,
    this.isSeen
});
  factory NotificationSeenData.fromJson(Map<String, dynamic> json){
    return NotificationSeenData(
      id: (json['id'] != null) ? json['id'] as int : 0,
      workFlowTransactionsId: (json['workFlowTransactionsId'] != null) ? json['workFlowTransactionsId'] as String: "",
      isSeen: (json['isSeen'] != null) ? json['isSeen'] as bool : false,
    );
  }
}