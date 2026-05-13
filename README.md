# 🎬 Movie-Vibe

Movie-Vibe is a modern iOS movie browsing application built using **SwiftUI** and the **MVVM architecture**. The app allows users to discover trending, top-rated, and upcoming movies, search movies instantly, explore movie details, and manage a personalized watchlist.

The project also demonstrates clean architecture principles and includes practical implementations of the **SOLID principles** for better scalability and maintainability.

---

# ✨ Features

## 🏠 Home Screen
- Browse trending movies in a horizontal carousel
- View categorized movie sections:
  - Trending
  - Top Rated
  - Upcoming
- Responsive movie grid layout
- Smooth navigation to movie details

## 🔍 Search Functionality
- Real-time movie searching
- Dynamic search results
- Clean search interface with custom search bar

## 🎥 Movie Details
- Detailed movie information screen
- Movie poster previews
- About movie section
- Reviews section
- Cast section

## 📚 Watchlist
- Save movies to your watchlist
- Persistent watchlist management
- Easy access from bottom tab navigation

## 🎨 Modern UI
- Built completely with SwiftUI
- Custom reusable components
- Adaptive layouts for iPhone and iPad
- Custom theme colors and assets

## 🧠 Architecture & Design
- MVVM Architecture
- Reusable service layer
- Async/Await networking
- Generic API client implementation
- Demonstration of SOLID Principles

---

# 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| Swift | Core programming language |
| SwiftUI | User Interface |
| MVVM | Architecture Pattern |
| Async/Await | Asynchronous API handling |
| URLSession | Networking |
| Xcode | Development Environment |

---

# 📂 Project Structure

```bash
Movie-Vibe/
│
├── Movie-Vibe/
│   ├── Assets.xcassets/        # App assets and theme colors
│   ├── Extensions/             # Swift extensions
│   ├── Model/                  # App models and enums
│   ├── Resources/              # Local JSON data
│   ├── Services/               # API and local storage services
│   ├── Utility/                # Constants and utilities
│   ├── View/                   # SwiftUI screens
│   ├── ViewModel/              # MVVM view models
│   ├── Solid Principle/        # SOLID principle examples
│   └── Movie_VibeApp.swift     # App entry point
│
├── Movie-Vibe.xcodeproj/
└── README.md
```

---

# 📱 Screens Included

- Home Screen
- Search Screen
- Watchlist Screen
- Movie Details Screen

---

# ⚙️ Installation

## 1️⃣ Clone the Repository

```bash
git clone https://github.com/VishnuMavawala/Movie-Vibe.git
```

## 2️⃣ Open Project in Xcode

```bash
cd Movie-Vibe
open Movie-Vibe.xcodeproj
```

## 3️⃣ Build & Run

- Select Simulator or Physical Device
- Press:

```bash
⌘ + R
```

---

# 🧩 Important Components

## 📌 APIClient
A reusable generic networking layer that:
- Handles GET/POST requests
- Supports query parameters
- Supports authorization headers
- Decodes generic API responses
- Implements proper error handling

## 📌 WatchListManager
Handles:
- Adding movies to watchlist
- Removing movies from watchlist
- Shared state management using `@EnvironmentObject`

## 📌 Custom Components
Reusable SwiftUI views:
- `SearchBarView`
- `MovieCellView`
- `SegmentPickerView`
- `CustomeImage`

---

# 🧠 SOLID Principles Included

This project contains separate examples demonstrating:

1. Single Responsibility Principle
2. Open/Closed Principle
3. Liskov Substitution Principle
4. Interface Segregation Principle
5. Dependency Inversion Principle

Location:

```bash
Movie-Vibe/Solid Principle/
```

---

# 🚀 Future Improvements

- TMDB Live API integration
- Authentication system
- Dark mode support
- Trailer playback
- Pagination support
- Offline caching
- Firebase integration
- User profiles
- Movie recommendations

---

# 📸 Preview

Add screenshots here:

```md
![Home Screen](screenshots/home.png)
![Search Screen](screenshots/search.png)
![Details Screen](screenshots/details.png)
```

---

# 🤝 Contributing

Contributions are welcome.

## Steps to contribute:

1. Fork the repository
2. Create a feature branch

```bash
git checkout -b feature-name
```

3. Commit changes

```bash
git commit -m "Add new feature"
```

4. Push to GitHub

```bash
git push origin feature-name
```

5. Open a Pull Request

---

# 📄 License

This project is licensed under the MIT License.

---

# 👨‍💻 Author

### Vishnu Mavawala

- GitHub: https://github.com/VishnuMavawala
- Project Repository: https://github.com/VishnuMavawala/Movie-Vibe

---

# ⭐ Support

If you like this project, consider giving it a ⭐ on GitHub.

