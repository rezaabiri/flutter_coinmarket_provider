
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:project_provider/models/cryptoModel/AllCryptoModel.dart';
import 'package:project_provider/network/ApiProvider.dart';
import 'package:project_provider/network/ResponseModel.dart';

class MarketViewProvider extends ChangeNotifier{
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getAllMarketCapData() async {
    state = ResponseModel.loading("loading");

    response = await apiProvider.getAllCryptoData();
    if (response.statusCode == 200) {
      dataFuture = AllCryptoModel.fromJson(response.data);
      state = ResponseModel.completed(dataFuture);

    }else {
      state = ResponseModel.error("error");
    }

    notifyListeners();
  }
}