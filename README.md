<br/>
<p align="center">                    
<img  src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/intl_mobile_field.png?raw=true" height="200" alt="intl_mobile_field logo">                    
</p>

<p align="center">                    
<a href="https://img.shields.io/badge/License-MIT-blue.svg"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"></a>                    
<a href="https://pub.dev/packages/intl_mobile_field"><img src="https://img.shields.io/pub/v/intl_mobile_field.svg" alt="pub version"></a>                    
</p>

---

A customized Flutter TextFormField to input an international Mobile number along with the country code.

`intl_mobile_field` is a powerful and flexible Flutter package designed to handle international phone number input easily. It offers advanced features, improved compatibility, and enhanced customization options to meet modern development needs. Visit the [Changelog](https://pub.dev/packages/intl_mobile_field/changelog) to stay updated on the latest additions and improvements.

- [Installing](#installing)
- [How to Use](#how-to-use)
- [Supported Languages](#supported-languages)
- [Contributing](#contributing)
- [Maintainers](#maintainers)
- [LICENSE](#license)

## Installing

To use this package:

Run this command:

```yaml
flutter pub add intl_mobile_field
```

Or, add the following to your `pubspec.yaml` file under `dependencies`:

```yaml
intl_mobile_field: ^2.1.4
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

import the url

```dart
import 'package:intl_mobile_field/intl_mobile_field.dart';
```

For `FlagsDropDown` you have to import.

```dart
import 'package:intl_mobile_field/flags_drop_down.dart';
```

Simply create a `IntlMobileField` widget, and pass the required params:

#### Example: 1 (without favorite)

```dart
IntlMobileField(
  initialCountryCode: 'BD', // initial Country is Bangladesh
  languageCode: "en", // initial language is English
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  disableLengthCounter: true,
),
```

#### output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/2.png?raw=true" height="500px" width="250px">

#### Example: 2 (with favorite - style one)

```dart
IntlMobileField(
  favorite: const ['BD', 'US', 'MY'],
  favoriteIcon: Icon(
    Icons.star,
    color: Colors.amber,
  ),
  favoriteIconPosition: Position.trailing,
  favoriteCountryCodePosition: Position.trailing,
  initialCountryCode: 'BD',
  languageCode: "en", // default is 'en'
  onCountryChanged: (country) {
    log('Country changed to: ${country.name}');
  },
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  disableLengthCounter: true,
  onChanged: (mobile) {
    log(mobile.completeNumber);
  },
),
```

#### output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/6.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/5.png?raw=true" height="500px" width="250px">

#### Example: 3 (with favorite - style two)

```dart
IntlMobileField(
  favorite: const ['BD', 'US', 'MY'],
  favoriteIcon: Icon(
    Icons.favorite,
    color: Colors.pinkAccent,
  ),
  favoriteIconPosition: Position.trailing,
  initialCountryCode: 'BD',
  languageCode: "en", // default is 'en'
  onCountryChanged: (country) {
    log('Country changed to: ${country.name}');
  },
  decoration: const InputDecoration(
    labelText: 'Mobile Number',
    border: OutlineInputBorder(
      borderSide: BorderSide(),
    ),
  ),
  disableLengthCounter: true,
  onChanged: (mobile) {
    log(mobile.completeNumber);
  },
),
```

#### output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/4.png?raw=true" height="500px" width="250px">

Use `initialCountryCode` to set an initial Country Code.

For `PickerDialogStyle` you have to import.

```dart
import 'package:intl_mobile_field/country_picker_dialog.dart';
```

#### Example 4 (FlagDropDown)

```dart
FlagsDropDown(
  countryCodeDisable: true,
  onCountryChanged: (country) {
    debugPrint('Country changed to: ${country.name}');
  },
  flagWidth: 150,
),
```

#### Output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/9.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/10.png?raw=true" height="500px" width="250px">

#### Example 5 (FlagImage)

```dart
FlagImage(
  countryCode: 'BD',
  width: 150,
  height: 150,
),
```

#### Output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/11.png?raw=true" height="500px" width="250px">

#### Example 6 (Validation Message)

When you want to show a invalid Number message you can pass it through `invalidNumberMessage`

```dart
IntlMobileField(
  decoration: InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
  ),
  invalidNumberMessage: "Enter a Valid Number",
),
```

#### Output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/12.png?raw=true" height="500px" width="250px">

#### Example 7 (Custom Validation)

you can add your own validation message.

```dart
IntlMobileField(
  initialCountryCode: "BD",
  decoration: InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
  ),
  invalidNumberMessage:
      "Enter a Valid Number", // fallback error message
  validator: (mobileNumber) {
    if (mobileNumber == null || mobileNumber.number.isEmpty) {
      return 'Please enter a mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber.number)) {
      return 'Only digits are allowed';
    }
    return null;
  },
),
```

#### Output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/13.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/14.png?raw=true" height="500px" width="250px">

#### Example 8 (Custom Country List)

You can limit the country List. Otherwise, it shows all countries by default.

```dart
IntlMobileField(
  initialCountryCode: "BD",
  decoration: InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
  ),
  countries: ['BD', 'MY', 'US', 'AE', 'UK', 'NL'], // ['880', '60', '971'],
),
```

#### Output

<img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/15.png?raw=true" height="500px" width="250px"> <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/16.png?raw=true" height="500px" width="250px">

#### RTL Support

If you select **`languageCode`** Arabic, Urdu, Persian, or Cantonese (Chinese), the flag will automatically be on the right, and the country code will automatically be on the left. You can also turn off RLT Support by adding **`rltSupport: false`**.

#### output

| **LRT Languages**                                                                                                             | **RLT Language**                                                                                                              |
| ----------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/8.png?raw=true" height="500px" width="250px"> | <img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/7.png?raw=true" height="500px" width="250px"> |

## Supported Languages

#### We support more than 26 languages, including:

| **No** | **Code** | **Language**       | **No** | **Code**    | **Language**         |
| ------ | -------- | ------------------ | ------ | ----------- | -------------------- |
| 01     | **hu**   | Hungarian          | 15     | **ar**      | Arabic               |
| 02     | **sk**   | Slovak             | 16     | **fa**      | Persian              |
| 03     | **se**   | Swedish            | 17     | **yue**     | Cantonese (Chinese)  |
| 04     | **pl**   | Polish             | 18     | **bd**      | Bangla (Bangladesh)  |
| 05     | **no**   | Norwegian          | 19     | **in**      | Hindi (India)        |
| 06     | **ja**   | Japanese           | 20     | **ur**      | Urdu (Pakistan)      |
| 07     | **it**   | Italian            | 21     | **pt_br**   | Brazilian Portuguese |
| 08     | **zh**   | Simplified Chinese | 22     | **sr_cyrl** | Serbian (Cyrillic)   |
| 09     | **nl**   | Dutch              | 23     | **sr_latn** | Serbian (Latin)      |
| 10     | **de**   | German             | 24     | **zh_tw**   | Traditional Chinese  |
| 11     | **fr**   | French             | 25     | **tr**      | Turkish              |
| 12     | **es**   | Spanish            | 26     | **ro**      | Romanian             |
| 13     | **en**   | English            | 27     | **pt**      | Portuguese           |
| 14     | **vi**   | Vietnamese         |        |             |                      |

Enjoy multilingual support with easy-to-read formatting!

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
