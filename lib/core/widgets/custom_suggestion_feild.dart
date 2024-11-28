import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';

class CustomSuggessionTextFormField extends StatelessWidget {
  CustomSuggessionTextFormField({
    required this.controller,
    required this.suggestons,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.width,
    this.onSelected,
    this.labelText,
    this.focusNode,
    this.onChanged,
    this.readOnly = false,
    this.isBoldSuggessions = false,
    this.sugessionFontSize,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final List<String> suggestons;
  final Widget? prefixIcon;
  final dynamic validator;
  final double? width, sugessionFontSize;
  final Function? onSelected;
  final Function? onChanged;
  final FocusNode? focusNode;
  final bool readOnly, isBoldSuggessions;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete(
      onSelected: (String selection) {
        log('You just selected $selection');
        controller.text = selection;
        if (onSelected != null) {
          onSelected!();
        }
      },
      focusNode: focusNode,
      textEditingController: focusNode != null ? _controller : null,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        textEditingController.text = controller.text;
        textEditingController.selection = TextSelection.collapsed(
            offset: textEditingController.text.length);
        return TextFormField(
          controller: textEditingController,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: AppColors.blackColor),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greycolor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.defaultColor,
                width: 1.5,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: prefixIcon,
          ),
          readOnly: readOnly,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.blackColor,
          ),
          onChanged: (value) {
            controller.text = value;
            if (onChanged != null) {
              onChanged!();
            }
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          void Function(String) onSelected, Iterable<String> options) {
        final optt = options.toList();
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Container(
                width: width,
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: optt.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => onSelected(optt[index]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        optt[index],
                        style: TextStyle(
                          fontSize: sugessionFontSize ?? 14,
                          fontWeight: isBoldSuggessions
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        // Modified to only match suggestions that start with the input text
        return suggestons.where((String option) {
          return option
              .toLowerCase()
              .startsWith(textEditingValue.text.toLowerCase());
        });
      },
    );
  }
}