import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:get/get.dart';

class ComapnyModules extends StatelessWidget {
  const ComapnyModules({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(body: ListView(
      children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: UIComponenetsAppBar(
              title: ' Company Modules List',
              subtitle: '',
              icon: const Icon(Icons.rocket),
              buttonTitle: 'Add Company Modules',
              onClick: () {
                Get.toNamed(Routes.ADDCOMPANYMODULELIST);
              },
            ),
          ),
      ],
    ));
  }
}