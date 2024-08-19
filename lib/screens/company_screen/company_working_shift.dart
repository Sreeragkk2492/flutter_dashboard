import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:get/get.dart';

class CompanyWorkingShift extends StatelessWidget {
  const CompanyWorkingShift({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
         Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: UIComponenetsAppBar(
              title: ' Company Working Shifts',
              subtitle: '',
              icon: const Icon(Icons.rocket),
              buttonTitle: 'Add Working Shifts',
              onClick: () {
                Get.toNamed(Routes.AddWorkingShifts);
              },
            ),
          ),
      ],
    )));
  }
}
