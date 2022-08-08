import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/indicator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class IndicatorIndex extends StatelessWidget {
  const IndicatorIndex({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(6, (index) {
      return Container(
          alignment: Alignment.center,
          width: 12.5.w,
          height: 0.5.h,
          margin: EdgeInsets.symmetric(horizontal: 0.5.w),
          decoration: BoxDecoration(
            color: index == context.watch<IndicatorCubit>().state.counter
                ? const Color.fromRGBO(135, 207, 217, 1)
                : Theme.of(context).indicator_color,
            shape: BoxShape.rectangle,
          ));
    }));
  }
}
