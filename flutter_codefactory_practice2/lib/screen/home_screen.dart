import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/components/category_stat.dart';
import 'package:flutter_codefactory_practice2/components/hourly_stat.dart';
import 'package:flutter_codefactory_practice2/components/main_stat.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/repository/stat_repository.dart';
import 'package:flutter_codefactory_practice2/utils/status_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.seoul;
  @override
  void initState() {
    super.initState();
    StatRepository.fetchData();
    getCount();
  }

  getCount() async {
    print(await GetIt.I<Isar>().statModels.count());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(ItemCode.PM10)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          final statModel = snapshot.data!;
          final statusModel =
              StatusUtils.getStatusModelFromStat(model: statModel);

          return Scaffold(
            drawer: Drawer(
              backgroundColor: statusModel.darkColor,
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    child: Text(
                      '지역 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ...Region.values
                      .map((e) => ListTile(
                            selected: e == region,
                            tileColor: Colors.white,
                            selectedTileColor: statusModel.lightColor,
                            selectedColor: Colors.black,
                            onTap: () {
                              setState(() {
                                region = e;
                              });
                              Navigator.of(context).pop();
                            },
                            title: Text(e.KrName),
                          ))
                      .toList()
                ],
              ),
            ),
            // appBar: AppBar(
            //   backgroundColor: statusModel.primaryColor,
            //   surfaceTintColor: statusModel.primaryColor,
            // ),
            backgroundColor: statusModel.primaryColor,
            body: CustomScrollView(
              slivers: [
                MainStat(
                  primaryColor: statusModel.primaryColor,
                  region: region,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CategoryStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                      HourlyStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
// FutureBuilder<List<StatModel>>(
//                   future: StatRepository.fetchDataByItemCode(
//                     itemCode: ItemCode.PM10,
//                   ),
//                   builder: (context, snapshot) {
//                     return Column(
//                       children: [
//                         MainStat(
//                           region: region,
//                         ),
//                         CategoryStat(
//                           region: region,
//                           darkColor: statusModel.darkColor,
//                           lightColor: statusModel.lightColor,
//                         ),
//                         HourlyStat(
//                           region: region,
//                           darkColor: statusModel.darkColor,
//                           lightColor: statusModel.lightColor,
//                         ),
//                       ],
//                     );
//                   }),
