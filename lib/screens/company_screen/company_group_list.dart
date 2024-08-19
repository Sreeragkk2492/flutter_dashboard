import 'package:flutter/cupertino.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';

class CompanyGroupList extends StatelessWidget {
  const CompanyGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [],
    )));
  }
}
