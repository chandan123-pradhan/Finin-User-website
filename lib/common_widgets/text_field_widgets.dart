import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naukri_user/utils/color_utils.dart';

class TextFieldWidgets {
  static FlutterTts flutterTts = FlutterTts();

  // Function to speak the entered text
  static void _speakText(String text) async {
    flutterTts.setLanguage("hi-IN"); // Set language to English
    flutterTts.setPitch(1.2); // Set pitch to normal
    if (text.isNotEmpty) {
      await flutterTts.speak(text); // Speak the text
    } else {
      await flutterTts.speak("Please enter a message first.");
    }
  }

  static Widget getTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    bool obscureText = false, // Optional parameter for password fields
    String? Function(String?)? validator, // Optional validator
    Function(String)? onChanged,
    VoidCallback? onCompleteEditing, // Fixed this to VoidCallback
    TextInputType? inputType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onCompleteEditing, // This should now work correctly

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelText: title,
        labelStyle: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 14,
          color: ColorUtils.lightGrey,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      validator: validator, // Attach the validator to the TextFormField
      onChanged: onChanged,
      keyboardType: inputType ?? TextInputType.text,
    );
  }

  static Widget getGuiderTextField(
      {required BuildContext context,
      required TextEditingController controller,
      required String title,
      bool obscureText = false,
      String? Function(String?)? validator,
      Function(String)? onChanged,
      VoidCallback? onCompleteEditing,
      required String guiderMessage}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onCompleteEditing,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelText: title,
        labelStyle: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 14,
          color: ColorUtils.lightGrey,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,

          icon: Icon(
            Icons.mic_none_rounded,
            color: ColorUtils.darkGray,
            size: 20,
          ), // Mic icon
          onPressed: () {
            String textToSpeak = guiderMessage;
            _speakText(textToSpeak); // Trigger TTS when icon is pressed
          },
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  static Widget getDescriptionText({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    bool obscureText = false, // Optional parameter for password fields
    String? Function(String?)? validator, // Optional validator
    Function(String)? onChanged,
    VoidCallback? onCompleteEditing, // Fixed this to VoidCallback
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onCompleteEditing, // This should now work correctly
      maxLines: null, // Allow infinite lines (new lines on "Enter")
      keyboardType: TextInputType.multiline, // Allow multiline input
      textInputAction:
          TextInputAction.newline, // Ensures "Enter" creates a new line
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelText: title,
        labelStyle: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 14,
          color: ColorUtils.lightGrey,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator, // Attach the validator to the TextFormField
      onChanged: onChanged,
    );
  }
}
