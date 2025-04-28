import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/tip_model.dart';

class TipController extends GetxController {
  RxList<TipModel> tips = <TipModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTips();
  }

  Future<void> loadTips() async {
    final String response = await rootBundle.loadString('lib/resources/assets/Others/json data/tips.json');
    final data = await json.decode(response);
    final List tipsData = data['tips'];
    tips.value = tipsData.map((e) => TipModel.fromJson(e)).toList();
  }
}
