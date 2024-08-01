import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsFormWidget extends StatelessWidget {
  const DetailsFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Basic information',
            style: GoogleFonts.montserrat(
                fontSize: kDefaultPadding + kTextPadding,
                fontWeight: FontWeight.w800)),
        const Divider(),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Company ID:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Company Code:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Company Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Industry/Category:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Status:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Group Name:',
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
                    child: Text('Legal Name:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Founder/Owner:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Email:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('Pan:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('Whatsapp:',
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
        buildSizedBoxH(kDefaultPadding * 2),
        const Text('Address:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        buildSizedBoxH(kDefaultPadding * 2),
        const Text('Landmark:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('City:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('State:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        const Row(
          children: [
            Expanded(
                child: Flexible(
                    child: Text('Country:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('VAT Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text("VAT Rate:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Row(
          children: [
            const Expanded(
                child: Flexible(
                    child: Text('GST Number:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
            buildSizedboxW(kDefaultPadding),
            const Expanded(
                child: Flexible(
                    child: Text('GST Compunding:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)))),
          ],
        ),
      ],
    );
  }
}
