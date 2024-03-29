
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:project_provider/models/cryptoModel/AllCryptoModel.dart';
import 'package:project_provider/network/ApiProvider.dart';
import 'package:project_provider/network/ResponseModel.dart';

class CryptoDataProvider extends ChangeNotifier{
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getTopMarketCapData() async {
    state = ResponseModel.loading("loading");

    response = await apiProvider.getTopMarketCapData();
    if (response.statusCode == 200) {
      dataFuture = AllCryptoModel.fromJson(response.data);
      state = ResponseModel.completed(dataFuture);

    }else {
      state = ResponseModel.error("error");
    }

    notifyListeners();
  }
  getTopGainers() async {
    state = ResponseModel.loading("loading");

    response = await apiProvider.getTopGainerData();
    if (response.statusCode == 200) {
      dataFuture = AllCryptoModel.fromJson(response.data);
      state = ResponseModel.completed(dataFuture);

    }else {
      state = ResponseModel.error("error");
    }

    notifyListeners();
  }
  getTopLosers() async {
    state = ResponseModel.loading("loading");

    response = await apiProvider.getTopLosersData();
    if (response.statusCode == 200) {
      dataFuture = AllCryptoModel.fromJson(response.data);
      state = ResponseModel.completed(dataFuture);

    }else {
      state = ResponseModel.error("error");
    }

    notifyListeners();
  }
}