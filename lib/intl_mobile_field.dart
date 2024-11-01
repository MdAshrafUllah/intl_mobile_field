library intl_mobile_field;

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/country_picker_dialog.dart';
import 'package:intl_mobile_field/helpers.dart';
import 'package:intl_mobile_field/mobile_number.dart';

class IntlMobileField extends StatefulWidget {
  /// The TextFormField key.
  final GlobalKey<FormFieldState>? formFieldKey;

  final ValueKey? flagsButtonKey;

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

  final ValueChanged<Country>? onCountryChanged;

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

  final String languageCode;

  /// 2 letter ISO Code or country dial code.
  ///
  /// ```dart
  /// initialCountryCode: 'IN', // India
  /// initialCountryCode: '+225', // Côte d'Ivoire
  /// ```
  final String? initialCountryCode;

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

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The text that describes the search input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on top of the input field (i.e., at the same location on the screen where text may be entered in the input field).
  /// When the input field receives focus (or if the field is non-empty), the label moves above (i.e., vertically adjacent to) the input field.
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropdownIcon;

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

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

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

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  /// Enable the autofill hint for mobile number.
  final bool disableAutoFillHints;

  /// If null, default magnification configuration will be used.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// added favorite countries to the top of the list
  final List<String> favorite;

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

  /// disable country choses by user
  final bool disableFlagTap;

  /// when they tap outside of the text field. By default, this callback unfocused the text field, meaning it will lose focus when the user taps outside, which can help users exit the field more easily.
  final TapRegionCallback? onTapOutside;

  /// The width of the country flag.
  final double? flagWidth;

  /// Enable or disable the Favorite Icon for the Favorite Country Lists.
  final bool enableFavoriteIcon;

  /// Whether the favorite icon is left or right aligned.
  final bool favoriteIconIsLeft;

  /// The icon to be displayed when favorite country list is Created.
  final Widget? favoriteIcon;

  /// The country code position.
  final bool countryCodePositionRight;

  const IntlMobileField({
    super.key,
    this.formFieldKey,
    this.flagsButtonKey,
    this.favorite = const [],
    this.enableFavoriteIcon = true,
    this.favoriteIconIsLeft = true,
    this.favoriteIcon,
    this.countryCodePositionRight = true,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.initialCountryCode,
    this.languageCode = 'en',
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
    this.dropdownTextStyle,
    this.border,
    this.fillColor,
    this.prefixIconConstraints,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
    this.searchText = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autoFocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.disableLengthCounter = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidNumberMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
    this.magnifierConfiguration,
    this.expands = false,
    this.maxLines = 1,
    this.disableFlagTap = false,
    this.onTapOutside,
    this.flagWidth = 32,
  });

  @override
  State<IntlMobileField> createState() => _IntlMobileFieldState();
}

class _IntlMobileFieldState extends State<IntlMobileField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries ?? countries;
    filteredCountries = _countryList
        .where((item) => widget.favorite.any((code) => item.code != code))
        .toList();
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.fullCountryCode),
          orElse: () => _countryList.first);

      // remove country code from the initial number value
      number = number.replaceFirst(
          RegExp("^${_selectedCountry.fullCountryCode}"), "");
    } else {
      _selectedCountry = _countryList.firstWhere(
          (item) => item.code == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);

      // remove country code from the initial number value
      if (number.startsWith('+')) {
        number = number.replaceFirst(
            RegExp("^\\+${_selectedCountry.fullCountryCode}"), "");
      } else {
        number = number.replaceFirst(
            RegExp("^${_selectedCountry.fullCountryCode}"), "");
      }
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialMobileNumber = MobileNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialMobileNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          languageCode: widget.languageCode.toLowerCase(),
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          favorite: widget.favorite,
          favoriteIcon: widget.favoriteIcon,
          favoriteIconIsLeft: widget.favoriteIconIsLeft,
          enableFavoriteIcon: widget.enableFavoriteIcon,
          countryCodePositionRight: widget.countryCodePositionRight,
          searchText: widget.searchText,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formFieldKey,
      initialValue: (widget.controller == null) ? number : null,
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
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
        prefixIcon: _buildFlagsButton(),
        counterText: !widget.enabled ? '' : null,
        border: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        prefixIconConstraints: widget.prefixIconConstraints,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(
          MobileNumber(
            countryISOCode: _selectedCountry.code,
            countryCode:
                '+${_selectedCountry.dialCode}${_selectedCountry.regionCode}',
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        final mobileNumber = MobileNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.fullCountryCode}',
          number: value,
        );

        if (widget.autovalidateMode != AutovalidateMode.disabled) {
          validatorMessage = await widget.validator?.call(mobileNumber);
        }

        widget.onChanged?.call(mobileNumber);
      },
      validator: (value) {
        if (value == null || !isNumeric(value)) {
          return validatorMessage ?? widget.invalidNumberMessage;
        }
        if (!widget.disableLengthCheck) {
          return value.length >= _selectedCountry.minLength &&
                  value.length <= _selectedCountry.maxLength
              ? null
              : widget.invalidNumberMessage;
        }

        return validatorMessage;
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

  Container _buildFlagsButton() {
    return Container(
      key: widget.flagsButtonKey,
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          onTap: widget.disableFlagTap ? null : _changeCountry,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 4,
                ),
                if (widget.disableFlagTap == false)
                  if (widget.enabled &&
                      widget.showDropdownIcon &&
                      widget.dropdownIconPosition == IconPosition.leading) ...[
                    widget.dropdownIcon,
                    const SizedBox(width: 4),
                  ],
                if (widget.disableFlagTap == true) const SizedBox(width: 10),
                if (widget.showCountryFlag) ...[
                  (kIsWeb || Platform.isLinux || Platform.isWindows)
                      ? Image.asset(
                          'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                          package: 'intl_mobile_field',
                          width: widget.flagWidth,
                        )
                      : Text(
                          _selectedCountry.flag,
                          style:
                              TextStyle(fontSize: widget.flagWidth! * 0.5625),
                        ),
                  const SizedBox(width: 8),
                ],
                FittedBox(
                  child: Text(
                    '+${_selectedCountry.dialCode}',
                    style: widget.dropdownTextStyle,
                  ),
                ),
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.dropdownIconPosition == IconPosition.trailing) ...[
                  const SizedBox(width: 4),
                  widget.dropdownIcon,
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}
