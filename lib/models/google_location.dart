class GoogleLocation {
  GoogleLocation({
    required this.placeId,
    required this.name,
    required this.address,
  });

  String placeId;
  String name;
  String address;

  factory GoogleLocation.fromJson(Map<String, dynamic> json) => GoogleLocation(
        placeId: json["placeId"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {};
}

class GoogleLocationsResponse {
  GoogleLocationsResponse({
    this.nextPageToken,
    required this.places,
  });

  String? nextPageToken;
  List<GoogleLocation> places;

  bool hasMore() {
    return nextPageToken != null;
  }

  bool isEmpty() {
    return !hasMore() && places.isEmpty;
  }

  factory GoogleLocationsResponse.fromJson(Map<String, dynamic> json) =>
      GoogleLocationsResponse(
        nextPageToken: json["nextPageToken"],
        places: (json["places"] as List<dynamic>)
            .map((e) => GoogleLocation.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {};
}
