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
{
  "breakpoints": [576, 768, 992],
  "themes": [
    {
      "colors": {
        "background": "#FFFFFF",
        "foreground": "#323436",
        "primary": "#991917",
        "secondary": "#E1D5BB"
      },
      "texts": {
        "size": {
          "tiny": [6.0, 16.0, 20.0, 24.0],
          "small": [8.0, 18.0, 24.0, 28.0],
          "medium": [10.0, 22.0, 28.0, 36.0],
          "large": [12.0, 28.0, 36.0, 42.0],
          "huge": [14.0, 34.0, 42.0, 48.0],
          "title": [16.0, 48.0, 56.0, 64.0],
          "biggest": [30.0, 60.0, 72.0, 84.0]
        }
      },
      "shadows": {
        "small": [
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          }
        ],
        "medium": [
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          }
        ],
        "large": [
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          },
          {
            "color": "#33000000",
            "spread": 1.0,
            "offset": [0.0, 0.0],
            "radius": 8.0
          }
        ]
      },
      "border": {
        "radius": {
          "small": [4.0, 6.0, 8.0, 12.0],
          "medium": [8.0, 10.0, 12.0, 16.0],
          "large": [12.0, 14.0, 16.0, 24.0]
        }
      },
      "padding": {
        "small": [4.0, 6.0, 8.0, 12.0],
        "medium": [8.0, 10.0, 12.0, 16.0],
        "large": [12.0, 14.0, 16.0, 24.0]
      }
    },
    {
      "colors": {
        "background": "#FFFFFF",
        "foreground": "#1E1F21",
        "primary": "#661111",
        "secondary": "#FAF4EB"
      },
      "texts": {
        "size": {
          "tiny": [6.0, 16.0, 20.0, 24.0],
          "small": [8.0, 18.0, 24.0, 28.0],
          "medium": [10.0, 22.0, 28.0, 36.0],
          "large": [12.0, 28.0, 36.0, 42.0],
          "huge": [14.0, 34.0, 42.0, 48.0],
          "title": [16.0, 48.0, 56.0, 64.0],
          "biggest": [30.0, 60.0, 72.0, 84.0]
        }
      },
      "shadows": {
        "small": [
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          }
        ],
        "medium": [
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          }
        ],
        "large": [
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          },
          {
            "color": "#000000",
            "spread": 5,
            "offset": [0.0, 0.0],
            "radius": 0.0
          }
        ]
      },
      "border": {
        "radius": {
          "small": [0.0, 0.0, 0.0, 0.0],
          "medium": [0.0, 0.0, 0.0, 0.0],
          "large": [0.0, 0.0, 0.0, 0.0]
        }
      },
      "padding": {
        "small": [4.0, 6.0, 8.0, 12.0],
        "medium": [8.0, 10.0, 12.0, 16.0],
        "large": [12.0, 14.0, 16.0, 24.0]
      }
    }
  ]
}
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