# Flutter E-Commerce Pro 🛒

A feature-rich, high-performance E-commerce mobile application built with **Flutter**. This project demonstrates a production-grade architecture for handling dynamic product catalogs, real-time cart management, and seamless user authentication.

---

## ✨ Key Features

* **Dynamic Product Catalog:** Fetches real-time product data, including categories, ratings, and stock levels via the **DummyJSON API**.
* **Advanced Search & Filtering:** Instant product discovery with optimized filtering logic for a smooth user experience.
* **Persistent Shopping Cart:** A real-time cart system that calculates totals dynamically and persists data locally.
* **User Authentication:** Secure login and profile management flow.
* **Simulated Checkout:** A clean, multi-step checkout process with a simulated payment gateway.

## 🛠 Tech Stack

* **Framework:** [Flutter](https://flutter.dev) (Dart)
* **State Management:** [Cubit / Bloc](https://pub.dev/packages/flutter_bloc) - Implemented to ensure a reactive UI and clear separation of business logic.
* **Networking:** [Dio](https://pub.dev/packages/dio) - High-level HTTP client used for fetching data from the **DummyJSON API**.
* **Local Storage:** [Hive](https://pub.dev/packages/hive) - Utilized for lightning-fast NoSQL local persistence (Cart data and User sessions).
* **Image Caching:** `cached_network_image` to optimize performance and reduce data usage.

## 📂 Project Structure

```text
lib/
├── core/            # API endpoints, theme constants, and network interceptors.
├── data/            # Models (Product, Cart, User) and Data Providers.
├── logic/           # Cubits for Auth, Products, and Cart management.
├── presentation/    # Screens (Home, Details, Cart, Checkout) and reusable Widgets.
└── main.dart        # Dependency injection and app initialization.

🚀 Getting Started
1-🚀 Getting Started
git clone [https://github.com/your-username/ecommerce-app.git](https://github.com/your-username/ecommerce-app.git)
2-Install dependencies:
flutter pub get
3-Run Code Generation (if using Hive/JsonSerializable):
dart run build_runner build --delete-conflicting-outputs
4-Run the application:
flutter run

🧩 Challenges & Engineering Solutions
State Consistency: Synchronized the local Hive storage with the Cubit state to ensure the shopping cart remains intact even after the app is closed.
API Optimization: Managed complex JSON structures from the DummyJSON API by building robust data models with null-safety to prevent runtime errors.
UI Performance: Optimized the main product grid using Sliver widgets to maintain a smooth 60fps scrolling experience during heavy image loading.
![Recording_20260317_164336 00_03_12--00_03_16](https://github.com/user-attachments/assets/570d8f40-80d4-4899-b586-fe0199f004d1)

🎥 App Demo
<p align="center">
<img src="https://github.com/user-attachments/assets/570d8f40-80d4-4899-b586-fe0199f004d1" width="100%" />
</p>


