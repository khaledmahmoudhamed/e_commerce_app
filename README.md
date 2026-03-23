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

### 📱 App Screenshots

<p align="center">
 <img src="https://github.com/user-attachments/assets/5bf19585-0ba4-4651-91fa-f548c8a29e61" width="30%" />
  <img src="https://github.com/user-attachments/assets/630b7b69-cc4b-4544-b2e7-836d3c2e11fa" width="30%" />
    <img src="https://github.com/user-attachments/assets/1d7cc313-c3fa-42d3-901a-244d5f3b9a92" width="30%" />
  <img src="https://github.com/user-attachments/assets/cdbe3146-47bf-44d8-ad87-15ffd4f2db40" width="30%" />
  <img src="https://github.com/user-attachments/assets/94783ad4-2edc-4a83-a6d9-71fcb6ebafb4" width="30%" />
  <img src="https://github.com/user-attachments/assets/29dc4955-df36-4c35-940c-16573bfdfac4" width="30%" />
  <img src="https://github.com/user-attachments/assets/889cba50-21f7-4fee-bb0e-dd57452031d5" width="30%" />
  <img src="https://github.com/user-attachments/assets/f488af5b-c4b8-4d0b-97b1-808d85cf8047" width="30%" />
<img src="https://github.com/user-attachments/assets/dc81067c-8a05-41d2-a249-25f0bcabe061" width="30%" />
<img src="https://github.com/user-attachments/assets/dd931c63-dedf-493a-9161-ef16a9d79a68" width="30%" />
<img src="https://github.com/user-attachments/assets/e8fa531d-6c4b-47f2-8ff7-325e78096751" width="30%" />
<img src="https://github.com/user-attachments/assets/54187e42-9567-478b-b97a-628d33c4e7a1" width="30%" />
<img src="https://github.com/user-attachments/assets/46bed82b-a1ea-4f12-baf8-52a88b4af110" width="30%" />
<img src="https://github.com/user-attachments/assets/97cbe4a9-bf74-4722-be76-e82a0521cbb9" width="30%" />
<img src="https://github.com/user-attachments/assets/c7ef65bd-a4c5-42f5-b682-0fd1bd6f24bd" width="30%" />
<img src="https://github.com/user-attachments/assets/f4a1d67f-2327-4cb4-8498-77beb92464b2" width="30%" />
<img src="https://github.com/user-attachments/assets/4d3ff5bd-db7a-45cf-a583-828c7f6308b0" width="30%" />
<img src="https://github.com/user-attachments/assets/fa621583-9a3d-4552-bf30-24bd1cf2199a" width="30%" />
<img src="https://github.com/user-attachments/assets/3b37fb36-41ec-4322-a2d9-4caba551d44b" width="30%" />
<img src="https://github.com/user-attachments/assets/28b3e6b1-993f-4f16-af18-640f6c83d19a" width="30%" />
<img src="https://github.com/user-attachments/assets/653fcf24-1a12-463b-9edb-3bb58f5adb9f" width="30%" />
</p>

![Recording_20260317_164336 00_02_50--00_03_10](https://github.com/user-attachments/assets/2e07826a-3a1d-4c7e-8875-171d61f41458)
![Recording_20260317_164336 00_02_30--00_02_50](https://github.com/user-attachments/assets/b5b85aec-f036-4837-bdb5-98b48ed438d2)
![Recording_20260317_164336 00_02_12--00_02_32](https://github.com/user-attachments/assets/9d1d4de6-f7dc-4543-a14f-90195de0020f)
![Recording_20260317_164336 00_01_51--00_02_11](https://github.com/user-attachments/assets/17e1da85-cc04-480c-9b66-a2a147f4c9f8)
![Recording_20260317_164336 00_01_31--00_01_51](https://github.com/user-attachments/assets/f38fa3bc-8b12-4157-b9f7-c5ec1c2c9961)
![Recording_20260317_164336 00_01_12--00_01_32](https://github.com/user-attachments/assets/593c19c8-71e2-4fef-83ee-672352d9457d)
![Recording_20260317_164336 00_00_55--00_01_15](https://github.com/user-attachments/assets/49611dd2-1f0f-402e-a75d-6c7363c060d0)
![Recording_20260317_164336 00_00_48--00_01_08](https://github.com/user-attachments/assets/49d6066d-f481-434a-8696-534b3765e31b)
![Recording_20260317_164336 00_00_24--00_00_44](https://github.com/user-attachments/assets/8564d2e2-990b-4d8b-bfbd-df6eac3c6216)
![Recording_20260317_164336 00_00_00--00_00_20](https://github.com/user-attachments/assets/3e200e49-3c01-4755-92a0-830ee72c7c56)
![Recording_20260317_164336 00_03_12--00_03_16](https://github.com/user-attachments/assets/01650daa-8b62-4d9a-aea5-3a4ae7043ac5)

