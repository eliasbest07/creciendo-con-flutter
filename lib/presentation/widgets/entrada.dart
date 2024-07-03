import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField2 extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final int maxLines;
  final String? initialValue;
  final TextAlign textAlign;
 
  const CustomTextFormField2({
    super.key,
    this.controller,
    required this.title,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.readOnly = false,
    this.suffixIcon,
    this.textInputAction,
    this.maxLines = 1,
    this.initialValue,
    this.textAlign = TextAlign.start,
  });
 
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
 
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFF4F4F4)),
      borderRadius: BorderRadius.circular(20),
    );
 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            // style: GoogleFonts.poppins(
            //   fontSize: 15,
            //   color: Colors.black,
            //   fontWeight: FontWeight.w600,
            // ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(6, 0, 0, 0),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 7.0,
                )
              ],
            ),
            child: TextFormField(
              controller: controller,
              onEditingComplete: onEditingComplete,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              validator: validator,
              obscureText: obscureText,
              keyboardType: keyboardType,
              focusNode: focusNode,
              readOnly: readOnly,
              textInputAction: textInputAction,
              onTap: onTap,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: maxLines,
              initialValue: initialValue,
              textAlign: textAlign,
              // style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                // floatingLabelStyle: GoogleFonts.poppins(
                //   color: Colors.black,
                //   fontWeight: FontWeight.bold,
                //   fontSize: 15,
                // ),
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border.copyWith(
                  borderSide: BorderSide(
                    color: Colors.red.shade700,
                  ),
                ),
                focusedErrorBorder: border.copyWith(
                  borderSide: BorderSide(
                    color: Colors.red.shade700,
                  ),
                ),
                //isDense: true,
                // hintStyle: GoogleFonts.poppins(
                //   fontSize: 16,
                //   color: const Color(0xffB9B9B9),
                //   fontWeight: FontWeight.w600,
                // ),
                hintText: hint,
                errorText: errorMessage,
                // errorStyle: GoogleFonts.poppins(
                //   fontSize: 12,
                //   color: Colors.red.shade700,
                // ),
                focusColor: colors.primary,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}