library intl_mobile_field;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/flags_drop_down.dart';
import 'package:intl_mobile_field/helpers.dart';
import 'package:intl_mobile_field/mobile_number.dart';

class IntlMobileField extends StatefulWidget {
  /// The TextFormField key.
  final GlobalKey<FormFieldState>? formFieldKey;

  /// Border for the input
  final InputBorder? border;

  /// Prefix Dropdown Constraints
  final BoxConstraints? prefixIconConstraints;

  /// Text Form Field fill Color
  final Color? fillColor;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// Creates a [FormField] that contains a [TextField].

  /// onTap is called when the user taps on the text field.
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final FormFieldSetter<MobileNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<MobileNumber>? onChanged;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// A [MobileNumber] is passed to the validator as argument.
  /// The validator can handle asynchronous validation when declared as a [Future].
  /// Or run synchronously when declared as a [Function].
  ///
  /// By default, the validator checks whether the input number length is between selected country's mobile numbers min and max length.
  /// If `disableLengthCheck` is not set to `true`, your validator returned value will be overwritten by the default validator.
  /// But, if `disableLengthCheck` is set to `true`, your validator will have to check mobile number length itself.
  final FutureOr<String?> Function(MobileNumber?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// List of Country to display see countries.dart for format
  final List<Country>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Disable view Min/Max Length check
  final bool disableLengthCounter;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autoFocus;

  /// Autovalidate mode for text form field.
  ///
  /// If [AutovalidateMode.onUserInteraction], this FormField will only auto-validate after its content changes.
  /// If [AutovalidateMode.always], it will auto-validate even without user interaction.
  /// If [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.onUserInteraction].
  final AutovalidateMode? autovalidateMode;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Enable the autofill hint for mobile number.
  final bool disableAutoFillHints;

  /// If null, default magnification configuration will be used.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// When this widget receives focus and is not completely visible (for example scrolled partially
  /// off the screen or overlapped by the keyboard)
  /// then it will attempt to make itself visible by scrolling a surrounding [Scrollable], if one is present.
  /// This value controls how far from the edges of a [Scrollable] the TextField will be positioned after the scroll.
  final EdgeInsets scrollPadding;

  /// [expands] If set to true and wrapped in a parent widget like Expanded or SizedBox,
  /// the input will expand to fill the parent.
  final bool expands;

  /// define how many lines that you need for the IntlPhoneField (by default set by 1)
  final int? maxLines;

  /// when they tap outside of the text field. By default, this callback unfocused the text field, meaning it will lose focus when the user taps outside, which can help users exit the field more easily.
  final TapRegionCallback? onTapOutside;

  /// in prefixIcon you can use any widget. By default it's show [FlagsDropDown] widget,
  final Widget? prefixIcon;

  /// in suffixIcon you can use any widget.
  final Widget? suffixIcon;

  const IntlMobileField({
    super.key,
    this.formFieldKey,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.disableAutoFillHints = false,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.border,
    this.fillColor,
    this.prefixIconConstraints,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onSaved,
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    this.autoFocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.disableLengthCounter = false,
    this.invalidNumberMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.magnifierConfiguration,
    this.expands = false,
    this.maxLines = 1,
    this.onTapOutside,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<IntlMobileField> createState() => _IntlMobileFieldState();
}

// class _IntlMobileFieldState extends State<IntlMobileField> {
//   late List<Country> countryList;
//   late Country _selectedCountry;
//   String? validatorMessage;
//   String number = '';
//   String? asyncValidationMessage;
//   bool isValidating = false;

//   Timer? _debounceTimer;

//   @override
//   void initState() {
//     super.initState();
//     countryList = widget.countries ?? countries;

//     number = widget.initialValue ?? '';
//     _selectedCountry = _getInitialCountry(number);

//     number = _stripCountryCode(number, _selectedCountry);

//     if (widget.autovalidateMode == AutovalidateMode.always) {
//       _validateAsync(
//         MobileNumber(
//           countryISOCode: _selectedCountry.code,
//           countryCode: '+${_selectedCountry.dialCode}',
//           number: number,
//         ),
//       );
//     }
//   }

//   Country _getInitialCountry(String number) {
//     if (number.startsWith('+')) {
//       number = number.substring(1);
//       return countries.firstWhere(
//         (c) => number.startsWith(c.fullCountryCode),
//         orElse: () => countryList.first,
//       );
//     }
//     return countryList.firstWhere(
//       (c) => c.code == 'BD',
//       orElse: () => countryList.first,
//     );
//   }

//   String _stripCountryCode(String number, Country country) {
//     final codePattern = RegExp("^\\+?${country.fullCountryCode}");
//     return number.replaceFirst(codePattern, "");
//   }

//   void _onChanged(String value) {
//     final mobileNumber = MobileNumber(
//       countryISOCode: _selectedCountry.code,
//       countryCode: '+${_selectedCountry.fullCountryCode}',
//       number: value,
//     );

//     widget.onChanged?.call(mobileNumber);

//     if (widget.autovalidateMode != AutovalidateMode.disabled) {
//       validatorMessage = _validateSync(mobileNumber);
//     }

//     _debounceTimer?.cancel();
//     _debounceTimer = Timer(const Duration(milliseconds: 300), () {
//       _validateAsync(mobileNumber);
//     });
//   }

//   String? _validateSync(MobileNumber mobileNumber) {
//     final value = mobileNumber.number;

//     if (!isNumeric(value)) {
//       return widget.invalidNumberMessage;
//     }

//     if (!widget.disableLengthCheck) {
//       final validLength = value.length >= _selectedCountry.minLength &&
//           value.length <= _selectedCountry.maxLength;
//       if (!validLength) {
//         return widget.invalidNumberMessage;
//       }
//     }

//     return null;
//   }

//   Future<void> _validateAsync(MobileNumber mobileNumber) async {
//     if (widget.validator == null) return;

//     setState(() {
//       isValidating = true;
//     });

//     final result = await widget.validator!.call(mobileNumber);

//     if (mounted) {
//       setState(() {
//         asyncValidationMessage = result;
//         isValidating = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _debounceTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: widget.formFieldKey,
//       initialValue: widget.controller == null ? number : null,
//       autofillHints: widget.disableAutoFillHints
//           ? null
//           : [AutofillHints.telephoneNumberNational],
//       readOnly: widget.readOnly,
//       obscureText: widget.obscureText,
//       textAlign: widget.textAlign,
//       textAlignVertical: widget.textAlignVertical,
//       cursorColor: widget.cursorColor,
//       onTap: widget.onTap,
//       onTapOutside: widget.onTapOutside ??
//           (_) => FocusManager.instance.primaryFocus?.unfocus(),
//       controller: widget.controller,
//       focusNode: widget.focusNode,
//       cursorHeight: widget.cursorHeight,
//       cursorRadius: widget.cursorRadius,
//       cursorWidth: widget.cursorWidth,
//       showCursor: widget.showCursor,
//       onFieldSubmitted: widget.onSubmitted,
//       expands: widget.expands,
//       maxLines: widget.maxLines,
//       magnifierConfiguration: widget.magnifierConfiguration,
//       decoration: widget.decoration.copyWith(
//         prefixIcon: widget.prefixIcon ??
//             FlagsDropDown(
//               initialCountryCode: _selectedCountry.code,
//               onCountryChanged: (newCountry) {
//                 if (newCountry != _selectedCountry) {
//                   setState(() {
//                     _selectedCountry = newCountry;
//                   });
//                 }
//               },
//             ),
//         counterText: widget.enabled ? null : '',
//         border: widget.border,
//         enabledBorder: widget.border,
//         focusedBorder: widget.border,
//         prefixIconConstraints: widget.prefixIconConstraints,
//         filled: widget.fillColor != null,
//         fillColor: widget.fillColor,
//         suffixIcon: widget.suffixIcon,
//       ),
//       style: widget.style,
//       onSaved: (value) {
//         widget.onSaved?.call(
//           MobileNumber(
//             countryISOCode: _selectedCountry.code,
//             countryCode:
//                 '+${_selectedCountry.dialCode}${_selectedCountry.regionCode}',
//             number: value!,
//           ),
//         );
//       },
//       onChanged: _onChanged,
//       validator: (value) {
//         final mobileNumber = MobileNumber(
//           countryISOCode: _selectedCountry.code,
//           countryCode: '+${_selectedCountry.fullCountryCode}',
//           number: value ?? '',
//         );

//         // Return async error if already available
//         if (asyncValidationMessage != null) {
//           return asyncValidationMessage;
//         }

//         // Get result from validator callback
//         final result = widget.validator?.call(mobileNumber);

//         // Async validator
//         if (result != null && result is Future<String?>) {
//           result.then((msg) {
//             if (mounted) {
//               setState(() {
//                 asyncValidationMessage = msg;
//               });
//             }
//           });

//           return validatorMessage ?? widget.invalidNumberMessage;
//         }

//         // Sync validator
//         if (result is String) return result;

//         // Otherwise run sync validation fallback
//         final syncError = _validateSync(mobileNumber);
//         return syncError;
//       },
//       maxLength:
//           widget.disableLengthCounter ? null : _selectedCountry.maxLength,
//       keyboardType: widget.keyboardType,
//       inputFormatters: widget.inputFormatters,
//       enabled: widget.enabled,
//       keyboardAppearance: widget.keyboardAppearance,
//       autofocus: widget.autoFocus,
//       textInputAction: widget.textInputAction,
//       autovalidateMode: widget.autovalidateMode,
//       scrollPadding: widget.scrollPadding,
//     );
//   }
// }

class _IntlMobileFieldState extends State<IntlMobileField> {
  late List<Country> countryList;
  late Country _selectedCountry;
  String number = '';
  String? asyncValidationMessage;
  bool isValidating = false;

  Timer? _debounceTimer;

  String get _selectedCountryDialCode => '+${_selectedCountry.fullCountryCode}';

  MobileNumber _buildMobileNumber(String? number) {
    return MobileNumber(
      countryISOCode: _selectedCountry.code,
      countryCode: _selectedCountryDialCode,
      number: number ?? '',
    );
  }

  @override
  void initState() {
    super.initState();
    countryList = widget.countries ?? countries;

    final initial = widget.initialValue ?? '';
    _selectedCountry = _getInitialCountry(initial);
    number = _stripCountryCode(initial, _selectedCountry);

    if (widget.autovalidateMode == AutovalidateMode.always) {
      _validateAsync(_buildMobileNumber(number));
    }
  }

  Country _getInitialCountry(String number) {
    if (number.startsWith('+')) {
      number = number.substring(1);
      return countries.firstWhere(
        (c) => number.startsWith(c.fullCountryCode),
        orElse: () => countryList.first,
      );
    }
    return countryList.firstWhere(
      (c) => c.code == 'BD',
      orElse: () => countryList.first,
    );
  }

  String _stripCountryCode(String number, Country country) {
    final codePattern = RegExp("^\\+?${country.fullCountryCode}");
    return number.replaceFirst(codePattern, "");
  }

  void _onChanged(String value) {
    final mobileNumber = _buildMobileNumber(value);
    widget.onChanged?.call(mobileNumber);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _validateAsync(mobileNumber);
    });
  }

  String? _validateSync(MobileNumber mobileNumber) {
    final value = mobileNumber.number;

    if (!isNumeric(value)) return widget.invalidNumberMessage;

    if (!widget.disableLengthCheck) {
      final isValidLength = value.length >= _selectedCountry.minLength &&
          value.length <= _selectedCountry.maxLength;
      if (!isValidLength) return widget.invalidNumberMessage;
    }

    return null;
  }

  Future<void> _validateAsync(MobileNumber mobileNumber) async {
    if (widget.validator == null) return;

    setState(() => isValidating = true);

    final result = await widget.validator!.call(mobileNumber);

    if (mounted) {
      setState(() {
        asyncValidationMessage = result;
        isValidating = false;
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formFieldKey,
      initialValue: widget.controller == null ? number : null,
      autofillHints: widget.disableAutoFillHints
          ? null
          : [AutofillHints.telephoneNumberNational],
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside ??
          (_) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onSubmitted,
      expands: widget.expands,
      maxLines: widget.maxLines,
      magnifierConfiguration: widget.magnifierConfiguration,
      decoration: widget.decoration.copyWith(
        prefixIcon: widget.prefixIcon ??
            FlagsDropDown(
              initialCountryCode: _selectedCountry.code,
              onCountryChanged: (newCountry) {
                if (newCountry != _selectedCountry) {
                  setState(() {
                    _selectedCountry = newCountry;
                  });
                }
              },
            ),
        counterText: widget.enabled ? null : '',
        border: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        prefixIconConstraints: widget.prefixIconConstraints,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        suffixIcon: widget.suffixIcon,
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(_buildMobileNumber(value));
      },
      onChanged: _onChanged,
      validator: (value) {
        final mobileNumber = _buildMobileNumber(value);

        // Show async error if it's already available
        if (asyncValidationMessage != null) {
          return asyncValidationMessage;
        }

        final result = widget.validator?.call(mobileNumber);

        // Async validator
        if (result is Future<String?>) {
          result.then((msg) {
            if (mounted) {
              setState(() => asyncValidationMessage = msg);
            }
          });

          return widget.invalidNumberMessage;
        }

        // Sync validator
        if (result is String) return result;

        // Fallback to built-in sync validation
        return _validateSync(mobileNumber);
      },
      maxLength:
          widget.disableLengthCounter ? null : _selectedCountry.maxLength,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autoFocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
      scrollPadding: widget.scrollPadding,
    );
  }
}
