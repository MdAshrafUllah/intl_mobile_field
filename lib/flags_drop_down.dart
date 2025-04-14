import 'package:flutter/material.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/country_picker_dialog.dart';

enum Position { leading, trailing }

class FlagsDropDown extends StatefulWidget {
  final ValueKey? flagsButtonKey;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  /// disable country choses by user
  final bool disableFlagTap;

  /// 2 letter ISO Code or country dial code.
  ///
  /// ```dart
  /// initialCountryCode: 'BD', // Bangladesh
  /// initialCountryCode: '+880', // Bangladesh
  /// ```
  final String? initialCountryCode;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Widget dropdownIcon;
  final Position dropdownIconPosition;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showDialogCountryFlag;
  final BoxDecoration dropdownDecoration;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  /// The width of the country flag.
  final double? flagWidth;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// added favorite countries to the top of the list
  final List<String> favorite;

  /// Use LanguageCode for Localization Country List.
  final String? languageCode;

  /// Enable or disable the Favorite Icon for the Favorite Country Lists.
  final bool? enableFavoriteIcon;

  /// Whether the favorite icon is left or right aligned.
  final Position favoriteIconPosition;

  /// The icon to be displayed when favorite country list is Created.
  final Widget? favoriteIcon;

  /// RLT Support for Localization
  final bool? rltSupport;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The position of the favorite icon in the country picker dialog.
  final Position favoriteCountryCodePosition;

  /// The position of the country code in the country picker dialog.
  final Position dialogCountryCodePosition;

  /// The position of the country code in the flags button.
  final Position fieldCountryCodePosition;

  final ValueChanged<Country>? onCountryChanged;

  /// Disable country code.
  final bool countryCodeDisable;

  /// Disable country flag in TextField.
  final bool showFieldCountryFlag;

  const FlagsDropDown({
    super.key,
    this.flagsButtonKey,
    this.initialCountryCode = 'BD',
    this.favorite = const [],
    this.showDropdownIcon = true,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.dropdownIconPosition = Position.leading,
    this.showDialogCountryFlag = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.flagsButtonPadding = EdgeInsets.zero,
    this.flagsButtonMargin = EdgeInsets.zero,
    this.flagWidth = 32,
    this.dropdownTextStyle,
    this.disableFlagTap = false,
    this.languageCode,
    this.rltSupport,
    this.pickerDialogStyle,
    this.favoriteIcon,
    this.favoriteIconPosition = Position.leading,
    this.enableFavoriteIcon,
    this.fieldCountryCodePosition = Position.trailing,
    this.favoriteCountryCodePosition = Position.leading,
    this.dialogCountryCodePosition = Position.trailing,
    this.onCountryChanged,
    this.countryCodeDisable = false,
    this.showFieldCountryFlag = true,
  });

  @override
  State<FlagsDropDown> createState() => _FlagsDropDownState();
}

class _FlagsDropDownState extends State<FlagsDropDown> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = countries.firstWhere(
      (item) => item.code == widget.initialCountryCode,
      orElse: () => countries.first,
    );
  }

  List<Country> get _filteredFavoriteCountries =>
      countries.where((item) => widget.favorite.contains(item.code)).toList();

  Future<void> _showCountryDialog() async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => CountryPickerDialog(
          showDialogCountryFlag: widget.showDialogCountryFlag,
          disableCountryCode: widget.countryCodeDisable,
          languageCode: widget.languageCode?.toLowerCase() ?? 'en',
          rltSupport: widget.rltSupport ?? true,
          style: widget.pickerDialogStyle,
          filteredFavoriteCountries: _filteredFavoriteCountries,
          favorite: widget.favorite,
          favoriteIcon: widget.favoriteIcon,
          favoriteIconPosition: widget.favoriteIconPosition,
          enableFavoriteIcon: widget.enableFavoriteIcon ?? true,
          favoriteCountryCodePosition: widget.favoriteCountryCodePosition,
          countryCodePosition: widget.dialogCountryCodePosition,
          countryList: countries,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            if (mounted) {
              setState(() {
                _selectedCountry = country;
              });
            }
            widget.onCountryChanged?.call(country);
          }),
    );
  }

  Widget _buildDialCode() {
    if (widget.countryCodeDisable) return const SizedBox();
    return FittedBox(
      child: Text(
        '+${_selectedCountry.dialCode}',
        style: widget.dropdownTextStyle,
      ),
    );
  }

  Widget _buildFlag() {
    if (!widget.showFieldCountryFlag) return const SizedBox();
    return Image.asset(
      'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
      package: 'intl_mobile_field',
      width: widget.flagWidth,
    );
  }

  Widget _buildDropdownIcon(Position position) {
    if (!widget.showDropdownIcon || widget.dropdownIconPosition != position) {
      return const SizedBox();
    }
    return widget.dropdownIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.flagsButtonKey,
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          onTap: widget.disableFlagTap ? null : _showCountryDialog,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 4),
                _buildDropdownIcon(Position.leading),
                if (!widget.countryCodeDisable &&
                    widget.fieldCountryCodePosition == Position.leading) ...[
                  const SizedBox(width: 8),
                  _buildDialCode(),
                  const SizedBox(width: 8),
                ],
                if (widget.disableFlagTap) const SizedBox(width: 10),
                _buildFlag(),
                if (!widget.countryCodeDisable &&
                    widget.fieldCountryCodePosition == Position.trailing) ...[
                  const SizedBox(width: 4),
                  _buildDialCode(),
                ],
                const SizedBox(width: 8),
                _buildDropdownIcon(Position.trailing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
