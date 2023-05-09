class PlaceLocation {
  PlaceLocation({
    required this.id,
    required this.name,
    required this.address,
  });

  String id;
  String name;
  String address;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) => PlaceLocation(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {};
}
