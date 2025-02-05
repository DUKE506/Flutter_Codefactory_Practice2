import 'package:dio/dio.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class StatRepository {
  static Future<void> fetchData() async {
    final isar = GetIt.I<Isar>();

    final now = DateTime.now();
    final compareDateTimeTarget =
        DateTime(now.year, now.month, now.day, now.hour);

    final count = await isar.statModels
        .filter()
        .dateTimeEqualTo(compareDateTimeTarget)
        .count();

    if (count > 0) {
      print('데이터가 존재합니다. : $count');
      return;
    }

    for (ItemCode itemCode in ItemCode.values) {
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }

  static Future<List<StatModel>> fetchDataByItemCode({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'cliP2qOfIJETrocLkoQoJHzmkFfOdag9WSJ9XUJP7uU2p+Qv7pu/wvWaCMSGukTawYI3DTy7kR+1hI2yCkPtxw==',
        'returnType': 'json',
        'numOfRow': 100,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemList =
        response.data['response']['body']['items'] as List<dynamic>;

    List<StatModel> stats = [];

    final List<String> skipKey = [
      'dataTime',
      'itemCode',
      'dataGubun',
    ];

    for (Map<String, dynamic> item in rawItemList) {
      final dateTime = DateTime.parse(item['dataTime']);
      for (String key in item.keys) {
        if (skipKey.contains(key)) {
          continue;
        }
        final region = Region.values.firstWhere((e) => e.name == key);
        final stat = double.parse(item[key]);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dateTime = dateTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .dateTimeEqualTo(dateTime)
            .itemCodeEqualTo(itemCode)
            .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(
          () async {
            await isar.statModels.put(statModel);
          },
        );
      }
    }

    return stats;
  }
}
