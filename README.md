<br/>
<p align="center">                    
<img  src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/intl_mobile_field.png?raw=true" height="200" width="260" alt="intl_mobile_field logo">                    
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
- [Support the Package](#support-the-package)

## Installing

To use this package:

Run this command:

```yaml
flutter pub add intl_mobile_field
```

Or, add the following to your `pubspec.yaml` file under `dependencies`:

```yaml
intl_mobile_field: ^2.1.7
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

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px" alt="Screenshot 1"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/2.png?raw=true" height="500px" width="250px" alt="Screenshot 2"></td>
  </tr>
</table>

#### Example: 2 (Custom Mobile Field)

```dart
Row(
  spacing: 10,
  children: [
    Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(width: 0.6, color: Colors.black87),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: CountryDropDown(
        countries: countries,
        onCountryChanged: (value) {
          setState(() {
            countryCode = value.dialCode;
          });
        },
      ),
    ),
    Expanded(
      child: TextFormField(
        controller: mobileControllerSeparate,
        decoration: InputDecoration(
          labelText: t('mobileNumber'),
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
        onChanged: (value) {
          log("Mobile: $countryCode$value");
        },
      ),
    ),
  ],
),
```

#### output

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/11.png?raw=true" height="500px" width="250px" alt="Screenshot 11"></td>
  </tr>
</table>

#### Example: 3 (with favorite - style one)

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

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px" alt="Screenshot 1"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/6.png?raw=true" height="500px" width="250px" alt="Screenshot 6"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/5.png?raw=true" height="500px" width="250px" alt="Screenshot 5"></td>
  </tr>
</table>

#### Example: 4 (with favorite - style two)

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

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/1.png?raw=true" height="500px" width="250px" alt="Screenshot 1"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/4.png?raw=true" height="500px" width="250px" alt="Screenshot 4"></td>
  </tr>
</table>

Use `initialCountryCode` to set an initial Country Code.

For `PickerDialogStyle` you have to import.

```dart
import 'package:intl_mobile_field/country_picker_dialog.dart';
```

#### Example 5 (CountryDropDown)

```dart
CountryDropDown(
    countries: countries,
    showFieldCountryFlag:
        true, // default is true, if You want to hide country flag, set it to false
    showDialogCountryFlag:
        false, // default is true, if You want to hide country flag in dialog box, set it to false
    showCountryName:
        false, // default is true. if You want to show country name, set it to false
    onCountryChanged: (country) {
    debugPrint('Country changed to: ${country.name}');
    },
    flagWidth: 150,
)
```

#### Output

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/9.png?raw=true" height="500px" width="250px" alt="Screenshot 9"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/10.png?raw=true" height="500px" width="250px" alt="Screenshot 10"></td>
  </tr>
</table>

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

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/12.png?raw=true" height="500px" width="250px" alt="Screenshot 12"></td>
  </tr>
</table>

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

<table>
  <tr>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/13.png?raw=true" height="500px" width="250px" alt="Screenshot 13"></td>
    <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/14.png?raw=true" height="500px" width="250px" alt="Screenshot 14"></td>
  </tr>
</table>

#### Example 8 (Custom Country List)

By default, all countries are available.

Use the `countries` property to control which countries appear:

**Allow only specific countries (default behavior):**

```dart
IntlMobileField(
  initialCountryCode: "BD",
  decoration: const InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
  ),
  countries: ['BD', 'MY', 'US', 'AE', 'UK', 'NL'], // or ['880', '60', '971']
)
```

**Exclude specific countries:**

```dart
IntlMobileField(
  initialCountryCode: "BD",
  decoration: const InputDecoration(
    labelText: "Mobile Number",
    border: OutlineInputBorder(),
  ),
  countries: ['IL'],
  excludeCountries: true,
)
```

In the second example, all countries will be available **except** Israel (`IL`).

#### Output

<table>
  <thead>
    <tr>
      <th>Dial Code</th>
      <th>Country Code</th>
      <th>Except Country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/15.png?raw=true" height="500px" width="250px" alt="Dial Code Screenshot"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/16.png?raw=true" height="500px" width="250px" alt="Country Code Screenshot"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/20.png?raw=true" height="500px" width="250px" alt="Except Country Screenshot"></td>
    </tr>
  </tbody>
</table>

#### Search By

Control how users can search for countries in the picker dialog.

Use **`searchBy`** to choose the search behavior.

- **`SearchBy.name`** searches by country name only.
- **`SearchBy.dialCode`** searches by country dial code only (for example: `880` or `+880`).
- **`SearchBy.both`** _(default)_ searches by both country name and dial code.

#### Example

```dart
IntlMobileField(
  searchBy: SearchBy.both,
)
```

#### Available Options

<table>
  <thead>
    <tr>
      <th>Value</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>SearchBy.name</code></td>
      <td>Search by country name only.</td>
    </tr>
    <tr>
      <td><code>SearchBy.dialCode</code></td>
      <td>Search by country dial code only.</td>
    </tr>
    <tr>
      <td><code>SearchBy.both</code></td>
      <td>Search by both country name and dial code <em>(default)</em>.</td>
    </tr>
  </tbody>
</table>

#### Output

<table>
  <thead>
    <tr>
      <th align="center">SearchBy.name</th>
      <th align="center">SearchBy.dialCode</th>
      <th align="center">SearchBy.dialCode (without '+')</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/21.png?raw=true" height="500px" width="250px" alt="SearchBy.name Screenshot"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/22.png?raw=true" height="500px" width="250px" alt="SearchBy.dialCode Screenshot"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/23.png?raw=true" height="500px" width="250px" alt="SearchBy.dialCode (without '+') Screenshot"></td>
    </tr>
  </tbody>
</table>

> **Note:** `SearchBy.both` is the default behavior, so you only need to set `searchBy` if you want to restrict the search.

#### RTL Support

If you select **`languageCode`** Arabic, Urdu, Persian, or Cantonese (Chinese), the flag will automatically be on the right, and the country code will automatically be on the left. You can also turn off RLT Support by adding **`rltSupport: false`**.

#### output

<table>
  <thead>
    <tr>
      <th><strong>LRT Languages</strong></th>
      <th><strong>RLT Language</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/8.png?raw=true" height="500px" width="250px" alt="LRT Languages Screenshot 1"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/7.png?raw=true" height="500px" width="250px" alt="RLT Language Screenshot 1"></td>
    </tr>
    <tr>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/17.png?raw=true" height="500px" width="250px" alt="LRT Languages Screenshot 2"></td>
      <td><img src="https://github.com/MdAshrafUllah/intl_mobile_field/blob/master/output/18.png?raw=true" height="500px" width="250px" alt="RLT Language Screenshot 2"></td>
    </tr>
  </tbody>
</table>

## Supported Languages

#### We support more than 26 languages, including:

<table>
  <thead>
    <tr>
      <th><strong>No</strong></th>
      <th><strong>Code</strong></th>
      <th><strong>Language</strong></th>
      <th><strong>No</strong></th>
      <th><strong>Code</strong></th>
      <th><strong>Language</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>01</td><td><strong>hu</strong></td><td>Hungarian</td>
      <td>15</td><td><strong>ar</strong></td><td>Arabic</td>
    </tr>
    <tr>
      <td>02</td><td><strong>sk</strong></td><td>Slovak</td>
      <td>16</td><td><strong>fa</strong></td><td>Persian</td>
    </tr>
    <tr>
      <td>03</td><td><strong>se</strong></td><td>Swedish</td>
      <td>17</td><td><strong>yue</strong></td><td>Cantonese (Chinese)</td>
    </tr>
    <tr>
      <td>04</td><td><strong>pl</strong></td><td>Polish</td>
      <td>18</td><td><strong>bd</strong></td><td>Bangla (Bangladesh)</td>
    </tr>
    <tr>
      <td>05</td><td><strong>no</strong></td><td>Norwegian</td>
      <td>19</td><td><strong>in</strong></td><td>Hindi (India)</td>
    </tr>
    <tr>
      <td>06</td><td><strong>ja</strong></td><td>Japanese</td>
      <td>20</td><td><strong>ur</strong></td><td>Urdu (Pakistan)</td>
    </tr>
    <tr>
      <td>07</td><td><strong>it</strong></td><td>Italian</td>
      <td>21</td><td><strong>pt_br</strong></td><td>Brazilian Portuguese</td>
    </tr>
    <tr>
      <td>08</td><td><strong>zh</strong></td><td>Simplified Chinese</td>
      <td>22</td><td><strong>sr_cyrl</strong></td><td>Serbian (Cyrillic)</td>
    </tr>
    <tr>
      <td>09</td><td><strong>nl</strong></td><td>Dutch</td>
      <td>23</td><td><strong>sr_latn</strong></td><td>Serbian (Latin)</td>
    </tr>
    <tr>
      <td>10</td><td><strong>de</strong></td><td>German</td>
      <td>24</td><td><strong>zh_tw</strong></td><td>Traditional Chinese</td>
    </tr>
    <tr>
      <td>11</td><td><strong>fr</strong></td><td>French</td>
      <td>25</td><td><strong>tr</strong></td><td>Turkish</td>
    </tr>
    <tr>
      <td>12</td><td><strong>es</strong></td><td>Spanish</td>
      <td>26</td><td><strong>ro</strong></td><td>Romanian</td>
    </tr>
    <tr>
      <td>13</td><td><strong>en</strong></td><td>English</td>
      <td>27</td><td><strong>pt</strong></td><td>Portuguese</td>
    </tr>
    <tr>
      <td>14</td><td><strong>vi</strong></td><td>Vietnamese</td>
      <td></td><td></td><td></td>
    </tr>
  </tbody>
</table>

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

## Support the Package

If you find this package helpful, please consider sharing it with your friends, teammates, or the Flutter community.

Your support helps the package reach more developers and motivates me to keep improving it.

Thank you for your love and support! 💙
