import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:women_safety/utils/quotes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:women_safety/widgets/home_widgets/safeWebview.dart';


class CustomeCarousel extends StatefulWidget {
  const CustomeCarousel({super.key});

  @override
  State<CustomeCarousel> createState() => _CustomeCarouselState();
}

class _CustomeCarouselState extends State<CustomeCarousel> {
  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: List.generate(
            imageSliders.length,
            (index) => Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        navigateToRoute(
                          context,
                          SafeWebView(
                            url: "https://tribune.com.pk/article/97552/16-amazing-pakistani-women-who-have-made-us-proud",
                          ),
                        );
                      } else if (index == 1) {
                        navigateToRoute(
                          context,
                          SafeWebView(
                            url:
                                "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239"
                          
                          ),
                        );
                      } else if (index == 2) {
                        navigateToRoute(
                          context,
                          SafeWebView(
                            url:
                                "https://www.thefamouspeople.com/pakistan-women.php"
                          ),
                        );
                      } else {
                        navigateToRoute(
                          context,
                          SafeWebView(
                            url:
                                "https://bolojawan.com/14-pakistani-women-who-made-history/"
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [Colors.black.withOpacity(0.5),
                          Colors.transparent]),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageSliders[index]))),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              articaleTtle[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5)),
                            ),
                          )),
                    ),
                  ),
                )),
        options: CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
