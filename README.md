# Very Good Coffee App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

A Very Good app to show you very good coffee pictures

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Very Good Coffee App works on iOS and Android._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Github actions ⚙️

Initially, this project used `VeryGoodOpenSource/very_good_workflows/.github/workflows/flutter_package.yml@v1` as a github action,
but I kept encountering problems with the unit tests of GetIt while running them with the action. So, as a temporary measure I changed it to use `subosito/flutter-action@v2`.

---

## Architecture 📐

This app uses the layered architecture from Very Good CLI by default.<br> In order to develop the functions needed for the app
I decided to incorporate the clean-architecture in each feature project.
The folder structure follows the example:
```
├── lib
│   ├── {feature}
│   │   ├── data
│   │   │   ├── datasources
│   │   │   └── repositories
│   │   ├── domain
│   │   │   ├── entities
│   │   │   ├── repositories
│   │   │   └── usecases
│   │   └── presentation
│   │   │   ├── bloc
│   │   │   ├── view
│   │   │   └── {feature}.dart
```

---

## Using the app 📱
1. To generate a coffee image all you have to do is open the app. <br>
2. If this image is not a very good coffee image, you can tap the  `Try new image` button and a new one will be generated <br>
3. If this is a very good coffee image, you can tap the `Add to favorites` button and it will be saved on the favorites page. <br>
4. To see all your favorites coffee images, you can tap the `Go to favorites` button and a gallery like page will show you all the very good coffee images you saved.

|Home page|Favorites page|
|---|---|
|<img width="436" alt="Captura de Tela 2023-02-16 às 23 55 47" src="https://user-images.githubusercontent.com/45688582/219538251-2169805a-d548-4c5d-a079-6d28de92fbaf.png">|<img width="438" alt="Captura de Tela 2023-02-16 às 23 55 34" src="https://user-images.githubusercontent.com/45688582/219538301-d7de081f-887d-4a3b-bf0c-290752d401ba.png">|

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:very_good_coffee_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Already supported languages 📖

The strings used in this app are available both in English and Spanish.

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
