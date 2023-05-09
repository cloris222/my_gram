import '../table/demo_table.dart';

/// 範例用
class DemoData {
  const DemoData({this.id});

  final num? id;

  static DemoData fromJson(Map<String, Object?> json) =>
      DemoData(
        id: json[DemoTable.id] as num,
      );

  Map<String, Object?> toJson() => {
        DemoTable.id: id,
      };

  DemoData copy({
    num? id,
  }) =>
      DemoData(
        id: id ?? this.id,
      );
}
