class DataModel {
  String name;
  String img;
  int people;
  int price;
  int star;
  String description;
  String location;

  DataModel({
    required this.description,
    required this.img,
    required this.location,
    required this.name,
    required this.people,
    required this.price,
    required this.star,
  });

  factory DataModel.fromJon(Map<String, dynamic> jsonData) {
    return DataModel(
      description: jsonData["description"],
      img: jsonData["img"],
      location: jsonData["location"],
      name: jsonData["name"],
      people: jsonData["people"],
      price: jsonData["price"],
      star: jsonData["star"],
    );
  }
}
