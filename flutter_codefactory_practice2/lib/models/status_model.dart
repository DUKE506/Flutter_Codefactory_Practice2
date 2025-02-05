// /**
//  * 1) 최고
//  *
//  * 초미세먼지 : 0-8
//  * 이산화질소 : 0-0.02
//  * 일산화탄소 : 0-0.02
//  * 이황산가스 : 0-0.01
//  *
//  *
//  * 2) 좋음
//  *
//  * 초미세먼지 : 9-15
//  * 이산화질소 : 0.02-0.03
//  * 일산화탄소 : 1-2
//  * 이황산가스 : 0.01-0.02
//  *
//  *
//  * 3) 양호호
//  *
//  * 초미세먼지 : 16-20
//  * 이산화질소 : 0.03-0.05
//  * 일산화탄소 : 2-5.5
//  * 이황산가스 : 0.02-0.04
//  *
//  *
//  * 4) 보통
//  *
//  * 초미세먼지 : 21-25
//  * 이산화질소 : 0.05-0.06
//  * 일산화탄소 : 5.5-9
//  * 이황산가스 : 0.04-0.05
//  *
//  *
//  * 5) 나쁨
//  *
//  * 초미세먼지 : 26-37
//  * 이산화질소 : 0.06-0.13
//  * 일산화탄소 : 9-12
//  * 이황산가스 : 0.05-0.1
//  *
//  *
//  *
//  *  6) 상당히 나쁨
//  *
//  * 초미세먼지 : 38-50
//  * 이산화질소 : 0.13-0.2
//  * 일산화탄소 : 12-15
//  * 이황산가스 : 0.1-0.15

//  *  7) 매우우 나쁨
//  *
//  * 초미세먼지 : 51-75
//  * 이산화질소 : 0.2-1.1
//  * 일산화탄소 : 15-32
//  * 이황산가스 : 0.15-0.16

//  *  6) 상당히 나쁨
//  *
//  * 초미세먼지 : 76~
//  * 이산화질소 : 1.1~
//  * 일산화탄소 : 32~
//  * 이황산가스 : 0.16~

//  */

import 'package:flutter/material.dart';

class StatusModel {
  //단계
  final int level;
  //단계 이름
  final String label;
  //주색상
  final Color primaryColor;
  //어두운 색상
  final Color darkColor;
  //밝은 색상
  final Color lightColor;
  //폰트색상
  final Color fontColor;
  //이모티콘이미지
  final String imgPath;
  //코멘트
  final String comment;
  //미세먼지 최소치
  final double minPM10;
  final double minPM25;
  final double minO3;
  //이산화질소 최소치
  final double minNO2;
  //일산화탄소 최소치
  final double minCO;
  //이황산가스 최소치
  final double minSO2;

  const StatusModel({
    required this.level,
    required this.label,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.fontColor,
    required this.imgPath,
    required this.comment,
    required this.minPM10,
    required this.minPM25,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
  });
}
