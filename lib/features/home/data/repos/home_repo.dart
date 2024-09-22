import 'package:doc_app/core/networking/api_error_handler.dart';
import 'package:doc_app/core/networking/api_result.dart';
import 'package:doc_app/features/home/data/apis/home_api_service.dart';
import 'package:doc_app/features/home/data/models/specialization_response_model.dart';

class HomeRepo {
  final HomeApiService apiService;

  HomeRepo(this.apiService);

  Future<ApiResult<SpecializationsResponseModel>> getSpecialization() async {
    try {
      final response = await apiService.getSpecialization();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
