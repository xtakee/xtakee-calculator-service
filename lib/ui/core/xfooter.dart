
import 'package:flutter/material.dart';
import 'package:stake_calculator/ui/core/web_launcher.dart';
import 'package:stake_calculator/util/dxt.dart';

import '../../util/constants.dart';
import '../../util/dimen.dart';
import '../../util/route_utils/app_router.dart';

class XFooter extends StatelessWidget {
  const XFooter({super.key});

  @override
  Widget build(BuildContext context) =>  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => AppRouter.gotoWidget(
                const WebLauncher(
                    path: termsAndConditions),
                context),
            child: Text(
              "Terms & Conditions",
              textScaleFactor: scale,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            )),
        _dot(),
        GestureDetector(
            onTap: () => AppRouter.gotoWidget(
                const WebLauncher(
                    path: privacyPolicy),
                context),
            child: Text("Privacy",
                textScaleFactor: scale,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87))),
        _dot(),
        GestureDetector(
          onTap: () => AppRouter.gotoWidget(
              const WebLauncher(path: faqs), context),
          child: Text(
            "FAQs",
            textScaleFactor: scale,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        )
      ]);

  _dot() => Container(
      width: 5.h,
      height: 5.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration:
      const BoxDecoration(shape: BoxShape.circle, color: Colors.black87));

}