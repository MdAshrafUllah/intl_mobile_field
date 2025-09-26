import 'package:flutter/material.dart';
import 'package:intl_mobile_field/countries.dart';
import 'package:intl_mobile_field/helpers.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final TextStyle? searchFieldTextStyle;

  final double? width;

  final ShapeBorder? shape;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.searchFieldTextStyle,
    this.width,
    this.shape,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final List<Country> filteredFavoriteCountries;
  final List<String> favorite;
  final PickerDialogStyle? style;
  final String languageCode;
  final bool enableFavoriteIcon;
  final Position favoriteIconPosition;
  final Position favoriteCountryCodePosition;
  final Position countryCodePosition;
  final Widget? favoriteIcon;
  final bool rltSupport;
  final bool disableCountryCode;
  final bool showDialogCountryFlag;
  final double? countryPickerDialogBoxHeight;

  const CountryPickerDialog({
    super.key,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredFavoriteCountries,
    required this.disableCountryCode,
    required this.favoriteCountryCodePosition,
    required this.countryCodePosition,
    required this.favoriteIconPosition,
    required this.showDialogCountryFlag,
    this.enableFavoriteIcon = true,
    this.rltSupport = true,
    this.languageCode = 'en',
    this.favorite = const [],
    this.style,
    this.favoriteIcon,
    this.countryPickerDialogBoxHeight,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;
  late List<Country> _filteredFavoriteCountries;
  late List<Country> _favoriteCountries;
  bool rltLanguages = false;

  @override
  void initState() {
    checkRLTorLRT(widget.languageCode);
    _selectedCountry = widget.selectedCountry;

    // Step 1: Extract favorite countries from full countryList
    _favoriteCountries = getCountriesByCountriesCode(
      widget.favorite,
      widget.countryList,
    );

    // Step 2: Set filteredFavoriteCountries
    _filteredFavoriteCountries = _favoriteCountries;

    // Step 3: Set full list, EXCLUDING favorites
    _filteredCountries = widget.countryList
        .where((c) => !_favoriteCountries.contains(c))
        .toList()
      ..sort((a, b) => a
          .localizedName(widget.languageCode)
          .compareTo(b.localizedName(widget.languageCode)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      backgroundColor: widget.style?.backgroundColor,
      shape: widget.style?.shape,
      child: Container(
        height: widget.countryPickerDialogBoxHeight ??
            MediaQuery.of(context).size.height * 0.9,
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                style: widget.style?.searchFieldTextStyle,
                decoration: widget.style?.searchFieldInputDecoration ??
                    const InputDecoration(
                        hintText: 'Search Country',
                        suffixIcon: Icon(Icons.search)),
                onChanged: (value) {
                  search(value);
                  if (mounted) setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  if (_filteredFavoriteCountries.isNotEmpty) ...[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Country item =
                              _filteredFavoriteCountries[index];
                          return _buildCountryPickerItem(
                            item: item,
                            isFavorite: true,
                            enableFavoriteIcon: widget.enableFavoriteIcon,
                            favoriteIconPosition: widget.favoriteIconPosition,
                            favoriteIcon: widget.favoriteIcon,
                            favoriteCountryCodePosition:
                                widget.favoriteCountryCodePosition,
                            disableCountryCode: widget.disableCountryCode,
                            showDialogCountryFlag: widget.showDialogCountryFlag,
                          );
                        },
                        childCount: _filteredFavoriteCountries.length,
                      ),
                    ),
                  ],
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final Country item = _filteredCountries[index];
                        return _buildCountryPickerItem(
                          item: item,
                          isFavorite: false,
                          countryCodePosition: widget.countryCodePosition,
                          disableCountryCode: widget.disableCountryCode,
                          showDialogCountryFlag: widget.showDialogCountryFlag,
                        );
                      },
                      childCount: _filteredCountries.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search(String value) {
    final query = value.toLowerCase();

    _filteredCountries = widget.countryList
        .where((item) =>
            !widget.favorite.contains(item.code) &&
            item
                .localizedName(widget.languageCode)
                .toLowerCase()
                .contains(query))
        .toList()
      ..sort(
        (a, b) => a
            .localizedName(widget.languageCode)
            .compareTo(b.localizedName(widget.languageCode)),
      );

    _filteredFavoriteCountries = _favoriteCountries
        .where((item) => item
            .localizedName(widget.languageCode)
            .toLowerCase()
            .contains(query))
        .toList();
  }

  Widget _buildCountryPickerItem({
    required Country item,
    required bool disableCountryCode,
    required bool showDialogCountryFlag,
    required bool isFavorite,
    Position? favoriteCountryCodePosition,
    Position? countryCodePosition,
    Position? favoriteIconPosition,
    bool enableFavoriteIcon = true,
    Widget? favoriteIcon,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: rltLanguages && widget.rltSupport
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((isFavorite &&
                            (favoriteCountryCodePosition == Position.leading) &&
                            !disableCountryCode) ||
                        (!isFavorite &&
                            (countryCodePosition == Position.leading) &&
                            !disableCountryCode))
                      Text(
                        '+${item.dialCode}',
                        style: widget.style?.countryCodeStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    if (enableFavoriteIcon &&
                        (favoriteIconPosition == Position.trailing) &&
                        favoriteIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: favoriteIcon,
                      ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (enableFavoriteIcon &&
                        (favoriteIconPosition == Position.leading) &&
                        favoriteIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: favoriteIcon,
                      ),
                    if ((isFavorite &&
                            (favoriteCountryCodePosition == Position.leading) &&
                            !disableCountryCode) ||
                        (!isFavorite &&
                            (countryCodePosition == Position.leading) &&
                            !disableCountryCode))
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          '+${item.dialCode}',
                          style: widget.style?.countryCodeStyle ??
                              const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    if (showDialogCountryFlag)
                      Image.asset(
                        'assets/flags/${item.code.toLowerCase()}.png',
                        package: 'intl_mobile_field',
                        width: 32,
                      ),
                  ],
                ),
          contentPadding: widget.style?.listTilePadding,
          title: Text(
            item.localizedName(widget.languageCode),
            style: widget.style?.countryNameStyle ??
                const TextStyle(fontWeight: FontWeight.w700),
            textAlign: rltLanguages && widget.rltSupport
                ? TextAlign.right
                : TextAlign.left,
          ),
          trailing: rltLanguages && widget.rltSupport
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showDialogCountryFlag)
                      Image.asset(
                        'assets/flags/${item.code.toLowerCase()}.png',
                        package: 'intl_mobile_field',
                        width: 32,
                      ),
                    const SizedBox(width: 5),
                    if (enableFavoriteIcon &&
                        (favoriteIconPosition == Position.leading) &&
                        favoriteIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: favoriteIcon,
                      ),
                    if ((isFavorite &&
                            (favoriteCountryCodePosition ==
                                Position.trailing) &&
                            !disableCountryCode) ||
                        (!isFavorite &&
                            (countryCodePosition == Position.trailing) &&
                            !disableCountryCode))
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          '+${item.dialCode}',
                          style: widget.style?.countryCodeStyle ??
                              const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((isFavorite &&
                            (favoriteCountryCodePosition ==
                                Position.trailing) &&
                            !disableCountryCode) ||
                        (!isFavorite &&
                            (countryCodePosition == Position.trailing) &&
                            !disableCountryCode))
                      Text(
                        '+${item.dialCode}',
                        style: widget.style?.countryCodeStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    if (enableFavoriteIcon &&
                        (favoriteIconPosition == Position.trailing) &&
                        favoriteIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: favoriteIcon,
                      ),
                  ],
                ),
          onTap: () {
            _selectedCountry = item;
            widget.onCountryChanged(_selectedCountry);
            Navigator.of(context).pop();
          },
        ),
        widget.style?.listTileDivider ?? const Divider(thickness: 1),
      ],
    );
  }

  bool checkRLTorLRT(String languageCode) {
    List<String> rltLanguagesList = ["ar", "fa", "yue", "ur"];
    return rltLanguages = rltLanguagesList.contains(languageCode);
  }
}
