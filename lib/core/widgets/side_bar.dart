

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarMenuConfig {
  final String uri;
  final IconData icon;
  final String Function(BuildContext context) title;
  final List<SidebarChildMenuConfig> children;
  final String? parentTitle; // New property

  const SidebarMenuConfig({
    required this.uri,
    required this.icon,
    required this.title,
    List<SidebarChildMenuConfig>? children,
    this.parentTitle, // New property
  }) : children = children ?? const [];
}

class SidebarChildMenuConfig {
  final String uri;
  final IconData icon;
  final String Function(BuildContext context) title;
  final String? parentTitle; // New property

  const SidebarChildMenuConfig({
    required this.uri,
    required this.icon,
    required this.title,
    this.parentTitle, // New property
  });
}

class Sidebar extends StatefulWidget {
  final bool autoSelectMenu;
  final String? selectedMenuUri; 
  final List<SidebarMenuConfig> sidebarConfigs;

   Sidebar({
    Key? key,
    this.autoSelectMenu = true,
    this.selectedMenuUri, 
    required this.sidebarConfigs,
  }) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final _scrollController = ScrollController();
late String currentLocation; 
 void initState() {
    super.initState();
    currentLocation = widget.selectedMenuUri ?? '';
    if (currentLocation.isEmpty && widget.autoSelectMenu) {
      currentLocation = Get.currentRoute;
    }
    debugPrint('Initial currentLocation: $currentLocation');
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // final lang = Lang.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
  // final sidebarTheme = themeData.extension<AppSidebarTheme>()!;
    final theme = Theme.of(context); 
    // if (sidebarTheme == null) {
    //   return const Center(child: Text('AppSidebarTheme is not defined in ThemeData'));
    // }
  

    return Drawer(
      backgroundColor: AppColors.whiteColor,
      shadowColor: AppColors.bgGreyColor,
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Visibility(
            visible: (mediaQueryData.size.width <= kScreenWidthLg),
            child: Container(
              decoration: BoxDecoration(color: AppColors.whiteColor),  
              alignment: Alignment.centerRight,
              height: kToolbarHeight + kDefaultPadding - 1,
              padding:  EdgeInsets.only(left: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Percapita',
                    style: GoogleFonts.pacifico(
                      fontSize: kDefaultPadding * 2 - kTextPadding,
                      color: AppColors.defaultColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (Scaffold.of(context).isDrawerOpen) {
                        Scaffold.of(context).closeDrawer();
                      }
                    },
                    icon: const Icon(CupertinoIcons.clear_thick),
                    color: AppColors.whiteColor, 
                   // tooltip: lang.closeNavigationMenu,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding / 2,
                ), 
                children: [
                  _sidebarMenuList(context, currentLocation),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _sidebarMenuList(BuildContext context, String currentLocation) {
//    // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
//      // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
//  print('Rendering sidebar menu list with currentLocation: $currentLocation');
  

//     return Column(
//       children: widget.sidebarConfigs.map<Widget>((menu) {
//         if (menu.children.isEmpty) {
//           return _sidebarMenu(
//             context,
//            EdgeInsets.fromLTRB(
//                   12,12,12,12 
//                 ),
//             menu.uri ,
//             menu.icon,
//             menu.title(context),
//             (currentLocation.startsWith(menu.uri)),
//           );
//         } else {
//           return _expandableSidebarMenu(
//             context,
//             EdgeInsets.fromLTRB(12, 12, 12, 12),
//             menu.uri,
//             menu.icon,
//             menu.title(context),
//             menu.children,
//             currentLocation,
           
//           );
//         }
//       }).toList(growable: false),
//     );
//   }

 Widget _sidebarMenuList(BuildContext context, String currentLocation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.sidebarConfigs
          .expand((menu) {
            List<Widget> widgets = [];
            if (menu.parentTitle != null) {
              widgets.add(
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                  child: Text(
                    menu.parentTitle!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textgreyColor ,
                    ),
                  ),
                ),
              );
            }
            widgets.addAll(menu.children.map((childMenu) {
              return _sidebarMenu(
                context,
                EdgeInsets.fromLTRB(2, 8, 12, 8),
                childMenu.uri,
                childMenu.icon,
                childMenu.title(context),
                currentLocation.startsWith(childMenu.uri),
              );
            }));
            return widgets;
          })
          .toList(),
    );
  }

//   Widget _sidebarMenu(
//     BuildContext context,
//     EdgeInsets padding,
//     String uri,
//     IconData icon,
//     String title,
//     bool isSelected,
//   ) {
//  //  final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
//     final theme = Theme.of(context);
//     return Padding(
//       padding:padding, 
//       child: ListTile(
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             isSelected
//                 ? Icon(
//                     icon == Icons.dashboard_rounded ||
//                             icon == Icons.bar_chart ||
//                             icon == Icons.dataset_rounded ||
//                             icon == Icons.table_chart ||
//                             icon == Icons.location_on_outlined ||
//                             icon == Icons.laptop_windows_rounded ||
//                             icon == Icons.person_2
//                         ? icon
//                         : Icons.stop_circle_outlined,
//                     size: (kDefaultFontSize + 4.0),
//                     color: AppColors.whiteColor ,
//                   )
//                 : Icon(
//                     icon,
//                     size: (kDefaultFontSize + 4.0),
//                     color: AppColors.blackColor,
//                   ),
//              SizedBox(width: kDefaultPadding *0.5),  
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12  ,   
               
//                 color: isSelected ? AppColors.whiteColor   : AppColors.blackColor, 
//               ),
//             ),
//           ],
//         ),
//         onTap: () {
//           setState(() { 
//             currentLocation=uri; 
//           });
//           Get.toNamed(uri);
//         },
//         selected: isSelected,
//         // shape: RoundedRectangleBorder(
//         //   borderRadius: BorderRadius.circular(20),
//         // ),
//         textColor: isSelected ? AppColors.textgreyColor : AppColors.blackColor,
//       hoverColor: !isSelected ? AppColors.hoverColor  : Colors.transparent,
//         selectedTileColor: isSelected ? AppColors.hoverColor : AppColors.blackColor,
//       ),
//     );
//   }

 Widget _sidebarMenu(
    BuildContext context,
    EdgeInsets padding,
    String uri,
    IconData icon,
    String title,
    bool isSelected,
  ) {
    return Padding(
      padding: padding,
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: (kDefaultFontSize + 4.0),
              color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
            ),
            SizedBox(width: kDefaultPadding * 0.5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            currentLocation = uri;
          });
          // Maintain scroll position
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.offset);
            }
          });
          Get.toNamed(uri);
        },
        selected: isSelected,
        textColor: isSelected ? AppColors.textgreyColor : AppColors.blackColor,
        hoverColor: !isSelected ? AppColors.hoverColor : Colors.transparent,
        selectedTileColor: isSelected ? AppColors.hoverColor : AppColors.blackColor,
      ),
    );
  }
  // Widget _expandableSidebarMenu(
  //   BuildContext context,
  //   EdgeInsets padding,
  //   String uri,
  //   IconData icon,
  //   String title,
  //   List<SidebarChildMenuConfig> children,
  //   String currentLocation,
    
  // ) {
  //   final themeData = Theme.of(context);
  //  // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
  //   final hasSelectedChild = children.any((e) => currentLocation.startsWith(e.uri));
  //    final parentTextColor =
  //        (hasSelectedChild ? AppColors.greycolor   : AppColors.blackColor);
  //  bool isSelected=hasSelectedChild;
  //   return Theme(
  //     data: themeData.copyWith(hoverColor: AppColors.hoverColor,dividerColor: Colors.transparent ),
  //     child: ExpansionTile(
       
       
  //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
  //       key: UniqueKey(),
  //      // backgroundColor: isSelected?Colors.black:Colors.red,
  //       textColor: parentTextColor,
  //       collapsedTextColor:parentTextColor ,
  //       iconColor: parentTextColor,
  //       collapsedIconColor: parentTextColor, 
  //     initiallyExpanded: hasSelectedChild, 
        
  //       childrenPadding: EdgeInsets.only(
  //         top: 0, 
  //         bottom:0,
  //       ),
  //       title: Padding(
  //         padding: const EdgeInsets.all(8.0),  
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               icon,
  //               color: isSelected?AppColors.hoverColor:AppColors.blackColor,
  //               size: 20, 
  //             ),
  //              SizedBox(width: kDefaultPadding * 0.7 ),
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize:12,   
  //                 color: isSelected?AppColors.hoverColor:AppColors.blackColor
  //                ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       children: children.map<Widget>((childMenu) {
  //         return _sidebarMenu(
  //           context,
  //          EdgeInsets.fromLTRB(
  //               12,12,12,12 
  //               ), 
  //           childMenu.uri,
  //           childMenu.icon,
  //           childMenu.title(context),
  //           (currentLocation.startsWith(childMenu.uri)),
  //         );
  //       }).toList(growable: false),
  //     ),
  //   );
  // }
