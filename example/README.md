# Theme Manager for Flutter


### 1. Initialize the Theme

Before using the theme in your widgets, you need to initialize it with a specific theme index (default is `0`). The index corresponds to the theme defined in your `theme.json` file.

```dart
import 'package:flutter/material.dart';
import 'your_theme_package/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Style.init();
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
      ),
      home: HomeScreen(),
    );
  }
}
```

### 2. JSON Configuration File

Create a JSON file named `theme.json` in your `assets` folder. This file will define your themes. Here’s an example:

```json
[
  {
    "colors": {
      "primary": "#6200EA",
      "secondary": "#03DAC6",
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
        "biggest": [32, 34, 36, 38]
      }
    },
    "border": {
      "radius": {
        "small": [4, 6, 8, 10],
        "medium": [8, 10, 12, 14],
        "large": [12, 14, 16, 18]
      }
    },
    "padding": {
      "small": [4, 6, 8, 10],
      "medium": [8, 10, 12, 14],
      "large": [12, 14, 16, 18]
    },
    "shadows": {
      "small": [{
        "color": "#000000",
        "offset": [0, 1],
        "radius": 2,
        "spread": 1
      }],
      "medium": [{
        "color": "#000000",
        "offset": [0, 2],
        "radius": 4,
        "spread": 2
      }],
      "large": [{
        "color": "#000000",
        "offset": [0, 3],
        "radius": 6,
        "spread": 3
      }]
    }
  }
]
```

### 3. Applying Styles in Widgets

You can apply styles in your widgets using the `Style` class. Here are a few examples:

#### Colors

```dart
Container(
  color: Style.colors.primary,
  child: Text("Hello, World!", style: TextStyle(color: Style.colors.foreground)),
);
```

#### Text Sizes

```dart
Text(
  "This is a medium text",
  style: TextStyle(fontSize: Style.texts.medium(context)),
);
```

#### Padding

```dart
Padding(
  padding: Style.paddings.medium(context),
  child: Text("Padded Text"),
);
```

#### Border Radius

```dart
Container(
  decoration: BoxDecoration(
    color: Style.colors.background,
    borderRadius: Style.radius.medium(context),
  ),
  child: Text("Rounded Corners"),
);
```

#### Shadows

```dart
Container(
  decoration: BoxDecoration(
    color: Style.colors.background,
    boxShadow: Style.shadows.medium(context),
  ),
  child: Text("Shadowed Container"),
);
```

#### Buttons

```dart
ElevatedButton(
  style: Style.buttons.primary(),
  onPressed: () {},
  child: Text("Primary Button"),
),
```

### 4. Responsive Design

The theme adjusts automatically based on the device screen width. However, you can explicitly set the index if needed:

```dart
int themeIndex = Style.index(context);
```

- `0`: Mobile
- `1`: Tablet
- `2`: Desktop
- `3`: TV

## Extending and Customizing

You can extend the `Style` class and its components to add more theme elements, such as typography, animations, or custom widget styles. The design is highly modular, allowing for easy modifications and expansions.

## Contributing

Contributions are welcome! If you have suggestions for improving the theme manager, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

With this package, you can efficiently manage and apply complex theme configurations in your Flutter application, ensuring a consistent and responsive UI across all device types. Happy theming!