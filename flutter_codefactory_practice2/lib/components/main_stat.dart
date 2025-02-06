import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_codefactory_practice2/const/status_level.dart';
import 'package:flutter_codefactory_practice2/main.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/utils/date_utils.dart';
import 'package:flutter_codefactory_practice2/utils/status_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class MainStat extends StatelessWidget {
  final Color primaryColor;
  final Region region;

  final ts = TextStyle(
    color: Colors.white,
    fontSize: 40.0,
  );

  MainStat({
    super.key,
    required this.region,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      title: SizedBox(
        width: double.infinity,
        child: Text(
          region.KrName,
          textAlign: TextAlign.center,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<StatModel?>(
                future: GetIt.I<Isar>()
                    .statModels
                    .filter()
                    .regionEqualTo(region)
                    .itemCodeEqualTo(ItemCode.PM10)
                    .sortByDateTimeDesc()
                    .findFirst(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('데이터가 존재하지 않습니다.'),
                    );
                  }

                  final statModel = snapshot.data!;

                  final status =
                      StatusUtils.getStatusModelFromStat(model: statModel);

                  return Column(
                    children: [
                      _location(statModel.region.KrName),
                      _date(
                          DateUtils.DateTimeToString(date: statModel.dateTime)),
                      SizedBox(
                        height: 20.0,
                      ),
                      _image(
                        context,
                        status.imgPath,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _status(status.label),
                      _comment(status.comment),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  //지역
  Widget _location(String title) {
    return Text(
      title,
      style: ts.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  //날짜
  Widget _date(String date) {
    return Text(
      date,
      style: ts.copyWith(
        fontSize: 20.0,
      ),
    );
  }

  //뱃지
  Widget _image(BuildContext context, String url) {
    return Image.asset(
      url,
      width: MediaQuery.of(context).size.width / 2,
    );
  }

  //상태
  Widget _status(String state) {
    return Text(
      state,
      style: ts.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  //코멘트
  Widget _comment(String comment) {
    return Text(
      comment,
      style: ts.copyWith(
        fontSize: 20.0,
      ),
    );
  }
}
