import 'dart:math';

import 'package:animation_test_cafe/CoffeeDetail.dart';
import 'package:animation_test_cafe/Model/CoffeeModel.dart';
import 'package:flutter/material.dart';

class CoffeeConcept extends StatefulWidget {
  CoffeeConcept({Key key}) : super(key: key);

  @override
  _CoffeeConceptState createState() => _CoffeeConceptState();
}

class _CoffeeConceptState extends State<CoffeeConcept> {
  PageController pageController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  PageController textController = PageController(initialPage: _initialPage.toInt());

  double currentPage = _initialPage;
  double textPage = _initialPage;
  static const _initialPage = 2.0;

  void scrollListener() {
    setState(() {
      currentPage = pageController.page;
    });
  }

  void textListener() {
    setState(() {
      textPage = currentPage;
    });
  }

  @override
  void initState() {
    pageController.addListener(scrollListener);
    textController.addListener(textListener);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(scrollListener);
    pageController.dispose();
    textController.removeListener(scrollListener);
    textController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<double> val = [];
    var range = Random();
    for(var i = 0 ; i<100 ; i++){
      val.add(range.nextDouble() * i);
    }
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black ,),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 150,
                  offset: Offset.zero,
                  spreadRadius: 150,
                )
              ]),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, -100 * value),
                    child: child,
                  );
                },
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                            itemCount: coffees.length,
                            controller: textController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final opacity =
                                  (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                              return Opacity(
                                opacity: opacity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                                  child:Hero(
                                    tag: "text${coffees[index].name}",
                                    child: Material(
                                      child: Text(
                                        coffees[index].name,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          '\$${coffees[currentPage.toInt()].price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 30),
                          key: Key(coffees[currentPage.toInt()].name),
                        ))
                  ],
                ),
              )),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: names.length,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    textController.animateToPage(value,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  }
                },
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  print(result);
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 650),
                          pageBuilder: (context, animation, _) {
                            return FadeTransition(
                              opacity: animation,
                              child: CoffeeDetails(coffee: coffee,),
                            );
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(0.0, size.height / 2 * (1 - value).abs())
                          ..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: coffee.name,
                              child: Image.asset(
                                coffee.image,
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
