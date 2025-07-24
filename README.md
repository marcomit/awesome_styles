# Flutter Style Package

A comprehensive theming system for Flutter applications that provides responsive design capabilities and customizable styling across different device types.

## Features

- **Responsive Design**: Automatic adaptation to different screen sizes (Mobile, Tablet, Desktop, TV)
- **JSON-based Configuration**: Define themes using external JSON files
- **Multiple Theme Support**: Switch between different themes at runtime
- **Comprehensive Styling**: Colors, typography, spacing, shadows, and button styles
- **Extension Methods**: Convenient extensions for Text, ButtonStyle, and Color classes
- **Breakpoint System**: Built-in responsive breakpoints for different device types

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Add your package name here
```

## Quick Start

### 1. Create a Theme JSON File

Create a `theme.json` file in your `assets` folder:

```json
{
  "breakpoints": [576, 768, 992],
  "themes": [
    {
      "colors": {
        "primary": "#3498db",
        "secondary": "#2c3e50",
        "background": "#ffffff",
        "foreground": "#000000",
        "info": "#17a2b8",
        "success": "#28a745",
        "warning": "#ffc107",
        "danger": "#dc3545"
      },
      "texts": {
        "size": {
          "tiny": [10, 12, 14, 16],
          "small": [12, 14, 16, 18],
          "medium": [14, 16, 18, 20],
          "large": [16, 18, 20, 22],
          "huge": [18, 20, 22, 24],
          "title": [20, 22, 24, 26],
          "biggest": [24, 26, 28, 30]
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
        "small": [8, 10, 12, 14],
        "medium": [12, 14, 16, 18],
        "large": [16, 18, 20, 22]
      },
      "shadows": {
        "small": [
          {
            "color": "#00000025",
            "offset": [0, 2],
            "radius": 4,
            "spread": 0
          }
        ],
        "medium": [
          {
            "color": "#00000035",
            "offset": [0, 4],
            "radius": 8,
            "spread": 0
          }
        ],
        "large": [
          {
            "color": "#00000045",
            "offset": [0, 8],
            "radius": 16,
            "spread": 0
          }
        ]
      }
    }
  ]
}
```

### 2. Initialize the Style System

```dart
import 'package:flutter/material.dart';
// Import your style package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the style system
  await Style.init('assets/theme.json', 0); // 0 is the theme index
  
  runApp(MyApp());
}
```

### 3. Use the Style System

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Style.paddings.medium(context),
      decoration: BoxDecoration(
        color: Style.colors.background,
        borderRadius: Style.radius.medium(context),
        boxShadow: Style.shadows.medium(context),
      ),
      child: Column(
        children: [
          "Hello World".title(context).primary.bold,
          "Subtitle text".medium(context).secondary,
          ElevatedButton(
            style: Style.buttons.primary().medium(context),
            onPressed: () {},
            child: Text("Click me"),
          ),
        ],
      ),
    );
  }
}
```

## API Reference

### Style Class

Main class that provides access to all theming components.

#### Static Properties

- `Style.colors` - Access to color theme
- `Style.texts` - Access to text sizing
- `Style.fonts` - Access to font families
- `Style.radius` - Access to border radius values
- `Style.paddings` - Access to padding values
- `Style.shadows` - Access to shadow configurations
- `Style.buttons` - Access to button styles

#### Static Methods

- `Style.init(String path, [int index])` - Initialize theme from JSON file
- `Style.change(int index)` - Switch to different theme
- `Style.index(BuildContext context)` - Get current device breakpoint index
- `Style.getValue<T>(List<T> values, BuildContext context)` - Get responsive value

### Colors

Access theme colors:

```dart
Style.colors.primary      // Primary color
Style.colors.secondary    // Secondary color
Style.colors.background   // Background color
Style.colors.foreground   // Foreground color
Style.colors.info         // Info color
Style.colors.success      // Success color
Style.colors.warning      // Warning color
Style.colors.danger       // Danger color
```

### Typography

Get responsive text sizes:

