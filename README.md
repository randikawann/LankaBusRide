# 🚌 Bus Routes App

A Swift-based iOS application that displays bus routes and top route filters using the **MVVM** architecture pattern.

---

## 🧠 Project Structure

This project follows the **Model-View-ViewModel (MVVM)** architecture to promote a clean separation of concerns and improve testability.

## 🔍 MVVM Architecture

**Model**  
- Defines your app's data structure.  
- Examples: `BusRoute`, `RouteInfo`

**View**  
- Displays data from the ViewModel.  
- Should be minimal in logic (only UI-related code).

**ViewModel**  
- Holds presentation logic, state, and data-binding.  
- Talks to repositories to fetch/update data.
- Example: `SearchViewModel` handles route filtering, loading, and selection logic.

**Repository**  
- Abstracts the data layer from the rest of the app.  
- Implements `BusRepositoryProtocol`, which can be mocked in unit tests.

---

## ✅ Features

- Fetch and display bus routes from a data source.
- Show top N frequently used routes.
- Filter routes based on selected route number.
- MVVM + Repository pattern for clean separation.
- Fully unit tested with mock repositories.

---

## 🧪 Testing

Tests live under the `Tests/` folder.  
Each `ViewModel` has its own test class, using mock dependencies to simulate different scenarios.

---

## 📦 Dependencies

_No external libraries used._  
All logic is implemented in native Swift (Swift 5.x).

---

## 🛠️ Requirements

- iOS 15.0+
- Xcode 14 or higher
- Swift 5.5+

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙋‍♂️ Author

- Randika Wanninayaka ([@yourGitHub](https://github.com/randikawann))

