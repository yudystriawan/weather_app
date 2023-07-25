part of 'model.dart';

@freezed
class RegionModel with _$RegionModel {
  const RegionModel._();
  factory RegionModel({
    String? id,
    @JsonKey(name: 'propinsi') String? province,
    @JsonKey(name: 'kota') String? city,
    @JsonKey(name: 'kecamatan') String? subDistrict,
    String? lat,
    String? lon,
  }) = _RegionModel;

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);

  Region toDomain() {
    final empty = Region.empty();
    return Region(
      id: id ?? empty.id,
      province: province ?? empty.province,
      city: city ?? empty.city,
      subDistrict: subDistrict ?? empty.subDistrict,
      latitude: double.tryParse(lat ?? '') ?? empty.latitude,
      longitude: double.tryParse(lon ?? '') ?? empty.longitude,
    );
  }
}
