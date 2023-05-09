class CustomLocation {
  CustomLocation({
    required this.id,
    required this.name,
    required this.location,
  });

  String id;
  String name;
  String location;

  factory CustomLocation.fromJson(Map<String, dynamic> json) => CustomLocation(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {};
}
