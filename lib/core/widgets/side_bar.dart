

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/masterlayout.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarMenuConfig {
  final String uri;
  final IconData icon;
  final String Function(BuildContext context) title;
  final List<SidebarChildMenuConfig> children;
  final String? parentTitle;
  final List<String> visibleFor; // New property

  const SidebarMenuConfig({
    required this.uri,
    required this.icon,
    required this.title,
    List<SidebarChildMenuConfig>? children,
    this.parentTitle,
     required this.visibleFor, // New property
  }) : children = children ?? const [];
}

class SidebarChildMenuConfig {
  final String uri;
  final IconData icon;
  final String Function(BuildContext context) title;
  final String? parentTitle; 
  final List<String> visibleFor;// New property

  const SidebarChildMenuConfig({
    required this.uri,
    required this.icon,
    required this.title,
    this.parentTitle,
    required this.visibleFor // New property
  });
}

// class Sidebar extends StatefulWidget {
//   final bool autoSelectMenu;
//   final String? selectedMenuUri; 
//   final String? userType;
  
//   final List<SidebarMenuConfig> sidebarConfigs;

//    Sidebar({
//     Key? key,
//     this.autoSelectMenu = true,
//     this.selectedMenuUri, 
//      this.userType,
//     required this.sidebarConfigs,
//   }) : super(key: key);

//   @override
//   State<Sidebar> createState() => _SidebarState();
// }

// class _SidebarState extends State<Sidebar> {
//   final _scrollController = ScrollController();
// late String currentLocation; 
// String? userType;
//  void initState() {
//     super.initState();
//     currentLocation = widget.selectedMenuUri ?? '';
//     if (currentLocation.isEmpty && widget.autoSelectMenu) {
//       currentLocation = Get.currentRoute;
//     }
//     _loadUserType();
//     debugPrint('Initial currentLocation: $currentLocation');
//   }

//    void _loadUserType() async {
//     userType = await StorageServices().read('user_type');
//     if (mounted) {
//       setState(() {});
//     }
//   }
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//    // final lang = Lang.of(context);
//     final mediaQueryData = MediaQuery.of(context);
//     final themeData = Theme.of(context);
//   // final sidebarTheme = themeData.extension<AppSidebarTheme>()!;
//     final theme = Theme.of(context); 
//     // if (sidebarTheme == null) {
//     //   return const Center(child: Text('AppSidebarTheme is not defined in ThemeData'));
//     // }
  

