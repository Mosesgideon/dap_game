class GameWinner {
  String username;
  String image;
  List selection;
  DateTime? timePlayed;
  String amount;

  GameWinner(
      {required this.username,
      required this.image,
      required this.selection,
      required this.amount,
       this.timePlayed });
}
