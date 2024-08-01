import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsDialogEmpWidget extends StatelessWidget {
  const DetailsDialogEmpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic Information',
            style: GoogleFonts.montserrat(
                fontSize: kDefaultPadding + kTextPadding,
                fontWeight: FontWeight.w800)),
        const Divider(),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('First Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Last Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Company Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Username:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Password:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Employee Id:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Biometric Id:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Reporting To:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Department:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Designation:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Usertype:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 3),
        Text('Detailed Information',
            style: GoogleFonts.montserrat(
                fontSize: kDefaultPadding + kTextPadding,
                fontWeight: FontWeight.w800)),
        const Divider(),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Father Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Mother Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        const Row(
          children: [
            Expanded(
                child: Flexible(
                    child: Text('Address:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Date Of Birth:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Phone Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Joining Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Is Active:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 1),
      ],
    );
  }
}
