import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/components/category_stat.dart';
import 'package:flutter_codefactory_practice2/components/hourly_stat.dart';
import 'package:flutter_codefactory_practice2/components/main_stat.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';
import 'package:flutter_codefactory_practice2/models/stat_model.dart';
import 'package:flutter_codefactory_practice2/repository/stat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
            future: StatRepository.fetchDataByItemCode(
              itemCode: ItemCode.PM10,
            ),
            builder: (context, snapshot) {
              return Column(
                children: [
                  MainStat(),
                  CategoryStat(),
                  const HourlyStat(),
                ],
              );
            }),
      ),
    );
  }
}
