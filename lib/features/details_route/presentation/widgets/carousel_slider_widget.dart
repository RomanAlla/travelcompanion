import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Widget> items;
  final int count;
  int activeIndex;
  CarouselSliderWidget(
      {super.key,
      required this.items,
      required this.count,
      required this.activeIndex});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                widget.activeIndex = index;
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
        if (widget.items.length > 1)
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
                  dotColor: const Color.fromARGB(255, 206, 206, 206),
                ),
                activeIndex: widget.activeIndex,
                count: widget.items.length,
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
    );
  }
}
