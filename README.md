# International Mobile Number Field Package

[![pub package](https://img.shields.io/pub/v/intl_mobile_field.svg)]() [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/MIT)

A customized Flutter TextFormField to input international Mobile number along with country code.

This Package is inspired from `intl_phone_field`. But you know that this package is now not maintain by the owner from middle of 2023. So, I decided to make this package update with more functionalities and make it more flexible and compatible. if you want to know what is updated in the package, please check out the [CHANGELOG.md](CHANGELOG.md) file.

## Installing

To use this package:

Run this command:

```yaml
flutter pub add intl_mobile_field
```

Or, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  intl_mobile_field: ^<latest_version>
```

Sometimes you may want to use the latest version of the package, instead of a published version. To do that, use the `git` syntax:

```yaml
dependencies:
  intl_mobile_field:
    git:
      url: https://github.com/MdAshrafUllah/intl_mobile_field.git
      ref: master
```

## How to Use

Simply create a `IntlMobileField` widget, and pass the required params:

#### Example: 1 (without favorite)

```dart
IntlMobileField(
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  initialCountryCode: 'BD',
  disableLengthCounter: true,
  languageCode: "en",
),
```

#### output

<img src="output\1.png" height="500px"> <img src="output\2.png" height="500px">

#### Example: 2 (with favorite - style one)

```dart
IntlMobileField(
  favorite: const ['BD', 'US', 'MY'],
  favoriteIcon: Icon(
    Icons.star,
    color: Colors.amber,
  ),
  favoriteIconIsLeft: false,
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  initialCountryCode: 'BD',
  disableLengthCounter: true,
  languageCode: "en",
  onChanged: (mobile) {
    log(mobile.completeNumber);
  },
  onCountryChanged: (country) {
    log('Country changed to: ${country.name}');
  },
),
```

#### output

<img src="output\1.png" height="500px"> <img src="output\6.png" height="500px"> <img src="output\5.png" height="500px">

#### Example: 3 (with favorite - style two)

```dart
IntlMobileField(
  favorite: const ['BD', 'US', 'MY'],
  favoriteIcon: Icon(
    Icons.favorite,
    color: Colors.pinkAccent,
  ),
  countryCodePositionRight: false,
  favoriteIconIsLeft: false,
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  pickerDialogStyle: PickerDialogStyle(
      countryCodeStyle:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  initialCountryCode: 'BD',
  disableLengthCounter: true,
  languageCode: "en",
),
```

#### output

<img src="output\1.png" height="500px"> <img src="output\4.png" height="500px">

Use `initialCountryCode` to set an initial Country Code.

For `PickerDialogStyle` you have to import it from `import 'package:intl_mobile_field/country_picker_dialog.dart';`.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

Comment on Issue or Pull Request.

## Maintainers

- [Md Ashraf Ullah](https://github.com/MdAshrafUllah/)

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->


<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## LICENSE

This project is licensed under the MIT license. See [LICENSE](LICENSE) for more information.