//     return Drawer(
//       backgroundColor: AppColors.whiteColor,
//       shadowColor: AppColors.bgGreyColor,
//       elevation: 4,
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Column(
//         children: [
//           Visibility(
//             visible: (mediaQueryData.size.width <= kScreenWidthLg),
//             child: Container(
//               decoration: BoxDecoration(color: AppColors.whiteColor),  
//               alignment: Alignment.centerRight,
//               height: kToolbarHeight + kDefaultPadding - 1,
//               padding:  EdgeInsets.only(left: kDefaultPadding),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Percapita',
//                     style: GoogleFonts.pacifico(
//                       fontSize: kDefaultPadding * 2 - kTextPadding,
//                       color: AppColors.defaultColor,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       if (Scaffold.of(context).isDrawerOpen) {
//                         Scaffold.of(context).closeDrawer();
//                       }
//                     },
//                     icon: const Icon(CupertinoIcons.clear_thick),
//                     color: AppColors.whiteColor, 
//                    // tooltip: lang.closeNavigationMenu,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Scrollbar(
//               controller: _scrollController,
//               child: ListView(
//                 controller: _scrollController,
//                   padding: EdgeInsets.symmetric(
//                   vertical: kDefaultPadding,
//                   horizontal: kDefaultPadding / 2,
//                 ), 
//                 children: [
//                   if (userType != null) _sidebarMenuList(context, currentLocation),
//                   if (userType == null) CircularProgressIndicator(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// //   Widget _sidebarMenuList(BuildContext context, String currentLocation) {
// //    // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
// //      // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
// //  print('Rendering sidebar menu list with currentLocation: $currentLocation');
  

// //     return Column(
// //       children: widget.sidebarConfigs.map<Widget>((menu) {
// //         if (menu.children.isEmpty) {
// //           return _sidebarMenu(
// //             context,
// //            EdgeInsets.fromLTRB(
// //                   12,12,12,12 
// //                 ),
// //             menu.uri ,
// //             menu.icon,
// //             menu.title(context),
// //             (currentLocation.startsWith(menu.uri)),
// //           );
// //         } else {
// //           return _expandableSidebarMenu(
// //             context,
// //             EdgeInsets.fromLTRB(12, 12, 12, 12),
// //             menu.uri,
// //             menu.icon,
// //             menu.title(context),
// //             menu.children,
// //             currentLocation,
           
// //           );
// //         }
// //       }).toList(growable: false),
// //     );
// //   }

//   Widget _sidebarMenuList(BuildContext context, String currentLocation) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: widget.sidebarConfigs
//           .where((menu) => menu.visibleFor.contains(userType))
//           .expand((menu) {
//         List<Widget> widgets = [];
//         if (menu.parentTitle != null) {
//           widgets.add(
//             Padding(
//               padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
//               child: Text(
//                 menu.parentTitle!,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textgreyColor,
//                 ),
//               ),
//             ),
//           );
//         }
//         widgets.addAll(menu.children
//             .where((childMenu) => childMenu.visibleFor.contains(userType))
//             .map((childMenu) {
//           return _sidebarMenu(
//             context,
//             EdgeInsets.fromLTRB(12, 8, 12, 8),
//             childMenu.uri,
//             childMenu.icon,
//             childMenu.title(context),
//             currentLocation.startsWith(childMenu.uri),
//           );
//         }));
//         return widgets;
//       }).toList(),
//     );
//   }

// //   Widget _sidebarMenu(
// //     BuildContext context,
// //     EdgeInsets padding,
// //     String uri,
// //     IconData icon,
// //     String title,
// //     bool isSelected,
// //   ) {
// //  //  final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
// //     final theme = Theme.of(context);
// //     return Padding(
// //       padding:padding, 
// //       child: ListTile(
// //         title: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             isSelected
// //                 ? Icon(
// //                     icon == Icons.dashboard_rounded ||
// //                             icon == Icons.bar_chart ||
// //                             icon == Icons.dataset_rounded ||
// //                             icon == Icons.table_chart ||
// //                             icon == Icons.location_on_outlined ||
// //                             icon == Icons.laptop_windows_rounded ||
// //                             icon == Icons.person_2
// //                         ? icon
// //                         : Icons.stop_circle_outlined,
// //                     size: (kDefaultFontSize + 4.0),
// //                     color: AppColors.whiteColor ,
// //                   )
// //                 : Icon(
// //                     icon,
// //                     size: (kDefaultFontSize + 4.0),
// //                     color: AppColors.blackColor,
// //                   ),
// //              SizedBox(width: kDefaultPadding *0.5),  
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 12  ,   
               
// //                 color: isSelected ? AppColors.whiteColor   : AppColors.blackColor, 
// //               ),
// //             ),
// //           ],
// //         ),
// //         onTap: () {
// //           setState(() { 
// //             currentLocation=uri; 
// //           });
// //           Get.toNamed(uri);
// //         },
// //         selected: isSelected,
// //         // shape: RoundedRectangleBorder(
// //         //   borderRadius: BorderRadius.circular(20),
// //         // ),
// //         textColor: isSelected ? AppColors.textgreyColor : AppColors.blackColor,
// //       hoverColor: !isSelected ? AppColors.hoverColor  : Colors.transparent,
// //         selectedTileColor: isSelected ? AppColors.hoverColor : AppColors.blackColor,
// //       ),
// //     );
// //   }

//  Widget _sidebarMenu(
//     BuildContext context,
//     EdgeInsets padding,
//     String uri,
//     IconData icon,
//     String title,
//     bool isSelected,
//   ) {
//     return Padding(
//       padding: padding,
//       child: ListTile(
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: (kDefaultFontSize + 4.0),
//               color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
//             ),
//             SizedBox(width: kDefaultPadding * 0.5),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
//               ),
//             ),
//           ],
//         ),
//         onTap: () {
//           setState(() {
//             currentLocation = uri;
//           });
//           // Maintain scroll position
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (_scrollController.hasClients) {
//               _scrollController.jumpTo(_scrollController.offset);
//             }
//           });
//           Get.toNamed(uri);
//         },
//         selected: isSelected,
//         textColor: isSelected ? AppColors.textgreyColor : AppColors.blackColor,
//         hoverColor: !isSelected ? AppColors.hoverColor : Colors.transparent,
//         selectedTileColor: isSelected ? AppColors.hoverColor : AppColors.blackColor,
//       ),
//     );
//   }
//   // Widget _expandableSidebarMenu(
//   //   BuildContext context,
//   //   EdgeInsets padding,
//   //   String uri,
//   //   IconData icon,
//   //   String title,
//   //   List<SidebarChildMenuConfig> children,
//   //   String currentLocation,
    
//   // ) {
//   //   final themeData = Theme.of(context);
//   //  // final sidebarTheme = Theme.of(context).extension<AppSidebarTheme>()!;
//   //   final hasSelectedChild = children.any((e) => currentLocation.startsWith(e.uri));
//   //    final parentTextColor =
//   //        (hasSelectedChild ? AppColors.greycolor   : AppColors.blackColor);
//   //  bool isSelected=hasSelectedChild;
//   //   return Theme(
//   //     data: themeData.copyWith(hoverColor: AppColors.hoverColor,dividerColor: Colors.transparent ),
//   //     child: ExpansionTile(
       
       
//   //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
//   //       key: UniqueKey(),
//   //      // backgroundColor: isSelected?Colors.black:Colors.red,
//   //       textColor: parentTextColor,
//   //       collapsedTextColor:parentTextColor ,
//   //       iconColor: parentTextColor,
//   //       collapsedIconColor: parentTextColor, 
//   //     initiallyExpanded: hasSelectedChild, 
        
//   //       childrenPadding: EdgeInsets.only(
//   //         top: 0, 
//   //         bottom:0,
//   //       ),
//   //       title: Padding(
//   //         padding: const EdgeInsets.all(8.0),  
//   //         child: Row(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Icon(
//   //               icon,
//   //               color: isSelected?AppColors.hoverColor:AppColors.blackColor,
//   //               size: 20, 
//   //             ),
//   //              SizedBox(width: kDefaultPadding * 0.7 ),
//   //             Text(
//   //               title,
//   //               style: TextStyle(
//   //                 fontSize:12,   
//   //                 color: isSelected?AppColors.hoverColor:AppColors.blackColor
//   //                ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //       children: children.map<Widget>((childMenu) {
//   //         return _sidebarMenu(
//   //           context,
//   //          EdgeInsets.fromLTRB(
//   //               12,12,12,12 
//   //               ), 
//   //           childMenu.uri,
//   //           childMenu.icon,
//   //           childMenu.title(context),
//   //           (currentLocation.startsWith(childMenu.uri)),
//   //         );
//   //       }).toList(growable: false),
//   //     ),
//   //   );
//   // }
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
//   final hasSelectedChild = children.any((e) => currentLocation.startsWith(e.uri));
//   final isSelected = hasSelectedChild; // Main menu is selected only if a child is selected
//   final parentTextColor = isSelected ? AppColors.hoverColor : AppColors.blackColor;

//   return Theme(
//     data: themeData.copyWith(hoverColor: AppColors.hoverColor, dividerColor: Colors.transparent),
//     child: ExpansionTile(
//       key: UniqueKey(),
//       textColor: parentTextColor,
//       collapsedTextColor: parentTextColor,
//       iconColor: parentTextColor,
//       collapsedIconColor: parentTextColor,
//       initiallyExpanded: hasSelectedChild,
//       childrenPadding: EdgeInsets.only(
//         top: 0,
//         bottom: 0,
//       ),
//       title: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? AppColors.hoverColor : AppColors.blackColor,
//               size: 20,
//             ),
//             SizedBox(width: kDefaultPadding * 0.7),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? AppColors.hoverColor : AppColors.blackColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//       children: children.map<Widget>((childMenu) {
//         return _sidebarMenu(
//           context,
//           EdgeInsets.fromLTRB(12, 12, 12, 12),
//           childMenu.uri,
//           childMenu.icon,
//           childMenu.title(context),
//           currentLocation.startsWith(childMenu.uri),
//           // parentTitle: childMenu.parentTitle,
           
//         );
//       }).toList(growable: false),
//     ),
//   );
// }
// }
// class Sidebar extends StatefulWidget {
//   final bool autoSelectMenu;
//   final String? selectedMenuUri;
//   final String? userType;
//   final List<SidebarMenuConfig> sidebarConfigs;

//   const Sidebar({
//     Key? key,
//     this.autoSelectMenu = true,
//     this.selectedMenuUri,
//     this.userType,
//     required this.sidebarConfigs,
//   }) : super(key: key); 

//   @override
//   State<Sidebar> createState() => _SidebarState();
// }

// class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
//   final _scrollController = ScrollController();
//   late String currentLocation;
//   String? userType;
//   bool isExpanded = false;
//   final double collapsedWidth = 70;
//   final double expandedWidth = 280;
  
//   // Add animation controller
//   late AnimationController _animationController;
//   late Animation<double> _widthAnimation;

//   @override
//   void initState() {
//     super.initState();
//     currentLocation = widget.selectedMenuUri ?? '';
//     if (currentLocation.isEmpty && widget.autoSelectMenu) {
//       currentLocation = Get.currentRoute;
//     }
    
//     // Initialize animation controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 150), // Reduced duration for snappier animation
//       vsync: this,
//     );
    
//     // Create width animation
//     _widthAnimation = Tween<double>(
//       begin: collapsedWidth,
//       end: expandedWidth,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOutCubic, // Smoother curve
//     ));
    
//     _loadUserType();
//   }

//   void _loadUserType() async {
//     userType = await StorageServices().read('user_type');
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void toggleExpansion() {
//     setState(() {
//       isExpanded = !isExpanded;
//       if (isExpanded) {
//         _animationController.forward();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context);
//     final isMobile = mediaQueryData.size.width <= kScreenWidthLg;

//     Widget sidebarContent = AnimatedBuilder(
//       animation: _widthAnimation,
//       builder: (context, child) => SizedBox(
//         width: _widthAnimation.value,
//         child: Drawer(
//           backgroundColor: AppColors.whiteColor,
//           shadowColor: AppColors.bgGreyColor,
//           elevation: 4,
//           child: Column(
//             children: [
//               if (isMobile)
//                 IconButton(
//                   icon: Icon(
//                     isExpanded ? Icons.menu_open : Icons.menu,
//                     color: AppColors.blackColor,
//                   ),
//                   onPressed: toggleExpansion,
//                 ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   child: Padding(
//                     padding:   EdgeInsets.symmetric(
//                       vertical: kDefaultPadding,
//                       horizontal: 8,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (userType != null)
//                           _sidebarMenuList(context, currentLocation),
//                         if (userType == null)
//                           const Center(child: CircularProgressIndicator()),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     if (!isMobile) {
//       return MouseRegion(
//         onEnter: (_) {
//           _animationController.forward();
//           setState(() => isExpanded = true);
//         },
//         onExit: (_) {
//           _animationController.reverse();
//           setState(() => isExpanded = false);
//         },
//         child: sidebarContent,
//       );
//     }

//     return GestureDetector(
//       onHorizontalDragEnd: (details) {
//         if (details.primaryVelocity! > 0) {
//           _animationController.forward();
//           setState(() => isExpanded = true);
//         } else if (details.primaryVelocity! < 0) {
//           _animationController.reverse();
//           setState(() => isExpanded = false);
//         }
//       },
//       child: sidebarContent,
//     );
//   }

//   Widget _sidebarMenuList(BuildContext context, String currentLocation) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: widget.sidebarConfigs
//           .where((menu) => menu.visibleFor.contains(userType))
//           .expand((menu) {
//         final List<Widget> widgets = [];
//         if (menu.parentTitle != null && isExpanded) {
//           widgets.add(
//             Padding(
//               padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
//               child: Text(
//                 menu.parentTitle!,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textgreyColor,
//                 ),
//               ),
//             ),
//           );
//         }
//         widgets.addAll(menu.children
//             .where((childMenu) => childMenu.visibleFor.contains(userType))
//             .map((childMenu) => _sidebarMenu(
//                   context,
//                   const EdgeInsets.symmetric(vertical: 4),
//                   childMenu.uri,
//                   childMenu.icon,
//                   childMenu.title(context),
//                   currentLocation.startsWith(childMenu.uri),
//                 )));
//         return widgets;
//       }).toList(),
//     );
//   }

//   Widget _sidebarMenu(
//     BuildContext context,
//     EdgeInsets padding,
//     String uri,
//     IconData icon,
//     String title,
//     bool isSelected,
//   ) {
//     return Padding(
//       padding: padding,
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(8),
//           onTap: () {
//             setState(() {
//               currentLocation = uri;
//             });
//             Get.toNamed(uri);
            
//             final isMobile = MediaQuery.of(context).size.width <= kScreenWidthLg;
//             if (isMobile) {
//               _animationController.reverse();
//               setState(() => isExpanded = false);
//             }
//           },
//           child: Container(
//             height: 50,
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.hoverColor : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: 10,
//                   child: Icon(
//                     icon,
//                     size: 20,
//                     color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
//                   ),
//                 ),
//                 if (isExpanded) ...[
//                   const SizedBox(width: 12),
//                   Expanded( 
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: isSelected
//                             ? AppColors.whiteColor
//                             : AppColors.blackColor,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//hover sidebar


// class Sidebar extends StatefulWidget {
//   final bool autoSelectMenu;
//   final String? selectedMenuUri;
//   final String? userType;
//   final List<SidebarMenuConfig> sidebarConfigs;

//   const Sidebar({
//     Key? key,
//     this.autoSelectMenu = true,
//     this.selectedMenuUri,
//     this.userType,
//     required this.sidebarConfigs,
//   }) : super(key: key); 

//   @override
//   State<Sidebar> createState() => _SidebarState();
// }

// class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
//   final _scrollController = ScrollController();
//   late String currentLocation;
//   String? userType;
//   bool isExpanded = false;
//   final double collapsedWidth = 70;
//   final double expandedWidth = 280;
  
//   late AnimationController _animationController;
//   late Animation<double> _widthAnimation;
//   bool _isHovering = false;
//   Timer? _expansionTimer;

//   @override
//   void initState() {
//     super.initState();
//     currentLocation = widget.selectedMenuUri ?? '';
//     if (currentLocation.isEmpty && widget.autoSelectMenu) {
//       currentLocation = Get.currentRoute;
//     }
    
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 100), // Faster animation
//       vsync: this,
//     );
    
//     _widthAnimation = Tween<double>(
//       begin: collapsedWidth,
//       end: expandedWidth,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.fastOutSlowIn, // More responsive curve
//     ));
    
//     _loadUserType();
//   }

//   void _loadUserType() async {
//     userType = await StorageServices().read('user_type');
//     if (mounted) setState(() {});
//   }

//   void _handleExpansion(bool expand) {
//     _expansionTimer?.cancel();
//     _expansionTimer = Timer(const Duration(milliseconds: 50), () {
//       if (expand != isExpanded) {
//         setState(() {
//           isExpanded = expand;
//           if (expand) {
//             _animationController.forward();
//           } else {
//             _animationController.reverse();
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _animationController.dispose();
//     _expansionTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context);
//     final isMobile = mediaQueryData.size.width <= kScreenWidthLg;

//     return RepaintBoundary( // Optimize repainting
//       child: AnimatedBuilder(
//         animation: _widthAnimation,
//         builder: (context, child) => SizedBox(
//           width: _widthAnimation.value,
//           child: _buildDrawer(isMobile),
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawer(bool isMobile) {
//     Widget drawer = Drawer(
//       backgroundColor: AppColors.whiteColor,
//       shadowColor: AppColors.bgGreyColor,
//       elevation: 4,
//       child: Column(
//         children: [
//           if (isMobile)
//             IconButton(
//               icon: Icon(
//                 isExpanded ? Icons.menu_open : Icons.menu,
//                 color: AppColors.blackColor,
//               ),
//               onPressed: () => _handleExpansion(!isExpanded),
//             ),
//           Expanded(
//             child: _buildScrollableContent(),
//           ),
//         ],
//       ),
//     );

//     if (!isMobile) {
//       return MouseRegion(
//         onEnter: (_) {
//           _isHovering = true;
//           _handleExpansion(true);
//         },
//         onExit: (_) {
//           _isHovering = false;
//           _handleExpansion(false);
//         },
//         child: drawer,
//       );
//     }

//     return GestureDetector(
//       onHorizontalDragEnd: (details) {
//         if (details.primaryVelocity! > 0) {
//           _handleExpansion(true);
//         } else if (details.primaryVelocity! < 0) {
//           _handleExpansion(false);
//         }
//       },
//       child: drawer,
//     );
//   }

//   Widget _buildScrollableContent() {
//     return SingleChildScrollView(
//       controller: _scrollController,
//       child: Padding(
//         padding:  EdgeInsets.symmetric(
//           vertical: kDefaultPadding,
//           horizontal: 8,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (userType != null)
//               _buildMenuList(),
//             if (userType == null)
//               const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: widget.sidebarConfigs
//           .where((menu) => menu.visibleFor.contains(userType))
//           .expand((menu) {
//         final List<Widget> widgets = [];
//         if (menu.parentTitle != null && isExpanded) {
//           widgets.add(_buildParentTitle(menu.parentTitle!));
//         }
//         widgets.addAll(_buildMenuItems(menu));
//         return widgets;
//       }).toList(),
//     );
//   }

//   Widget _buildParentTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textgreyColor,
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildMenuItems(SidebarMenuConfig menu) {
//     return menu.children
//         .where((childMenu) => childMenu.visibleFor.contains(userType))
//         .map((childMenu) => _buildMenuItem(childMenu))
//         .toList();
//   }

//   Widget _buildMenuItem(SidebarChildMenuConfig childMenu) {
//     final bool isSelected = currentLocation.startsWith(childMenu.uri);
    
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(8),
//           onTap: () => _handleMenuItemTap(childMenu.uri),
//           child: Container(
//             height: 50,
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.hoverColor : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: 10,
//                   child: Icon(
//                     childMenu.icon,
//                     size: 20,
//                     color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
//                   ),
//                 ),
//                 if (isExpanded) ...[
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       childMenu.title(context),
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleMenuItemTap(String uri) {
//     setState(() => currentLocation = uri);
//     Get.toNamed(uri);
    
//     final isMobile = MediaQuery.of(context).size.width <= kScreenWidthLg;
//     if (isMobile) {
//       _handleExpansion(false);
//     }
//   }
// }

//button sidebar

class Sidebar extends StatefulWidget {
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final String? userType;
  final List<SidebarMenuConfig> sidebarConfigs;

  const Sidebar({
    Key? key,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    this.userType,
    required this.sidebarConfigs,
  }) : super(key: key); 

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final _scrollController = ScrollController();
  late String currentLocation;
  String? userType;
  bool isExpanded = false;
  final double collapsedWidth = 70;
  final double expandedWidth = 280;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.selectedMenuUri ?? '';
    if (currentLocation.isEmpty && widget.autoSelectMenu) {
      currentLocation = Get.currentRoute;
    }
    
    _loadUserType();
  }

  void _loadUserType() async {
    userType = await StorageServices().read('user_type');
    if (mounted) setState(() {});
  }

  void _toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width <= kScreenWidthLg;
    final currentWidth = isExpanded ? expandedWidth : collapsedWidth;

    return RepaintBoundary(
      child: SizedBox(
        width: currentWidth,
        child: _buildDrawer(isMobile),
      ),
    );
  }

  Widget _buildDrawer(bool isMobile) {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      shadowColor: AppColors.bgGreyColor,
      elevation: 4,
      child: Column(
        children: [
          // Top Expand/Collapse Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: AppColors.blackColor,
                  ),
                  onPressed: _toggleSidebar,
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _buildScrollableContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userType != null)
              _buildMenuList(),
            if (userType == null)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.sidebarConfigs
          .where((menu) => menu.visibleFor.contains(userType))
          .expand((menu) {
        final List<Widget> widgets = [];
        if (menu.parentTitle != null && isExpanded) {
          widgets.add(_buildParentTitle(menu.parentTitle!));
        }
        widgets.addAll(_buildMenuItems(menu));
        return widgets;
      }).toList(),
    );
  }

  Widget _buildParentTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textgreyColor,
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(SidebarMenuConfig menu) {
    return menu.children
        .where((childMenu) => childMenu.visibleFor.contains(userType))
        .map((childMenu) => _buildMenuItem(childMenu))
        .toList();
  }

  Widget _buildMenuItem(SidebarChildMenuConfig childMenu) {
    final bool isSelected = currentLocation.startsWith(childMenu.uri);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _handleMenuItemTap(childMenu.uri),
          child: Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.hoverColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 10,
                  child: Icon(
                    childMenu.icon,
                    size: 20,
                    color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      childMenu.title(context),
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuItemTap(String uri) {
    setState(() => currentLocation = uri);
    Get.toNamed(uri);
    
    final isMobile = MediaQuery.of(context).size.width <= kScreenWidthLg;
    if (isMobile) {
      _toggleSidebar();
    }
  }
} 
 
