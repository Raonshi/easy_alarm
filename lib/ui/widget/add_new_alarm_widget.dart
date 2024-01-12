import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewAlarmWidget extends StatelessWidget {
  const AddNewAlarmWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4.0,
              spreadRadius: 0.0,
              color: Colors.black.withOpacity(0.25),
            )
          ],
          color: CustomColors.blue10,
          shape: const CircleBorder(
            side: BorderSide(color: CustomColors.blue20),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          CustomIcons.add,
          colorFilter: const ColorFilter.mode(CustomColors.blue70, BlendMode.srcIn),
        ),
      ),
    );
  }
}
