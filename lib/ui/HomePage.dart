

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:project_provider/helpers/decimalRounder.dart';
import 'package:project_provider/network/ResponseModel.dart';
import 'package:project_provider/providers/CryptoDataProvider.dart';
import 'package:project_provider/ui/ui_helper/HomePageView.dart';
import 'package:project_provider/ui/ui_helper/ShimmerHome.dart';
import 'package:project_provider/ui/ui_helper/ThemeSwither.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/cryptoModel/CryptoData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  final List<String> _choiceList = ['Top MarketCap','Top Gainers', 'Top Losers'];
  var _defaultChoice = 0;

  @override
  void initState() {
    super.initState();

    final cryptoProvider = Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();

  }
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: const [
          ThemeSwitcher()
        ],
        title: Text("Flutter course A"),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                            ),
                            onDotClicked: (index) => _pageViewController.animateToPage(index, duration: Duration(microseconds: 300), curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: 'Some sample text that takes some space.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 300),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(20),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                      ),
                      child: const Text("buy"),
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(20),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      child: const Text("sell"),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: List.generate(_choiceList.length, (index) {
                        return ChoiceChip(
                          label: Text(_choiceList[index]),
                          selected: _defaultChoice == index,
                          selectedColor: Colors.blue,
                          onSelected: (value) {
                            setState(() {
                              _defaultChoice = value ? index : _defaultChoice;
                            });
                          },
                        );
                      })
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 400,
                child: Consumer<CryptoDataProvider>(
                    builder: (context, cryptoDataProvider, child){
                      switch(cryptoDataProvider.state.status){
                        case Status.LOADING:
                          return ShimmerHome();
                        case Status.COMPLETED:
                          List<CryptoData>? model = cryptoDataProvider.dataFuture.data?.cryptoCurrencyList;
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
                                            Text(model[index].symbol!, style: textTheme.titleMedium,),
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
                                            Text("\$finalPrice", style: textTheme.bodySmall,),
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
                              itemCount: 10);
                        case Status.ERROR:
                          return Text(cryptoDataProvider.state.message);
                        default:
                          return Container();

                      }
                    }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
