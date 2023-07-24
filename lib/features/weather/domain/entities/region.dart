part of 'entity.dart';

@freezed
class Region with _$Region {
  const factory Region({
    required String id,
    required String province,
    required String city,
    required String subDistrict,
    required double latitude,
    required double longitude,
  }) = _Region;

  factory Region.empty() => const Region(
        id: '',
        province: '',
        city: '',
        subDistrict: '',
        latitude: 0,
        longitude: 0,
      );
}
