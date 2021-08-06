import 'package:animation_test_cafe/Model/CoffeeModel.dart';
import 'package:flutter/material.dart';

class CoffeeDetails extends StatelessWidget {
  CoffeeDetails({this.coffee});

  final Coffee coffee;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: Hero(
              tag: 'text${coffee.name}',
              child: Material(
                color: Colors.white,
                child: Text(
                  coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Hero(
                  tag: coffee.name,
                  child: Image.asset(
                    coffee.image,
                    fit: BoxFit.fitHeight,
                  ),
                )),
                Positioned(
                    left: size.width * 0.05,
                    bottom: 0,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                            offset: Offset(-100 * value, 240 * value),
                            child: child,
                        );
                      },
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        '\$${coffee.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
