enum PriceType { multiple, specific }

class GamePrice {
  final int id;
  final PriceType type;
  final int value;

  GamePrice(this.id, this.type, this.value);

  String get displayText {
    if (type == PriceType.multiple) {
      return "🎉 x$value";
    } else {
      return "🎉${value.toString()}";
    }
  }
}
