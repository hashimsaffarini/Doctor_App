import 'package:doc_app/core/networking/api_error_handler.dart';
import 'package:doc_app/features/home/data/models/specialization_response_model.dart';
import 'package:doc_app/features/home/data/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(const HomeState.initial());
  List<SpecializationsData?>? specializationsList = [];

  Future<void> getSpecialization() async {
    emit(const HomeState.specilizationLoading());
    final response = await homeRepo.getSpecialization();
    response.when(
      success: (data) {
        specializationsList = data.specializationDataList ?? [];
        // get the doctors list for the first specialization by default
        getDoctorsList(specializationId: specializationsList?.first?.id);

        emit(HomeState.specilizationSucess(specializationsList));
      },
      failure: (message) {
        emit(HomeState.specilizationError(message));
      },
    );
  }

  void getDoctorsList({required int? specializationId}) {
    List<Doctors?>? doctorsList =
        getDoctorsListBySpecializationId(specializationId);

    if (doctorsList != null && doctorsList.isNotEmpty) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      emit(HomeState.doctorsError(ErrorHandler.handle('No doctors found')));
    }
  }

  /// returns the list of doctors based on the specialization id
  getDoctorsListBySpecializationId(specializationId) {
    return specializationsList
        ?.firstWhere((specialization) => specialization?.id == specializationId)
        ?.doctorsList;
  }
}
