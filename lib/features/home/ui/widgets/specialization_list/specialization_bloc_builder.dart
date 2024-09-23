import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/home/logic/home_state.dart';
import 'package:doc_app/features/home/ui/widgets/doctors_list/doctors_shimmer_loading.dart';
import 'package:doc_app/features/home/ui/widgets/specialization_list/speciality_list_view.dart';
import 'package:doc_app/features/home/ui/widgets/specialization_list/speciality_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

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
    return SpecialityListView(
      specializationDataList: specializationsList ?? [],
    );
  }

  Widget setUpLoading() {
    return Expanded(
        child: Column(
      children: [
        const SpecialityShimmerLoading(),
        verticalSpace(8),
        const DoctorsShimmerLoading(),
      ],
    ));
  }
}
