🚀 Flutter GitHub Repository Explorer

📌 Project Overview

Flutter GitHub Repository Explorer is a Flutter application that allows users to search GitHub repositories dynamically and view the **top 50 repositories** based on popularity.
The app supports **offline browsing**, **sorting**, **pull-to-refresh**, and **detailed user profiles** fetched directly from the GitHub API.

---
✨ Key Features

🔍 Search GitHub repositories with any keyword
⭐ View top 50 repositories by **star count** or **last updated date**
🔄 Pull-to-refresh with loading indicator
📦 Offline data caching (repositories)
👤 User profile details using GitHub Users API
⚠️ Proper error handling (no internet, API failure)
🎨 Clean, responsive UI for mobile & tablet
🧠 Clean architecture with GetX state management

---
 ▶️ How to Run the App

### Prerequisites

* Flutter SDK (latest stable)
* Android Studio 
* Internet connection (for first API fetch)

### Steps

```bash
git clone https://github.com/your-username/flutter-github-explorer.git
cd flutter-github-explorer
flutter pub get
flutter run
```

📱 Works on both Android and iOS, web and windows.

---

## 📚 Dependencies Used

| Package                | Purpose                       |
| ---------------------- | ----------------------------- |
| `get`                  | State management & navigation |
| `dio`                  | HTTP client for GitHub API    |
| `hive`                 | Local data persistence        |
| `hive_flutter`         | Hive Flutter integration      |
| `cached_network_image` | Image caching                 |
| `intl`                 | Date formatting               |

---

 🌐 APIs Used

* GitHub Repositories API
  ```
  https://api.github.com/search/repositories
  ```
* GitHub Users API

  ```
  https://api.github.com/users/{username}
  ```
---

 🧩 Architecture
 
This project follows Clean Architecture principles:
* **UI (Views)** – Renders data
* **Controllers** – Business logic & state
* **Services** – API communication
* **Models** – Data mapping

---

 📬 Notes

* GitHub API rate limits apply
* Offline mode shows cached data when available
* Error messages are shown for network/API failures

---

👨‍💻 Author
Md. Aitkul islam
Built with ❤️ using Flutter & Clean Architecture.

