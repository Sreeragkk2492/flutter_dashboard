import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';

class ComapnyMenuList extends StatelessWidget {
  const ComapnyMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(body: ListView());
  }
}