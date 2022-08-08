import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar {
  static AppBar build(
    BuildContext context,
    IconData? icondata,
  ) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
      elevation: 0,
      actions: [
        icondata == null
            ? Container()
            : InkWell(
                onTap: () {
                  // context.read<MessageCubit>().changeStatetoInnerCircle();
                  // Navigator.of(context).pushNamed('/message_screen');
                },
                child: SvgPicture.asset(
                  'assets/Speakerphone.svg',
                  color: Theme.of(context).appBarIconColor,
                )),
        SizedBox(
          width: 15,
        ),
        icondata == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  'assets/Edit.svg',
                  color: Theme.of(context).appBarIconColor,
                ))
      ],
      title: Image.asset(
        Theme.of(context).logo,
        width: 22.0.w,
      ),
      centerTitle: true,
    );
  }
}
