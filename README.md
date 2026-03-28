# 🍽️ Mummachi's Kitchen — Flutter Food Ordering App

A clean, functional Nigerian restaurant food ordering app built with Flutter.  
Customers can browse the menu, add items to cart, and place orders directly via WhatsApp.

## ✨ Features

- 🍲 Browse a full Nigerian food menu (Swallows, Rice, Soups, Proteins, Drinks)
- 🛒 Add items to cart with quantity controls
- 💰 Real-time cart total calculation
- 🚚 Checkout with delivery address and phone number
- 📱 Order placed directly via WhatsApp to the restaurant
- 📋 Full order history saved locally
- ➕ Admin can add new dishes to the menu
- 🗑️ Delete dishes from the menu
- 💾 Persistent local storage with Hive



## 📸 SCREENSHOTS
![HOME SCREEN] (SCREENSHOT 1.png)
![CART ITEMS SCREEN] (SCREENSHOT 2.png)
![CHECKOUT SCREEN] (SCREENSHOT 3.png)

---

## 🏗️ Architecture

```
lib/
├── main.dart
├── app.dart
├── constants/
│   └── app_theme.dart        # Brand colors, typography, button styles
├── models/
│   ├── food_item.dart        # Hive model for menu items
│   ├── cart_item.dart        # Cart line item model
│   └── order.dart            # Hive model for orders
├── providers/
│   └── cart_provider.dart    # Cart state management (Provider)
├── screens/
│   ├── home_screen.dart      # Menu browsing + category filter
│   ├── add_food_screen.dart  # Add new dish form
│   ├── detail_screen.dart    # Dish detail view
│   ├── cart_screen.dart      # Cart review + quantity controls
│   ├── checkout_screen.dart  # Delivery details + WhatsApp order
│   └── order_history_screen.dart  # Past orders list
├── widgets/
│   ├── food_card.dart        # Menu item card with cart controls
│   ├── category_chip.dart    # Filter chip widget
│   └── cart_badge.dart       # Cart icon with item count badge
└── services/
    ├── hive_service.dart     # Hive init + food item CRUD
    └── order_repository.dart # Order save/load/delete
```

---

## 🛠️ Tech Stack

| Tool         | Purpose                             |
| ------------ | ----------------------------------- |
| Flutter      | UI framework                        |
| Provider     | Cart state management               |
| Hive         | Local storage (menu items + orders) |
| url_launcher | WhatsApp order submission           |
| Google Fonts | Poppins typography                  |
| UUID         | Unique item IDs                     |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio or VS Code
- Android emulator or physical device

### Installation

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/food_menu_app.git

# Navigate into the project
cd food_menu_app

# Install dependencies
flutter pub get

# Generate Hive adapters
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## ⚙️ Configuration

To connect the app to your restaurant's WhatsApp, open  
`lib/screens/checkout_screen.dart` and update this line:

```dart
static const String _restaurantWhatsApp = '+2348000000000';
```

Replace with the restaurant owner's WhatsApp number including country code.

---

## 📦 Dependencies

```yaml
provider: ^6.1.2
hive: ^2.2.3
hive_flutter: ^1.1.0
url_launcher: ^6.3.1
google_fonts: ^6.2.1
uuid: ^4.4.0
```

---

## 👨‍💻 Author

Built with ❤️ by nwankwo michael "the ghost'  
[GitHub](https://github.com/michaelnwankwo)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

```

```
