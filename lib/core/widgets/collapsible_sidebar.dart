import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/getx/sidebar_controller.dart';
import 'package:get/get.dart';

class CollapsibleSidebar extends StatelessWidget {
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final List<Map<String, dynamic>> sidebarConfigs;
  final String? userType;
  
  CollapsibleSidebar({
    Key? key,
    required this.autoSelectMenu,
    this.selectedMenuUri,
    required this.sidebarConfigs,
    this.userType,
  }) : super(key: key);

  final SidebarController controller = Get.put(SidebarController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.drbackgroundColor,
      child: Obx(() => Container(
        width: controller.isExpanded.value ? 250.0 : 70.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with toggle button
            SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: controller.isExpanded.value 
                    ? MainAxisAlignment.end 
                    : MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.toggleSidebar,
                    icon: Icon(
                      controller.isExpanded.value 
                          ? Icons.chevron_left 
                          : Icons.chevron_right,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white24),
            // Menu items
            Expanded(
              child: ListView.builder(
                itemCount: sidebarConfigs.length,
                itemBuilder: (context, index) => _buildMenuItem(sidebarConfigs[index]),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Obx(() => InkWell(
      onTap: () {
        if (item['uri'] != null) {
          Get.toNamed(item['uri']);
        }
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(
          horizontal: controller.isExpanded.value ? 16.0 : 8.0,
        ),
        decoration: BoxDecoration(
          color: selectedMenuUri == item['uri']
              ? AppColors.defaultColor.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              item['icon'] as IconData,
              color: AppColors.whiteColor,
              size: 24,
            ),
            if (controller.isExpanded.value) ...[
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item['title'] as String,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    ));
  }
}