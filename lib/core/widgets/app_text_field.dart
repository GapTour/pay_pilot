// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final GlobalKey<FormState>? formKey;
  final String? hint;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String? validatorText;
  final bool? autoFocus;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final FocusNode? nextFocusNode;
  final Function()? onEditingComplete;
  final int? maxLength;
  final Function(FocusNode? focusNode)? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  final int? customLines;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.label,
    this.formKey,
    this.hint,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.validatorText,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.onChange,
    this.onFieldSubmitted,
    this.nextFocusNode,
    this.onEditingComplete,
    this.maxLength,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.customLines,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // bool _hasFocus = false;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.focusNode?.addListener(_handleFocusChange);
  // }

  // @override
  // void dispose() {
  //   widget.focusNode?.removeListener(_handleFocusChange);
  //   super.dispose();
  // }

  // void _handleFocusChange() {
  //   setState(() {
  //     _hasFocus = widget.focusNode?.hasFocus ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label!, style: Theme.of(context).textTheme.labelMedium),
          const Gap(6),
          if (widget.validatorText == null)
            _customTextFormField(context)
          else
            Form(key: widget.formKey, child: _customTextFormField(context)),
        ],
      );
    } else {
      if (widget.validatorText == null) {
        return _customTextFormField(context);
      } else {
        return Form(key: widget.formKey, child: _customTextFormField(context));
      }
    }
  }

  Widget _customTextFormField(BuildContext ctx) {
    return SizedBox(
      height: 68,
      child: TextFormField(
        focusNode: widget.focusNode,
        onTap: widget.onTap == null
            ? null
            : () => widget.onTap!(widget.focusNode),
        onFieldSubmitted:
            widget.onFieldSubmitted ??
            (s) {
              FocusScope.of(ctx).requestFocus(widget.nextFocusNode);
            },
        style: Theme.of(context).textTheme.displayLarge,

        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        onEditingComplete: widget.onEditingComplete,
        controller: widget.controller,
        onChanged: widget.onChange,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        obscureText: widget.keyboardType == TextInputType.visiblePassword,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        inputFormatters: widget.inputFormatters,
        validator: widget.validatorText == null
            ? widget.validator
            : (value) {
                if (value!.isEmpty) {
                  return widget.validatorText;
                }
                return null;
              },
        autofocus: widget.autoFocus!,
        // cursorColor: AppColors.mediumGray,
        mouseCursor: MouseCursor.defer,
        cursorColor: kOnPrimaryColor.withAlpha(150),
        decoration: InputDecoration(
          // hoverColor: kSecondaryColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          hintStyle: TextStyle(
            color: kOnPrimaryColor.withAlpha(100),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          // errorStyle: AppTextStyle.getRegularXsStyle(
          //   color: _hasFocus
          //       ? AppColors.accentWarning700
          //       : AppColors.accentWarning900,
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryContainerColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryContainerColor.withAlpha(100),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    widget.prefixIcon,
                    size: 15,
                    color: kPrimaryContainerColor,
                  ),
                ),
          // prefixIconColor: AppColors.mediumGray,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 15,
            minWidth: 15,
          ),
          suffixIcon: widget.suffixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: widget.onTapSuffixIcon,
                    child: Icon(widget.suffixIcon),
                  ),
                ),
          counterText: '',
          // fillColor: AppColors.deepBlueGray,
          filled: true,
        ),
      ),
    );
  }
}
