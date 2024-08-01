// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/core/constants/colors.dart';
// import 'package:flutter_dashboard/core/constants/dimens.dart';
// import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
// import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddDepartmentForm extends StatelessWidget {
  
//   const AddDepartmentForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       padding: EdgeInsets.all(kDefaultPadding),
//       decoration: BoxDecoration(color: AppColors.bgGreyColor),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         // mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Add a Department',
//               style: GoogleFonts.montserrat(
//                   fontSize: kDefaultPadding + kTextPadding,
//                   fontWeight: FontWeight.bold)),
//           buildSizedBoxH(kDefaultPadding * 2),
//           FormBuilder(
//             //  key: _formKey,
//             autovalidateMode: AutovalidateMode.disabled,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Flexible(
//                       child: FormBuilderTextField(
//                         name: 'Category/Industry',
//                         controller:
//                             screenController.categoryOrIndustryController,
//                         decoration: InputDecoration(
//                           labelText: 'Category/Industry',
//                           // hintText: 'test.user',
//                           // helperText: '* To test registration fail: admin',
//                           border: const OutlineInputBorder(),
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                         ),
//                         enableSuggestions: false,
//                         validator: FormBuilderValidators.required(),
//                         // onSaved: (value) => (_formData.username = value ?? ''),
//                       ),
//                     ),
//                   ],
//                 ),
//                 buildSizedBoxH(kDefaultPadding * 3),
//                 Row(
//                   children: [
//                     Flexible(
//                       child: FormBuilderTextField(
//                         name: 'Department Name',
//                         controller: screenController.departmentNameController,
//                         decoration: InputDecoration(
//                           labelText: 'Department Name',
//                           // hintText: 'test.user',
//                           // helperText: '* To test registration fail: admin',
//                           border: const OutlineInputBorder(),
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                         ),
//                         enableSuggestions: false,
//                         validator: FormBuilderValidators.required(),
//                         // onSaved: (value) => (_formData.username = value ?? ''),
//                       ),
//                     ),
//                     buildSizedboxW(kDefaultPadding),
//                     Flexible(
//                       child: FormBuilderTextField(
//                         name: 'Status',
//                         controller: screenController.statusController,
//                         decoration: InputDecoration(
//                           labelText: 'Status',
//                           // hintText: 'test@gmail.com',
//                           border: const OutlineInputBorder(),
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: FormBuilderValidators.required(),
//                         // onSaved: (value) => (_formData.email = value ?? ''),
//                       ),
//                     ),
//                   ],
//                 ),
//                 buildSizedBoxH(kDefaultPadding * 3),
//                 Row(
//                   children: [
//                     Flexible(
//                       child: FormBuilderTextField(
//                         name: 'Remarks',
//                         controller: screenController.remarksController,
//                         decoration: const InputDecoration(
//                           labelText: 'Remarks',
//                           hintText: 'Test',
//                           border: OutlineInputBorder(),
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                         ),
//                         enableSuggestions: false,
//                         keyboardType: TextInputType.name,
//                         validator: FormBuilderValidators.required(),
//                         // onSaved: (value) => (_formData.firstname = value ?? ''),
//                       ),
//                     ),
//                     buildSizedboxW(kDefaultPadding),
//                   ],
//                 ),
//                 buildSizedBoxH(kDefaultPadding * 3),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     DefaultAddButton(
//                         buttonname: 'Add a Department',
//                         onClick: () {
//                           screenController.addDepartment();
                           
//                         }),
//                   ],
//                 ),
//                 buildSizedBoxH(kDefaultPadding * 3),
//                 Divider(
//                   indent: kDefaultPadding * 2,
//                   endIndent: kDefaultPadding * 2,
//                 ),
//                 buildSizedBoxH(kDefaultPadding * 3),
//                 buildSizedBoxH(kDefaultPadding * 3),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }