
# 📱 Smart Task Manager

A modern task management mobile app built with **Flutter**, featuring:

- 🔐 Firebase Authentication (BLoC)
- 📦 Task CRUD with Firestore + offline Hive sync (GetX)
- 🎨 Responsive UI with theme switching
- 🧠 Clean architecture & state management

![Platform](https://img.shields.io/badge/platform-flutter-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)

---

## 🚀 Features

| Feature                          | Tech Used               |
|----------------------------------|--------------------------|
| Firebase Auth                   | `firebase_auth`, BLoC   |
| Task CRUD & Offline Sync        | Firestore, Hive, GetX   |
| State Management                | BLoC & GetX combo       |
| Responsive UI                   | `flutter_screenutil`    |
| Theme (Dark/Light)              | `ThemeService` (GetX)   |

---

## 🧠 Tech Stack

- **Flutter** (UI)
- **Firebase** (Auth + Firestore)
- **Hive** (Offline local DB)
- **BLoC** (Auth, Settings)
- **GetX** (Tasks, Dashboard)
- **flutter_screenutil** (Responsive UI)

---

## 📂 Project Structure

```
lib/
├── core/              # Theme, constants, utils
├── data/              # Models, Hive, Firestore repos
├── services/          # Firebase, ThemeService, etc
├── features/
│   ├── auth/          # Login logic (BLoC)
│   ├── dashboard/     # Navigation wrapper (GetX)
│   ├── tasks/         # CRUD logic and views (GetX)
│   └── settings/      # Theme + logout (BLoC)
├── widgets/           # Firebase, ThemeService, etc
└── main.dart
```

---

## 🛠️ Getting Started

### 🔧 Prerequisites

- Flutter SDK (Latest stable)
- Firebase project

### 📦 Installation

```bash
git clone https://github.com/fajar773/smart-task-manager.git
cd smart_task_manager
flutter pub get
```

### 🔑 Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a project and enable **Email/Password** sign-in
3. Download config files:
   - `google-services.json` → place in `android/app/`
   - `GoogleService-Info.plist` → place in `ios/Runner/`
4. Enable Firestore in Firebase Console

### ▶️ Run the App

```bash
flutter run
```

---

## 🎯 To-Do (WIP)

- [ ] 🔄 Offline queue and sync retry
- [ ] 🔐 Hive encryption
- [ ] 🆕 Register screen
- [ ] 🗓️ Task reminder & notification
- [ ] ✅ Task completion checkbox with animation

---

## 🧪 Dependencies

| Package               | Description                         |
|-----------------------|-------------------------------------|
| `flutter_bloc`        | BLoC state management               |
| `get`                 | Lightweight state & nav             |
| `firebase_auth`       | Firebase email login                |
| `cloud_firestore`     | Firebase task storage               |
| `hive` + `hive_flutter` | Local DB + offline support       |
| `flutter_screenutil`  | Responsive design                   |

---

## 📄 License

This project is licensed under the MIT License.

---

⭐️ **Star** this repo if it helped you or inspired your Flutter journey!
