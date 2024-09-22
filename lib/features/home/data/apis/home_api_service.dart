import 'package:dio/dio.dart';
import 'package:doc_app/core/networking/api_constants.dart';
import 'package:doc_app/features/home/data/models/specialization_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET(ApiConstants.speclizationEP)
  Future<SpecializationsResponseModel> getSpecialization();
}
