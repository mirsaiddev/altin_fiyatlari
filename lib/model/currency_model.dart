import 'dart:convert';

class CurrenyModel {
  final String code;
  final String ShortName;
  final String FullName;
  final double buying;
  final double selling;
  final int latest;
  final double changeRate;
  final double dayMin;
  final double dayMax;
  final String lastupdate;
  CurrenyModel({
    required this.code,
    required this.ShortName,
    required this.FullName,
    required this.buying,
    required this.selling,
    required this.latest,
    required this.changeRate,
    required this.dayMin,
    required this.dayMax,
    required this.lastupdate,
  });

  CurrenyModel copyWith({
    String? code,
    String? ShortName,
    String? FullName,
    double? buying,
    double? selling,
    int? latest,
    double? changeRate,
    double? dayMin,
    double? dayMax,
    String? lastupdate,
  }) {
    return CurrenyModel(
      code: code ?? this.code,
      ShortName: ShortName ?? this.ShortName,
      FullName: FullName ?? this.FullName,
      buying: buying ?? this.buying,
      selling: selling ?? this.selling,
      latest: latest ?? this.latest,
      changeRate: changeRate ?? this.changeRate,
      dayMin: dayMin ?? this.dayMin,
      dayMax: dayMax ?? this.dayMax,
      lastupdate: lastupdate ?? this.lastupdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'ShortName': ShortName,
      'FullName': FullName,
      'buying': buying,
      'selling': selling,
      'latest': latest,
      'changeRate': changeRate,
      'dayMin': dayMin,
      'dayMax': dayMax,
      'lastupdate': lastupdate,
    };
  }

  factory CurrenyModel.fromMap(Map<String, dynamic> map) {
    return CurrenyModel(
      code: map['code'] as String,
      ShortName: map['ShortName'] as String,
      FullName: map['FullName'] as String,
      buying: map['buying'].toDouble() as double,
      selling: map['selling'].toDouble() as double,
      latest: map['latest'].toInt() as int,
      changeRate: map['changeRate'].toDouble() as double,
      dayMin: map['dayMin'].toDouble() as double,
      dayMax: map['dayMax'].toDouble() as double,
      lastupdate: map['lastupdate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrenyModel.fromJson(String source) => CurrenyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrenyModel(code: $code, ShortName: $ShortName, FullName: $FullName, buying: $buying, selling: $selling, latest: $latest, changeRate: $changeRate, dayMin: $dayMin, dayMax: $dayMax, lastupdate: $lastupdate)';
  }

  @override
  bool operator ==(covariant CurrenyModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.ShortName == ShortName &&
        other.FullName == FullName &&
        other.buying == buying &&
        other.selling == selling &&
        other.latest == latest &&
        other.changeRate == changeRate &&
        other.dayMin == dayMin &&
        other.dayMax == dayMax &&
        other.lastupdate == lastupdate;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        ShortName.hashCode ^
        FullName.hashCode ^
        buying.hashCode ^
        selling.hashCode ^
        latest.hashCode ^
        changeRate.hashCode ^
        dayMin.hashCode ^
        dayMax.hashCode ^
        lastupdate.hashCode;
  }
}
