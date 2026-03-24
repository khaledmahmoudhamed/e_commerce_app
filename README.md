
# Flutter E-Commerce Pro 🛒

A feature-rich, high-performance E-commerce mobile application built with **Flutter**. This project demonstrates a production-grade architecture for handling dynamic product catalogs, real-time cart management, and seamless user authentication.

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

# lib/
# ├── core/
   * API endpoints, theme constants, and network interceptors.
# ├── data/
  *  Models (Product, Cart, User) and Data Providers.
# ├── logic/
  * Cubits for Auth, Products, and Cart management.
# ├── presentation/
  * Screens (Home, Details, Cart, Checkout) and reusable Widgets.
# └── main.dart
  * Dependency injection and app initialization.

## 🚀 Getting Started
# 1-🚀 Getting Started
# git clone [https://github.com/your-username/ecommerce-app.git](https://github.com/your-username/ecommerce-app.git)
# 2-Install dependencies:
# flutter pub get
# 3-Run Code Generation (if using Hive/JsonSerializable):
# dart run build_runner build --delete-conflicting-outputs
# 4-Run the application:
# flutter run

## 🧩 Challenges & Engineering Solutions
State Consistency: Synchronized the local Hive storage with the Cubit state to ensure the shopping cart remains intact even after the app is closed.
API Optimization: Managed complex JSON structures from the DummyJSON API by building robust data models with null-safety to prevent runtime errors.
UI Performance: Optimized the main product grid using Sliver widgets to maintain a smooth 60fps scrolling experience during heavy image loading.
![Image](https://github.com/user-attachments/assets/748805a1-a535-4313-b161-85dd7b511133)
![Image](https://github.com/user-attachments/assets/c9951ab3-1591-4f2f-9843-c403b534ec1f)
![Image](https://github.com/user-attachments/assets/d1982d1d-6e31-4d92-a968-8bc07582e930)
![Image](https://github.com/user-attachments/assets/51a36451-3f80-4cf4-abe0-73b6786755e3)
![Image](https://github.com/user-attachments/assets/7a113357-e9a6-4cdd-bac4-58d269ad5a56)
![Image](https://github.com/user-attachments/assets/0349d33b-0424-47d7-8744-9c19b233ff62)
![Image](https://github.com/user-attachments/assets/6e222ee0-fc6b-4926-8be8-1a4545ce1bf4)
![Image](https://github.com/user-attachments/assets/d468b706-d3f6-4279-8d7e-e9d9193c9f26)
![Image](https://github.com/user-attachments/assets/ed6fca65-b22f-4cb7-9291-b263897404d1)
![Image](https://github.com/user-attachments/assets/b8d3d571-d281-4604-a24c-4bc39308c356)
<p align="center">
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


