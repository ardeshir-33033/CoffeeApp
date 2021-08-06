import 'dart:math';

double doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();
final coffees = List.generate(
    names.length,
    (index) => Coffee(
          image: 'lib/images/${index + 1}.png',
          name: names[index],
          price: doubleInRange(random, 3, 7),
        ));

class Coffee {
  String name;
  String image;
  double price;

  Coffee({this.name, this.image, this.price});
}

final names = [
  "Iced Coffee Mocha",
  "Mocha",
  "Iced Caramel",
  "Latte",
  "Iced Latte",
  "Latte Mochiatto",
  "Coffee",
  "Iced Coffee",
  "Mocha2",
  "Caramel",
  "Latte2",
  "Iced Latte2",
  "Mochiatto",
  // "Coffee2",
];
