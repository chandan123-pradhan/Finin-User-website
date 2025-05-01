import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/utils/color_utils.dart';

class DropdownWidgets {
  static Widget getDropdown({
    required BuildContext context,
    required List<String> items, // List of items to show in the dropdown
    required String selectedValue, // Initially selected value
    required Function(String?) onChanged, // Callback when the selection changes
    String? hintText, // Optional hint text
    bool isExpanded = true, // If true, the dropdown will be expanded
    EdgeInsetsGeometry? padding, // Optional padding for the dropdown
    TextStyle? labelStyle, // Optional label style customization
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
            value: item,
            child: headingH10(
                text: item, context: context, color: ColorUtils.darkGray));
      }).toList(),
      isExpanded: isExpanded, // Whether the dropdown expands to full width
    );
  }
}
