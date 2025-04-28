## [2.0.2] - Release 🚀

### Fixed

- Resolved an issue where `onCountryChanged` was not being invoked correctly.
- Fixed an issue where `initialCountryCode` was not setting the input length properly on initialization.

## [2.0.1] - Release

#### Newly Added

- New Add translations for **`Portuguese`** languages.

#### Changed

- We have removed the `prefixIcon` from `IntlMobileField`. Now, users have to pass all attributes for `FlagsDropDown` directly in `IntlMobileField`.

#### Improved

- Now the length will not be stuck at 10 digits for all countries.
- Now able to make the field optional.
- Now `initialValue` will change the default country flag.

#### Notes

- The user can still use `FlagsDropDown` separately anywhere.

## [2.0.0] - Release

#### Newly Added

- **`FlagImage` widget** - Easily display any country's flag anywhere in your UI.
- **`FlagsDropDown` widget** - A fully customizable country selector with dialog support.
- Support for **custom validation** - Pass a custom `validator` function with both sync and async validation handling.
- Users can now add `prefixIcon` and `suffixIcon` in `IntlMobileField`.
- `FlagsDropDown` appears in the `prefixIcon` by default for `IntlMobileField`, but can be overridden.

#### Changed

- Updated **phone number length validation** for **Seychelles** to match accurate formatting rules.

#### Improved

- Introduced **debounced async validation** to prevent overlapping validator calls and improve performance.
- Developers can **fully customize or replace** the flag dropdown by injecting their own `FlagsDropDown`.
- Added configuration options to **hide flags, country codes**, or **dropdown icons** both in the field and dialog.

#### Notes

- Flutter's native `validator` is not async, so **async validation is handled internally** via `onChanged`, with a debounce.
- For real-time validation feedback, use the `onChanged` callback and manage UI state accordingly.
- Explore the package for knowing what new in it.

## [1.1.1] - Release

- fixed Readme file image URLs

## [1.1.0] - Release

- **New** Add translations for [Bangla], [Hindi], [Urdu] languages.
- **New** RTL Support for Translations of Right-to-Left Languages
- added Kosovo localization messages
- update [README.md] file with translations listed Country and RLT,LRT Output.
- **New** screenshot(thumbnail) added.

## [1.0.3] - Release

- Update Benin number format 8 to 10

## [1.0.2] - Release

- fixed Readme file

## [1.0.1] - Release

- make compatible for web.

## [1.0.0] - Release

- A Custom mobile Input TextFormField.
- A Basic validator added.
- Added styling of the country selection button.
- Added support for input formatters.
- Added some more necessary parameters available for a normal textfield.
- Initial Value can now be set.
- mobile field now returns ISO County code as well in onSaved, onChanged.
- SearchBar label text can be now set.
- Picker popup bug fixed.
- Color change for Dropdown Icon and Dialog is now added.
- onCountryChanged param added.
- null-safe.
- Update maximum length of mobile numbers of several countries.
- Add dropDownArrowIcon parameter.
- Control autoValidateMode of text input added.
- showCountryFlag param added.
- textAlignVertical param added.
- Icon position feature added.
- Setting enabled to false disable the dropdown button too.
- Update maximum length of mobile numbers of several countries.
- dropDownArrowIcon and dropDownArrowColor parameters are now replaced by dropDownIcon.
- Add asynchronous validation.
- Add minimal country length.
- Update minimum and maximum length of mobile numbers of several countries.
- Support country search by dial code.
- Move flag button to TextFormField's `prefixIcon` (always displayed and get rid of alignment issues).
- Add `dropdownTextStyle`, customize style use for the country dial code.
- Add `disableLengthCheck`, disable view minimum and maximum length check.
- Add a CountryPickerDialog widget and PickerDialogStyle (set of styles to allow the country search dialog customization).
- Add `flagsButtonPadding`, set custom padding around flag button.
- Add `invalidNumberMessage`, te message to be displayed on validation error.
- Add cursor customization options: `cursorColor`, `cursorHeight`, `cursorRadius`, `cursorWidth` and `showCursor`.
- Switch from country List of Maps to List of Country objects.
- `keyboardAppearance` use default `ThemeData.brightness`.
- Rename `dropDownIcon` to `dropdownIcon` and `iconPosition` to `dropdownIconPosition`.
- Remove `autoValidate`.
- Add asynchronous validation.
- `validator` function parameter type is [MobileNumber] now instead of [String].
- Add `width` property to [PickerDialogStyle]
- Add `flagsButtonMargin` property
- Update mobile number length of several countries.
- Add `magnifierConfiguration` to customize the magnifier.
- Add `formFieldKey` for the Mobile input text field key.
- Update Mobile number length of several countries.
- **New** Add shape property of the Dialog.
- **New** Update Madagascar, Brazil, belarus, indonesia Min and Max.
- **New** Add Country Kosovo.
- **New** Correct name translation for some countries.
- **New** Able to style the text inside the search field.
- **New** allowing to pass list of favorite country codes as a list of string.
- **New** put the favorite countries always on the top.
- **New** changed the listView builder to slivers.
- **New** Fixed duplication of countries on the search.
- **New** Hungarian translation added to countries.
- **New** make itself visible by scrolling.
- **New** Enable project example for Linux, Mac and Windows.
- **New** Fix to select png asset for Linux and Windows.
- **New** Enable "expands" and "maxLines" parameters.
- **New** support phone numbers with spaces and dashes in fromCompleteNumber.
- **New** Border added to TextFormField Widget
- **New** Fill Color added.
- **New** Invalid Number Message added in validator on empty Mobile number.
- **New** Disable text field and flag Separately.
- **New** Disable Mobile Length Counter.
- **New** Add an onTapOutside function.
- **New** Control the size of the country flag. min is 32.
- **New** You can add Customizable favorite Icon in favorite country list.
- **New** You can can change the position of the favorite Icon.
