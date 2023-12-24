import 'package:fourlinkmobileapp/ui/module/DashboardCharts/resources/designChart.dart';
import 'urls.dart';

enum ChartType { line, bar, pie, scatter, radar }

extension ChartTypeExtension on ChartType {
  String get displayName => '$simpleName Chart';

  String get simpleName {
    switch (this) {
      case ChartType.line:
        return 'Line';
      case ChartType.bar:
        return 'Bar';
      case ChartType.pie:
        return 'Pie';
      case ChartType.scatter:
        return 'Scatter';
      case ChartType.radar:
        return 'Radar';
    }
  }

  String get documentationUrl => Urls.getChartDocumentationUrl(this);

  String get assetIcon => AppAssets.getChartIcon(this);
}