import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onSubmitted;

  SearchField({required this.controller, this.onChanged, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: (value) => onSubmitted?.call(),
        style: TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black45),
          hintText: 'Search for jobs...',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
