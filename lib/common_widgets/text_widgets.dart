import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naukri_user/utils/color_utils.dart';

Text headingH1({required String text, required BuildContext context}) {
  return Text(
    text,
    style: GoogleFonts.inriaSans(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 36,
      color: ColorUtils.primaryBlue,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}
Text headingH2({required String text, required BuildContext context}) {
  return Text(
    text,
    style: GoogleFonts.inriaSans(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 26,
      color: ColorUtils.primaryBlue,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}


Text headingH3(
    {required String text,
    required BuildContext context,
    Color color = ColorUtils.primaryBlue}) {
  return Text(
    text,
    style: GoogleFonts.inriaSans(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}

Text heading3Custom(
    {required String text,
    required BuildContext context,
    Color color = ColorUtils.primaryBlue}) {
  return Text(
    text,
    style: GoogleFonts.inriaSans(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 15,
      color: color,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  );
}

Text headingH4({required String text, required BuildContext context}) {
  return Text(
    text,
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 22,
      color: ColorUtils.darkGray,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}

Text headingH5(
    {required String text,
    required BuildContext context,
    Color color = ColorUtils.primaryBlue}) {
  return Text(
    text,
    style: GoogleFonts.inriaSans(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}

dynamic headingH6(
    {required String text,
    required BuildContext context,
    Color color = ColorUtils.primaryBlue,
    bool isSelectable = false}) {
  return isSelectable
      ? SelectableText(
          text,
          style: GoogleFonts.inriaSans(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        )
      : Text(
          text,
          style: GoogleFonts.inriaSans(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        );
}

Text headingH10(
    {required String text,
    required BuildContext context,
    bool isHyperLink = false,
    Color color = ColorUtils.lightGrey,
    bool isMultiline=false,
    bool underLine = false}) {
  return
  isMultiline?Text(
    textAlign: TextAlign.center,
    text,
    // maxLines: 5,
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 14,
      color: isHyperLink ? ColorUtils.primaryBlue : color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      decoration: underLine ? TextDecoration.underline : TextDecoration.none,
    ),
  ):
  
   Text(
    textAlign: TextAlign.center,
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 14,
      color: isHyperLink ? ColorUtils.primaryBlue : color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      decoration: underLine ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}

Text headingH11(
    {required String text,
    required BuildContext context,
    bool isHyperLink = false,
    Color color = ColorUtils.lightGrey}) {
  return Text(
    text,
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 10,
      color: isHyperLink ? ColorUtils.primaryBlue : color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
  );
}

Text headingH12(
    {required String text,
    required BuildContext context,
    bool isHyperLink = false,
    Color color = ColorUtils.lightGrey}) {
  return Text(
    text,
    style: GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 12,
      color: isHyperLink ? ColorUtils.primaryBlue : color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
  );
}
