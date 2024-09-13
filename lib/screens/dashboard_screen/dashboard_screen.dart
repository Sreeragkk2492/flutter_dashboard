import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/line_chart_dashboard.dart';
import 'package:flutter_dashboard/screens/dashboard_screen/widget/dashboard_card.dart';
import 'package:flutter_dashboard/screens/dashboard_screen/widget/summary_card_dashboard.dart';
import '../../core/widgets/sized_boxes.dart';

class DashboardScreen extends StatelessWidget {
  final _dataTableHorizontalScrollController = ScrollController();

  DashboardScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    const dashboardCardCount = 2;
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);

    return PortalMasterLayout(
      body: ListView(
        padding: EdgeInsets.all(kDefaultPadding),
        children: [
          buildSizedBoxH(kDefaultPadding),
          EntranceFader(
            child: Column(
              children: [
                Visibility(
                  visible: (size.width >= kScreenWidthXxl),
                  child: Row(
                    children: [
                      Expanded(child: _buildChart()),
                      buildSizedboxW(kDefaultPadding),
                      Expanded(child: _builddashboardCard(dashboardCardCount)),
                    ],
                  ),
                ),
                Visibility(
                    visible: (size.width <= kScreenWidthXxl),
                    child: _buildChart()),
                Visibility(
                  visible: (size.width <= kScreenWidthXxl),
                  child: _builddashboardCard(dashboardCardCount),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final summaryCardWidth = ((constraints.maxWidth -
                            (kDefaultPadding *
                                (summaryCardCrossAxisCount - 1))) /
                        summaryCardCrossAxisCount);

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        SummaryCard(
                          title: 'New Orders',
                          value: '87.4',
                          icon: Icons.shopping_cart_rounded,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.blackColor,
                          iconColor: AppColors.greycolor,
                          width: summaryCardWidth,
                        ),
                        SummaryCard(
                          title: 'Today Sales',
                          value: '+12%',
                          icon: Icons.ssid_chart_outlined,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.blackColor,
                          iconColor: AppColors.greycolor,
                          width: summaryCardWidth,
                        ),
                        SummaryCard(
                          title: 'New Users',
                          value: '44.4',
                          icon: Icons.group_add_rounded,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.blackColor,
                          iconColor: AppColors.greycolor,
                          width: summaryCardWidth,
                        ),
                        SummaryCard(
                          title: 'Pending Issues',
                          value: '80',
                          icon: Icons.report_gmailerrorred_rounded,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.blackColor,
                          iconColor: AppColors.greycolor,
                          width: summaryCardWidth,
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: kDefaultPadding / 2, top: kDefaultPadding),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CardHeader(
                          title: 'Recent Orders',
                          showDivider: false,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double dataTableWidth =
                                  max(kScreenWidthMd, constraints.maxWidth);

                              return Column(
                                children: [ 
                                 
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller:
                                        _dataTableHorizontalScrollController,
                                    child: SizedBox(
                                      width: dataTableWidth,
                                      child: DataTable(
                                        showCheckboxColumn: false,
                                       // showBottomBorder: true,
                                        columns: const [
                                          DataColumn(label: Text('No.')),
                                          DataColumn(label: Text('Date')),
                                          DataColumn(label: Text('Item')),
                                          DataColumn(
                                            label: Text('Rating'),
                                          ),
                                          DataColumn(
                                            label: Text('Qty'),
                                          ),
                                          DataColumn(
                                            label: Text('Price'),
                                          ),
                                        ],
                                        rows: List.generate(5, (index) {
                                          return DataRow.byIndex(
                                            index: index,
                                            cells: [
                                              DataCell(Text('#${index + 1}')),
                                              const DataCell(Text('2022-06-30')),
                                              DataCell(Text('Item ${index + 1}')),
                                              DataCell(Text(
                                                  '${Random().nextInt(50)}')),
                                              DataCell(Text(
                                                  '${Random().nextInt(100)}')),
                                              DataCell(Text(
                                                  '${Random().nextInt(10000)}')),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Scrollbar(child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: dataTableWidth,
                                    ),
                                  ),)
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return const LineChartCard();
  }

  Widget _builddashboardCard(
    int dashboardCardCount,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final summaryCardWidth = ((constraints.maxWidth -
                  (kDefaultPadding * (dashboardCardCount - 1))) /
              dashboardCardCount);

          return Wrap(
            direction: Axis.horizontal,
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding,
            children: [
              DashboardCard(
                title: 'New Orders',
                value: '87.4',
                icon: Image.asset(
                  'assets/circular.png',
                  height: kDefaultPadding * 2.5,
                ),
                backgroundColor: AppColors.contactGradi,
                textColor: AppColors.blackColor,
                iconColor: Colors.transparent,
                width: summaryCardWidth,
                subtitle: '54.9 %',
              ),
              DashboardCard(
                title: 'Today Sales',
                value: '80.4',
                icon: Image.asset(
                  'assets/clipboard.png',
                  height: kDefaultPadding * 2.5,
                ),
                backgroundColor: AppColors.contactGradi,
                textColor: AppColors.blackColor,
                iconColor: Colors.transparent,
                width: summaryCardWidth,
                subtitle: '64.9 %',
              ),
              DashboardCard(
                title: 'New Users',
                value: '17.4k',
                icon: Image.asset(
                  'assets/greengift.png',
                  height: kDefaultPadding * 2.5,
                ),
                backgroundColor: AppColors.contactGradi,
                textColor: AppColors.blackColor,
                iconColor: Colors.transparent,
                width: summaryCardWidth,
                subtitle: '74.9 %',
              ),
              DashboardCard(
                title: 'Pending Issues',
                value: '67.4k',
                icon: Image.asset(
                  'assets/dashboard.png',
                  height: kDefaultPadding * 2.5,
                ),
                backgroundColor: AppColors.contactGradi,
                textColor: AppColors.blackColor,
                iconColor: Colors.transparent,
                width: summaryCardWidth,
                subtitle: '154.9 %',
              ),
            ],
          );
        },
      ),
    );
  }
}
