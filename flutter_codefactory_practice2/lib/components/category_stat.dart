import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';

class CategoryStat extends StatelessWidget {
  final List<int> numbers = List.generate(6, (idx) => idx);
  CategoryStat({super.key});

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
                _header(),
                _content(constraint),
              ],
            );
          }),
        ),
      ),
    );
  }

  //헤더
  Widget _header() {
    return Container(
      decoration: const BoxDecoration(
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
  Widget _content(BoxConstraints constraint) {
    return Expanded(
      child: Container(
          decoration: const BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              )),
          child: ListView(
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: List.generate(
                6,
                (idx) => _typeStatistics(
                      constraint,
                      '미세먼지',
                      'asset/img/bad.png',
                      '46.0',
                    )),
          )),
    );
  }

  //종류별 통계 상세
  Widget _typeStatistics(
      BoxConstraints constraint, String type, String url, String value) {
    return SizedBox(
      width: constraint.maxWidth / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(type),
          const SizedBox(
            height: 8.0,
          ),
          Image.asset(
            url,
            width: 50,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(value),
        ],
      ),
    );
  }
}
