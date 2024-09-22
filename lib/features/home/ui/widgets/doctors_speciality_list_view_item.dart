import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/core/theming/app_colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/home/data/models/specialization_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorsSpecialityListViewItem extends StatelessWidget {
  const DoctorsSpecialityListViewItem({super.key, this.specializationData});
  final SpecializationsData? specializationData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.lightBlue,
            child: SvgPicture.asset(
              'assets/svgs/general_speciality.svg',
              height: 40.h,
              width: 40.w,
            ),
          ),
          verticalSpace(8),
          Text(
            specializationData?.name ?? 'Speciality',
            style: TextStyles.font12DarkBlueRegular,
          ),
        ],
      ),
    );
  }
}
