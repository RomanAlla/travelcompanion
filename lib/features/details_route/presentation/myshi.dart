import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelcompanion/features/routes/data/models/route_model.dart';

class Myshi extends StatefulWidget {
  final RouteModel route;
  final String routeId;

  Myshi({super.key, required this.routeId, required this.route});

  @override
  State<Myshi> createState() => _MyshiState();
}

class _MyshiState extends State<Myshi> {
  late final List<Widget> myItems;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    myItems = widget.route.photoUrls
            ?.map((url) => Container(
                  width: double.infinity,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      items: myItems,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        height: 300,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlay: true,
                      ),
                    ),
                    if (myItems.length > 1)
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedSmoothIndicator(
                            effect: WormEffect(
                              type: WormType.thinUnderground,
                              spacing: 3,
                              dotHeight: 6,
                              dotWidth: 6,
                              activeDotColor: Colors.white,
                              dotColor:
                                  const Color.fromARGB(255, 206, 206, 206),
                            ),
                            activeIndex: currentIndex,
                            count: myItems.length,
                          ),
                        ),
                      ),
                    Positioned(
                      top: 25,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                border: null,
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    border: null,
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    border: null,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'fsdnjfjsdjkfklsdkjlflskjdrwehjrhjkwehjkrjhkwejhkr',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '4.9',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '120 отзывов',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(40)),
                            child: Center(
                                child: Text(
                              'Тропики',
                              style: TextStyle(color: Colors.green),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.route.creatorName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Автор маршрута',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '4.8',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('5 маршрутов',
                                          style: TextStyle(color: Colors.grey))
                                    ],
                                  ),
                                ],
                              ),
                              Icon(Icons.verified)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
