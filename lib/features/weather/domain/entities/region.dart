part of 'entity.dart';

@freezed
class Region with _$Region {
  const Region._();
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

  String get formattedAddress {
    String formattedAddress = '';
    if (subDistrict.isNotEmpty) {
      formattedAddress += subDistrict;
    }
    if (city.isNotEmpty) {
      if (formattedAddress.isNotEmpty) {
        formattedAddress += ', $city';
      } else {
        formattedAddress += city;
      }
    }
    if (province.isNotEmpty) {
      if (formattedAddress.isNotEmpty) {
        formattedAddress += ', $province';
      } else {
        formattedAddress += province;
      }
    }

    return formattedAddress;
  }
}