```dart
Style.texts.tiny(context)     // Smallest text size
Style.texts.small(context)    // Small text size
Style.texts.medium(context)   // Medium text size
Style.texts.large(context)    // Large text size
Style.texts.huge(context)     // Huge text size
Style.texts.title(context)    // Title text size
Style.texts.biggest(context)  // Biggest text size
```

### Fonts

Access font families:

```dart
Style.fonts.light     // Light font weight
Style.fonts.bold      // Bold font weight
Style.fonts.ultra     // Ultra bold font weight
Style.fonts.cursive   // Cursive font family
```

### Spacing

Get responsive padding:

```dart
Style.paddings.small(context)   // Small padding
Style.paddings.medium(context)  // Medium padding
Style.paddings.large(context)   // Large padding
```

### Border Radius

Get responsive border radius:

```dart
Style.radius.small(context)   // Small border radius
Style.radius.medium(context)  // Medium border radius
Style.radius.large(context)   // Large border radius
```

### Shadows

Get responsive shadows:

```dart
Style.shadows.small(context)   // Small shadow
Style.shadows.medium(context)  // Medium shadow
Style.shadows.large(context)   // Large shadow
```

## Extension Methods

### String Extensions

Convert strings to styled Text widgets:

```dart
"Hello".txt                    // Basic Text widget
"Hello".bold                   // Bold text
"Hello".light                  // Light text
"Hello".primary                // Primary color text
"Hello".small(context)         // Small sized text
```

### Text Extensions

Chain styling methods on Text widgets:

```dart
Text("Hello")
  .bold
  .primary
  .medium(context)
```

### ButtonStyle Extensions

Create styled buttons:

```dart
ElevatedButton(
  style: Style.buttons
    .primary()              // Primary color button
    .medium(context),       // Medium size
  child: Text("Button"),
  onPressed: () {},
)

// Available button styles:
.primary()      // Primary colored button
.secondary()    // Secondary colored button
.info()         // Info colored button
.success()      // Success colored button
.warning()      // Warning colored button
.danger()       // Danger colored button
.outline()      // Outline button
.disabled()     // Disabled button

// Available button sizes:
.small(context)   // Small button
.medium(context)  // Medium button
.large(context)   // Large button
```

### Color Extensions

Manipulate colors:

```dart
Color myColor = Style.colors.primary;
Color darker = myColor.darken(0.2);    // Darken by 20%
Color lighter = myColor.lighten(0.3);  // Lighten by 30%
```

## Responsive Breakpoints

The system uses four breakpoints by default:

- **Mobile**: < 576px (index 0)
- **Tablet**: 576px - 767px (index 1)
- **Desktop**: 768px - 991px (index 2)
- **TV**: ≥ 992px (index 3)

You can customize these breakpoints in your theme JSON file.

## Multiple Themes

Support multiple themes by defining them in your JSON:

```dart
// Switch to theme at index 1
Style.change(1);
```

## Examples

### Creating a Card Component

```dart
Widget buildCard(BuildContext context) {
  return Container(
    padding: Style.paddings.large(context),
    decoration: BoxDecoration(
      color: Style.colors.background,
      borderRadius: Style.radius.medium(context),
      boxShadow: Style.shadows.large(context),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Card Title".title(context).primary.bold,
        SizedBox(height: 8),
        "This is the card content that adapts to different screen sizes."
            .medium(context)
            .foreground,
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: Style.buttons.primary().small(context),
              onPressed: () {},
              child: Text("Action"),
            ),
            ElevatedButton(
              style: Style.buttons.outline().small(context),
              onPressed: () {},
              child: Text("Cancel"),
            ),
          ],
        ),
      ],
    ),
  );
}
```

### Responsive Layout

```dart
Widget responsiveWidget(BuildContext context) {
  final deviceIndex = Style.index(context);
  
  return Container(
    padding: Style.paddings.medium(context),
    child: deviceIndex < 2 
      ? Column(children: widgets)  // Mobile/Tablet: vertical layout
      : Row(children: widgets),    // Desktop/TV: horizontal layout
  );
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
