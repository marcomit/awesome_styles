# Custom Theme Manager for Flutter

This package provides a customizable theme management solution for Flutter applications. It enables easy setup and use of dynamic themes with responsive design support, allowing you to manage colors, text styles, paddings, shadows, and more from a single configuration file.

## Features

- **Responsive Design**: Automatically adjusts theme parameters based on device size (Mobile, Tablet, Desktop, TV).
- **Customizable Themes**: Load and apply themes from a JSON configuration file.
- **Text and Color Management**: Easily manage text styles and colors.
- **Button Styles**: Predefined button styles with support for different states and sizes.
- **Shadow and Radius Customization**: Fine-tuned control over component shadows and border radii.

## Getting Started

### 1. Installation

Add the package as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  awesome_styles: ^1.0.0
```

Then, install the package using the command:

```bash
flutter pub get
```

### 2. Configuration

Place your theme configuration file `theme.json` in the `assets` folder of your project.

**Example of `theme.json`:**

```json
[
  {
    "colors": {
      "primary": "#FF5733",
      "secondary": "#C70039",
      "background": "#FFFFFF",
      "foreground": "#000000"
    },
    "texts": {
      "size": {
        "tiny": [12, 14, 16, 18],
        "small": [14, 16, 18, 20],
        "medium": [16, 18, 20, 22],
        "large": [18, 20, 22, 24],
        "huge": [20, 22, 24, 26],
        "title": [24, 26, 28, 30],
        "biggest": [28, 30, 32, 34]
      }
    },
    "border": {
      "radius": {
        "small": [4, 6, 8, 10],
        "medium": [6, 8, 10, 12],
        "large": [8, 10, 12, 14]
      }
    },
    "padding": {
      "small": [4, 6, 8, 10],
      "medium": [6, 8, 10, 12],
      "large": [8, 10, 12, 14]
    },
    "shadows": {
      "small": [
        {
          "color": "#000000",
          "offset": [0, 1],
          "radius": 3,
          "spread": 0
        }
      ],
      "medium": [
        {
          "color": "#000000",
          "offset": [0, 2],
          "radius": 6,
          "spread": 1
        }
      ],
      "large": [
        {
          "color": "#000000",
          "offset": [0, 3],
          "radius": 9,
          "spread": 2
        }
      ]
    }
  }
]
```

### 3. Initialization

Initialize the theme in your `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Style.init();  // Load theme from assets/theme.json
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Style.colors.primary,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: Style.texts.medium(context)),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Style.colors.primary,
        ),
      ),
      home: MyHomePage(),
    );
  }
}
```

### 4. Usage

#### **Accessing Colors and Text Styles:**

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: Style.texts.large(context),
    color: Style.colors.primary,
  ),
);
```

#### **Button Styles:**

```dart
ElevatedButton(
  style: Style.buttons.primary(),
  onPressed: () {},
  child: Text('Primary Button'),
);
```

#### **Responsive Radius and Padding:**

```dart
Container(
  padding: Style.paddings.medium(context),
  decoration: BoxDecoration(
    borderRadius: Style.radius.medium(context),
  ),
  child: Text('Responsive Container'),
);
```

## Documentation

For detailed information on the available options and additional configurations, please refer to the inline comments in the code and the provided example JSON file.

## Examples

You can find a complete example in the `example/` directory of this repository. Run it using:

```bash
flutter run example/lib/main.dart
```

## Contribution

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This package is distributed under the MIT License. See `LICENSE` for more information.