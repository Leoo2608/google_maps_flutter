import 'package:dio/dio.dart';
import 'package:flutter_google_maps/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_maps/.env.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions>? getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    if(response.statusCode == 200){
      print(Directions.fromMap(response.data).totalDuration);
      return Directions.fromMap(response.data);
    }
    return Directions(bounds: null, polylinePoints: null, totalDistance: null, totalDuration: null);
  }
}