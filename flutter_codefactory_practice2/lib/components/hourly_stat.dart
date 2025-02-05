import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/utils/status_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  const HourlyStat({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map((itemCode) => FutureBuilder(
              future: GetIt.I<Isar>()
                  .statModels
                  .filter()
                  .regionEqualTo(region)
                  .itemCodeEqualTo(itemCode)
                  .sortByDateTimeDesc()
                  .limit(24)
                  .findAll(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final stats = snapshot.data!;

                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _header(title: itemCode.krName),
                          _content(statModel: stats),
                        ],
                      ),
                    ),
                  ),
                );
              }))
          .toList(),
    );
  }

  //헤더
  Widget _header({
    required String title,
  }) {
    return Container(
      decoration: const BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '시간별 ${title}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // 내용
  Widget _content({
    required List<StatModel> statModel,
  }) {
    return Column(
      children: statModel
          .map((model) => _timeLineItem(
                model.dateTime.hour.toString().padLeft(0, '2'),
                StatusUtils.getStatusModelFromStat(model: model).imgPath,
                StatusUtils.getStatusModelFromStat(model: model).label,
              ))
          .toList(),
      // children: List.generate(
      //   24,
      //   (idx) => _timeLineItem(
      //     idx.toString(),
      //     'asset/img/best.png',
      //     '보통',
      //   ),
      // ),
    );
  }

  //시간별 항목
  Widget _timeLineItem(
    String time,
    String url,
    String status,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('$time시'),
          ),
          Expanded(
            child: Image.asset(
              url,
              height: 20,
            ),
          ),
          Expanded(
            child: Text(
              status,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
