import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_menu_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeeMenu extends StatelessWidget {
  AddEmployeeMenu({super.key});

  final screenController = Get.put(EmployeeMenuController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: ListView(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 150,
                  color: AppColors.defaultColor.withOpacity(0.6),
                ),
                Align(
                  // heightFactor: 0.01,
                  child: Container(
                    height: 100,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    margin: EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: AppColors.bgGreyColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage('assets/profile3.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        buildSizedboxW(kDefaultPadding),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add User Menu',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addMenuForm()),
                        buildSizedboxW(kDefaultPadding),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Column(
                      children: [
                        addMenuForm(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    ));
  }

  Widget addMenuForm() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.bgGreyColor,
            spreadRadius: 5,
            blurRadius: 7,
          )
        ],
      ),
      child: Card(
        color: AppColors.whiteColor,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Menu',
                style: GoogleFonts.montserrat(
                  fontSize: kDefaultPadding + kTextPadding,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildSizedBoxH(kDefaultPadding * 2),
              FormBuilder(
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Obx(
                              () => FormBuilderDropdown(
                                name: 'Company',
                                decoration: const InputDecoration(
                                  labelText: 'Company',
                                  hintText: 'Select Company',
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                ),
                                validator: FormBuilderValidators.required(),
                                items: screenController.companydetails
                                    .map((company) => DropdownMenuItem(
                                          value: company.id,
                                          child: Text(company.companyName),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  screenController.onCompanySelected(value!);
                                },
                              ),
                            ),
                          ),
                        ),
                          Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Obx(
                          () => FormBuilderDropdown<UserModel>(
                            // controller: widget.companyNameController,
                            name: 'User Name',
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                              hintText: 'User Name',
                              border: OutlineInputBorder(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                            // enableSuggestions: false,
                            // keyboardType: TextInputType.name,
                            validator: FormBuilderValidators.required(),
                            items: screenController.filteredUsers
                                .map((user) => DropdownMenuItem(
                                      value: user,
                                      child: Text(user.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              screenController.onUserSelected(
                                  value!.userTypeId, value.companyId, value.id);
                            },
                            // onSaved: (value) => (_formData.firstname = value ?? ''),
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 3),
                  
                    Obx(() {
                      if (screenController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (!screenController.isCompanySelected.value ||
                          !screenController.isUserSelected.value) {
                        return Center(
                            child: Text(
                                "Please select both a company and a user to view menus."));
                      } else if (screenController.menus.isEmpty) {
                        return Center(
                            child: Text(
                                "No menus available for the selected user ."));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: screenController.menus.length,
                          itemBuilder: (context, index) {
                            final mainMenu = screenController.menus[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckboxListTile(
                                  title: Text(
                                    mainMenu.mainMenuName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  value: mainMenu.isSelected,
                                  onChanged: (bool? value) {
                                    screenController
                                        .toggleMainMenu(mainMenu.mainMenuId);
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: kDefaultPadding * 2),
                                  child: Column(
                                    children: mainMenu.subMenus.map((subMenu) {
                                      return CheckboxListTile(
                                        title: Text(subMenu.subMenuName),
                                        value: subMenu.isSelected,
                                        onChanged: (bool? value) {
                                          screenController.toggleSubMenu(
                                            mainMenu.mainMenuId,
                                            subMenu.subMenuId,
                                          );
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        );
                      }
                    }),
                    buildSizedBoxH(kDefaultPadding * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultAddButton(
                          buttonname: 'Add Menu',
                          onClick: () async {
                            await screenController.addMenu();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}