import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/utils/status_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class CategoryStat extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final Region region;
  CategoryStat({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _header(darkColor),
                _content(constraint, lightColor),
              ],
            );
          }),
        ),
      ),
    );
  }

  //헤더
  Widget _header(Color darkColor) {
    return Container(
      decoration: BoxDecoration(
        color: darkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '종류별 통계',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //내용
  Widget _content(BoxConstraints constraint, Color lightColor) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
              color: lightColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              )),
          child: ListView(
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: ItemCode.values
                .map((e) => _typeStatistics(
                    constraint, '미세먼지', 'asset/img/bad.png', '46.0', e))
                .toList(),
          )),
    );
  }

  //종류별 통계 상세
  Widget _typeStatistics(BoxConstraints constraint, String type, String url,
      String value, ItemCode itemCode) {
    return FutureBuilder(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(itemCode)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return Center();
          }

          final statModel = snapshot.data!;
          final statusModel =
              StatusUtils.getStatusModelFromStat(model: statModel);

          return SizedBox(
            width: constraint.maxWidth / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(itemCode.krName),
                const SizedBox(
                  height: 8.0,
                ),
                Image.asset(
                  statusModel.imgPath,
                  width: 50,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(statModel.stat.toString()),
              ],
            ),
          );
        });
  }
}