Widget _expandableSidebarMenu(
  BuildContext context,
  EdgeInsets padding,
  String uri,
  IconData icon,
  String title,
  List<SidebarChildMenuConfig> children,
  String currentLocation,
) {
  final themeData = Theme.of(context);
  final hasSelectedChild = children.any((e) => currentLocation.startsWith(e.uri));
  final isSelected = hasSelectedChild; // Main menu is selected only if a child is selected
  final parentTextColor = isSelected ? AppColors.hoverColor : AppColors.blackColor;

  return Theme(
    data: themeData.copyWith(hoverColor: AppColors.hoverColor, dividerColor: Colors.transparent),
    child: ExpansionTile(
      key: UniqueKey(),
      textColor: parentTextColor,
      collapsedTextColor: parentTextColor,
      iconColor: parentTextColor,
      collapsedIconColor: parentTextColor,
      initiallyExpanded: hasSelectedChild,
      childrenPadding: EdgeInsets.only(
        top: 0,
        bottom: 0,
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.hoverColor : AppColors.blackColor,
              size: 20,
            ),
            SizedBox(width: kDefaultPadding * 0.7),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.hoverColor : AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
      children: children.map<Widget>((childMenu) {
        return _sidebarMenu(
          context,
          EdgeInsets.fromLTRB(12, 12, 12, 12),
          childMenu.uri,
          childMenu.icon,
          childMenu.title(context),
          currentLocation.startsWith(childMenu.uri),
          // parentTitle: childMenu.parentTitle,
           
        );
      }).toList(growable: false),
    ),
  );
}
}
