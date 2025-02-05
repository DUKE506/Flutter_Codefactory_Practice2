import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/main.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class MainStat extends StatelessWidget {
  final ts = TextStyle(
    color: Colors.white,
    fontSize: 40.0,
  );
  MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<StatModel?>(
            future: GetIt.I<Isar>()
                .statModels
                .filter()
                .regionEqualTo(Region.seoul)
                .itemCodeEqualTo(ItemCode.PM10)
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

              final statModel = snapshot.data;

              return Column(
                children: [
                  _location(statModel!.region.KrName),
                  _date(''),
                  SizedBox(
                    height: 20.0,
                  ),
                  _image(
                    context,
                    'asset/img/good.png',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _status('보통'),
                  _comment('나쁘지 않네요!'),
                ],
              );
            }),
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
