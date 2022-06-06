import 'package:digikalacurse/AllProduct.dart';
import 'package:digikalacurse/Model/SpecialViewModel.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:digikalacurse/Model/PageViewModel.dart';
import 'package:digikalacurse/Model/EventsModel.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PageViewModel>> pageViewFuture;
  late Future<List<SpecialViewModel>> specialViewFuture;
  late Future<List<EventsModel>> eventsFuture;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewFuture = sendRequstPageView();
    specialViewFuture = sendRequstSpecial();
    eventsFuture = sendRequesteEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("digikala"),
        backgroundColor: Colors.red,
        elevation: 5,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 250,
                child: FutureBuilder<List<PageViewModel>>(
                  future: pageViewFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PageViewModel>? model = snapshot.data;
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                              controller: pageController,
                              allowImplicitScrolling: true,
                              itemCount: model!.length,
                              itemBuilder: (context, position) {
                                return pageViewItem(model[position]);
                              }),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: model.length,
                              effect: ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                dotColor: Colors.white,
                                spacing: 3,
                                activeDotColor: Colors.red,
                              ),
                              onDotClicked: (index) =>
                                  pageController.animateToPage(index,
                                      duration: Duration(microseconds: 500),
                                      curve: Curves.bounceOut),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          fontSize: 60,
                          color: Colors.black,
                          dotSpacing: 5,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                child: Container(
                  height: 300,
                  color: Colors.red,
                  child: FutureBuilder<List<SpecialViewModel>>(
                    future: specialViewFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SpecialViewModel>? model = snapshot.data;
                        return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model!.length,
                            itemBuilder: (context, position) {
                              if (position == 0) {
                                return Container(
                                  height: 300,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      Padding(
                                        child: Image.asset(
                                          "images/pic.png",
                                          height: 230,
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 15, right: 10, left: 10),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Expanded(
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllProduct()));
                                              },
                                              child: Text(
                                                "مشاهده همه",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return specialOfferItem(model[position - 1]);
                              }
                            });
                      } else {
                        return JumpingDotsProgressIndicator(
                          fontSize: 60,
                          color: Colors.black,
                          dotSpacing: 5,
                        );
                      }
                    },
                  ),
                ),
                padding: EdgeInsets.only(top: 10),
              ),
              Container(
                width: double.infinity,
                child: FutureBuilder<List<EventsModel>>(
                  future: eventsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventsModel>? modle = snapshot.data;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 190,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        modle![0].imgUrl,
                                        fit: BoxFit.fill,
                                        width: 190,
                                      )),
                                ),
                                Container(
                                  height: 190,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        modle[1].imgUrl,
                                        fit: BoxFit.fill,
                                        width: 190,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 190,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        modle[2].imgUrl,
                                        fit: BoxFit.fill,
                                        width: 190,
                                      )),
                                ),
                                Container(
                                  height: 190,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        modle[3].imgUrl,
                                        fit: BoxFit.fill,
                                        width: 190,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 20,
                          )
                        ],
                      );
                    } else {
                      return JumpingDotsProgressIndicator(
                        fontSize: 60,
                        color: Colors.black,
                        dotSpacing: 5,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container specialOfferItem(SpecialViewModel specialViewModel) {
    return Container(
      width: 200,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  specialViewModel.imgUrl,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  specialViewModel.productName,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            specialViewModel.offPrice.toString() + "T",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            specialViewModel.price.toString() + "T",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.deepOrangeAccent,
                              ),
                              child: Center(
                                  child: Text(
                                specialViewModel.offPrecent.toString() + "%",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          width: 200,
        ),
      ),
    );
  }

  Future<List<PageViewModel>> sendRequstPageView() async {
    List<PageViewModel> model = [];

    var response = await Dio().get("https://irantechs.ir/selectpic.php");
    //print(response.data['photos'][0]['imgUrl']);

    for (var item in response.data['photo']) {
      model.add(PageViewModel(item['id'], item['imgUrl']));
    }

    return model;
  }

  Future<List<EventsModel>> sendRequesteEvents() async {
    List<EventsModel> models = [];
    var response = await Dio().get("https://irantechs.ir/selectevent.php");
    for (var item in response.data["product"]) {
      models.add(EventsModel(item["imgUrl"]));
    }
    return models;
  }

  Future<List<SpecialViewModel>> sendRequstSpecial() async {
    List<SpecialViewModel> model = [];
    var response = await Dio().get("https://irantechs.ir/selectproduct.php");

    for (var item in response.data['product']) {
      model.add(SpecialViewModel(
          item['id'],
          item['product_name'],
          item['price'],
          item['off_price'],
          item['off_precent'],
          item['imgUrl']));
    }
    return model;
  }

  Padding pageViewItem(PageViewModel pageViewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              pageViewModel.imgUrl,
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
