import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class LatLng extends Equatable {
  final double latitude;
  final double longitude;

  const LatLng({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class Params extends Equatable {
  final LatLng referencePoint;

  const Params({
    required this.referencePoint,
  });

  @override
  List<Object> get props => [referencePoint];
}

@injectable
class GetNearestRegion implements Usecase<Region, Params> {
  final WeatherRepository _repository;

  GetNearestRegion(this._repository);
  @override
  Future<Either<Failure, Region>> call(Params params) async {
    final failureOrRegions = await _repository.getRegions();
    return failureOrRegions.fold(
      (f) => left(f),
      (regions) {
        final region = _selectNearestCoordinate(
          referencePoint: params.referencePoint,
          regions: regions.asList(),
        );

        // if region is null then return the first element of regions.
        if (region == null) return right(regions.first());

        return right(region);
      },
    );
  }

  /// calculate distance between two coordinates using Haversine formula
  double _calculateDistance(LatLng pointA, LatLng pointB) {
    const earthRadiusInKm = 6378;

    final double latARad = _toRadians(pointA.latitude);
    final double lngARad = _toRadians(pointA.longitude);

    final double latBRad = _toRadians(pointB.latitude);
    final double lngBRad = _toRadians(pointB.longitude);

    final double distanceLat = latBRad - latARad;
    final double distanceLng = lngBRad - lngARad;

    // Haversine formula to calculate distance between two points on a sphere
    final double a = sin(distanceLat / 2) * sin(distanceLat / 2) +
        cos(latARad) *
            cos(latBRad) *
            sin(distanceLng / 2) *
            sin(distanceLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusInKm * c;
  }

  /// Function to find the nearest region within a specified radius
  Region? _selectNearestCoordinate({
    required LatLng referencePoint,
    required List<Region> regions,
    double maxDistanceInKm = 10,
  }) {
    Region? nearestRegion;
    double nearestDistance = double.infinity;

    for (var region in regions) {
      double distance = _calculateDistance(
        referencePoint,
        LatLng(
          latitude: region.latitude,
          longitude: region.longitude,
        ),
      );

      if (distance <= maxDistanceInKm && distance < nearestDistance) {
        // If the point is within the specified radius and closer than the current nearest region, update nearestRegion and nearestDistance
        nearestRegion = region;
        nearestDistance = distance;
      }
    }

    return nearestRegion;
  }

  /// Helper function to convert degrees to radians
  double _toRadians(double value) => value * pi / 180;
}
