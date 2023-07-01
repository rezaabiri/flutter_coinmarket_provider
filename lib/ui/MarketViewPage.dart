
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_provider/network/ResponseModel.dart';
import 'package:project_provider/providers/MarketViewProvider.dart';
import 'package:project_provider/ui/ui_helper/ThemeSwitcher.dart';
import 'package:provider/provider.dart';

import '../helpers/decimalRounder.dart';
import '../models/cryptoModel/CryptoData.dart';

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({Key? key}) : super(key: key);

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {

  @override
  void initState() {
    super.initState();

    final allCryptoProvider = Provider.of<MarketViewProvider>(context, listen: false);
    allCryptoProvider.getAllMarketCapData();
  }



  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;
    var primarySecondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
      backgroundColor: primaryColor,
      actions: const [
        ThemeSwitcher()
      ],
      title: Text("Flutter course A"),
      titleTextStyle: textTheme.displayMedium,
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    hintText: "Enter name",
                    prefixIcon: Icon(Icons.search_sharp),
                    prefixIconColor: Colors.grey,
                  )
                ),
              ),
              Container(
                height: height,
                child: Consumer<MarketViewProvider>(
                  builder: (context, allCryptoData, child){
                    switch(allCryptoData.state.status){
                      case Status.LOADING:
                        return Text("loading");
                      case Status.COMPLETED:
                        List<CryptoData>? model = allCryptoData.dataFuture.data?.cryptoCurrencyList;
                        int? size = model?.length;
                        return ListView.separated(

                            itemBuilder: (context, index){
                              var number = index + 1;
                              var tokenId = model![index].id;

                              MaterialColor filterColor = DecimalRounder.setColorFilter(model[index].quotes![0].percentChange24h);

                              var finalPrice = DecimalRounder.removePriceDecimals(model[index].quotes![0].price);

                              // percent change setup decimals and colors
                              var percentChange = DecimalRounder.removePercentDecimals(model[index].quotes![0].percentChange24h);

                              Color percentColor = DecimalRounder.setPercentChangesColor(model[index].quotes![0].percentChange24h);
                              Icon percentIcon = DecimalRounder.setPercentChangesIcon(model[index].quotes![0].percentChange24h);


                              return SizedBox(
                                height: height * 0.075,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(number.toString(), style: textTheme.bodySmall,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CachedNetworkImage(
                                        fadeInDuration: Duration(microseconds: 300),
                                        width: 32,
                                        height: 32,
                                        imageUrl: "https://s2.coinmarketcap.com/static/img/coins/64x64/$tokenId.png",
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(model[index].symbol!, style: textTheme.displaySmall,),
                                          Text(model[index].name!, style: textTheme.titleSmall,),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                            colorFilter:  ColorFilter.mode(filterColor, BlendMode.srcATop),
                                            child: SvgPicture.network("https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg"))
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(finalPrice, style: textTheme.bodySmall,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              percentIcon,
                                              Text(percentChange + "%", style: GoogleFonts.ubuntu(color: percentColor, fontSize: 13),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index){
                              return Divider();
                            },
                            itemCount: size!);
                      case Status.ERROR:
                        return Text("error");
                      default:
                        return Container();
                    }

                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
