import 'package:flutter/material.dart';
import 'package:flutter_codefactory_practice2/const/colors.dart';

class HourlyStat extends StatelessWidget {
  const HourlyStat({super.key});

  @override
  Widget build(BuildContext context) {
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
              _header(),
              _content(),
            ],
          ),
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
          )),
      child: const Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '시간별 미세먼지',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // 내용
  Widget _content() {
    return Column(
      children: List.generate(
        24,
        (idx) => _timeLineItem(
          idx.toString(),
          'asset/img/best.png',
          '보통',
        ),
      ),
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
            child: Text(time),
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
