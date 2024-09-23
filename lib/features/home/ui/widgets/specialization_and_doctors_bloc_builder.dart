import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/home/logic/home_state.dart';
import 'package:doc_app/features/home/ui/widgets/doctors_list_view.dart';
import 'package:doc_app/features/home/ui/widgets/doctors_speciality_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationAndDoctorsBlocBuilder extends StatelessWidget {
  const SpecializationAndDoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is SpecilizationError ||
          current is SpecilizationLoading ||
          current is SpecilizationSucess,
      builder: (context, state) {
        return state.maybeWhen(
          specilizationLoading: () {
            return setUpLoading();
          },
          specilizationSucess: (specializations) {
            var specializationsList = specializations;

            return setUpSuccess(specializationsList);
          },
          specilizationError: (error) {
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget setUpSuccess(specializationsList) {
    return Expanded(
      child: Column(
        children: [
          DoctorsSpecialityListView(
            specializationDataList: specializationsList ?? [],
          ),
          verticalSpace(8),
          DoctorsListView(
            doctorsList: specializationsList?.first?.doctorsList ?? [],
          ),
        ],
      ),
    );
  }

  Widget setUpLoading() {
    return const SizedBox(
      height: 100,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
