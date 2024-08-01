
class DashboardItems{
  String? widgetIcon;
  String? widgetName;
  String? widgetDesc;
  String? widgetValue;

  DashboardItems({
    this.widgetIcon,
    this.widgetName,
    this.widgetValue,
    this.widgetDesc
});
  factory DashboardItems.fromJson(Map<String, dynamic> json) {
    return DashboardItems(
      widgetIcon: (json['widgetIcon'] != null)?  json['widgetIcon'] as String : "",
      widgetName: (json['widgetName'] != null)?  json['widgetName'] as String : "",
      widgetValue: (json['widgetValue'] != null)?  json['widgetValue'] as String : "",
      widgetDesc: (json['widgetDesc'] != null)?  json['widgetDesc'] as String : ""
    );
  }
}