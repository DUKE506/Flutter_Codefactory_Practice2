import 'package:flutter_codefactory_practice2/const/status_level.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/models/status_model.dart';

class StatusUtils {
  static StatusModel getStatusModelFromStat({
    required StatModel model,
  }) {
    final itemCode = model.itemCode;

    final index = statusLevels.indexWhere((e) {
      switch (itemCode) {
        case ItemCode.PM10:
          return model.stat < e.minPM10;
        case ItemCode.PM25:
          return model.stat < e.minPM25;
        case ItemCode.CO:
          return model.stat < e.minCO;
        case ItemCode.NO2:
          return model.stat < e.minNO2;
        case ItemCode.O3:
          return model.stat < e.minO3;
        case ItemCode.SO2:
          return model.stat < e.minSO2;
        default:
          throw Exception('존재하지 않는 ItemCode입니다.');
      }
    });

    if (index < 0) {
      throw Exception('Index를 찾지 못했습니다.');
    }
    return statusLevels[index - 1];
  }
}
