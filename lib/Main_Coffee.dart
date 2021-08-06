import 'package:animation_test_cafe/CoffeeConcept.dart';
import 'package:animation_test_cafe/Model/CoffeeModel.dart';
import 'package:flutter/material.dart';

class MainCoffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          print(details.primaryDelta);
          if (details.primaryDelta < -10) {
            Navigator.of(context)
                .push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
              return FadeTransition(
                opacity: animation,
                child: CoffeeConcept(),
              );
            }));
          }
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0XFFA89276),
                      Colors.white,
                    ])),
              ),
            ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.15,
              child: Hero(
                tag: coffees[0].name,
                child: Image.asset(coffees[0].image),
              ),
            ),
            Positioned(
              height: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: coffees[1].name,
                child: Image.asset(
                  coffees[1].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * 0.4,
              child: Hero(
                tag: coffees[2].name,
                child: Image.asset(
                  coffees[2].image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
