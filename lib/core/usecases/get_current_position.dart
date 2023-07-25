import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecases/usecase.dart';

@injectable
class GetCurrentPosition implements Usecase<Position, NoParams> {
  @override
  Future<Either<Failure, Position>> call(NoParams params) async {
    LocationPermission? permission;
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return left(const Failure.permissionIsRequired());

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return left(const Failure.permissionIsRequired());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return left(const Failure.permissionIsRequired());
    }

    final currentPosition = await Geolocator.getCurrentPosition();
    return right(currentPosition);
  }
}
