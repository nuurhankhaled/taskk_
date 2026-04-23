import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool? obscureText;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final bool? readOnly;
  final bool? showCursor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isChat;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final Iterable<String>? autofillHints;
  final EdgeInsets? contentPadding;
  final EdgeInsets? padding;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final dynamic height;
  final dynamic enabledBorder;
  final dynamic foucseNode;
  final dynamic focusedBorder;
  final dynamic fillColor;
  final dynamic width;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.isChat = false,
    this.padding,
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.labelText,
    this.backgroundColor,
    this.helperText,
    this.borderColor,
    this.borderWidth,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.borderRadius,
    this.onSaved,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.autofillHints,
    this.contentPadding,
    this.expands,
    this.maxLines,
    this.minLines,
    this.onFieldSubmitted,
    this.buildCounter,
    this.scrollPhysics,
    this.onTap,
    this.height,
    this.enabledBorder,
    this.focusedBorder,
    this.foucseNode,
    this.fillColor,
    this.width,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 75,
      padding: widget.padding,
      width: widget.width,
      alignment: Alignment.center,
      child: Center(
        child: TextFormField(
          focusNode: widget.foucseNode,
          style: widget.textStyle ?? const TextStyle(fontSize: 14),
          autofillHints: widget.autofillHints,
          onTapOutside: widget.isChat
              ? null
              : (event) => FocusScope.of(context).unfocus(),
          controller: widget.controller,
          obscureText: widget.obscureText!,
          autofocus: widget.autofocus!,
          autocorrect: widget.autocorrect!,
          enableSuggestions: widget.enableSuggestions!,
          readOnly: widget.readOnly!,
          showCursor: widget.showCursor,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          validator: widget.validator,
          onSaved: widget.onSaved,
          inputFormatters: widget.inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: true,
            floatingLabelStyle: TextStyle(
              color: widget.borderColor ?? Colors.grey.shade400,
            ),
            focusedBorder:
                widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.deepPurpleAccent,
                    width: (widget.borderWidth) ?? 1,
                  ),
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(30),
                ),
            enabledBorder:
                widget.enabledBorder ??
                OutlineInputBorder(
                  gapPadding: 01,
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.grey.shade400,
                    width: widget.borderWidth ?? 1,
                  ),
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(30),
                ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(30.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
            labelText: widget.labelText,
            hintStyle:
                widget.hintStyle ??
                const TextStyle(fontSize: 14, color: Colors.grey),
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            suffixIcon: widget.suffixIcon,
            enabled: widget.enabled ?? true,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          expands: widget.expands ?? false,
          maxLines: widget.maxLines ?? 1,
          minLines: widget.minLines,
          onFieldSubmitted: widget.onFieldSubmitted,
          scrollPhysics: widget.scrollPhysics,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
