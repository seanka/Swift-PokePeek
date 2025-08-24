# 🐱‍👓 PokePeek

PokePeek is a simple Pokémon browser app built with **SwiftUI**, **Core Data**, and **Clean Architecture**.
It fetches data from the PokéAPI and provides offline support with Core Data caching.

---

## 🚀 Getting Started

### Requirements
- Xcode 15+
- iOS 16+
- Swift 5.9+

---

## 📦 Tech Stack & Libraries

- **SwiftUI** – UI framework
- **Core Data** – offline persistence
- **PokéAPI** – data source
- **Alamofire** – fetch data from PokéAPI
- **Kingfisher** – display URL image
- **RxSwift** – reactive programming
- **RxRelay** – reactive programming
- **MBProgressHUD** – loading view component
- **PagerTabStripView** – interactive pager view component

---

## ✨ Features

- **Onboarding Screen**
  - Shown only on first launch (using `@AppStorage`).

- **Pokémon List**
  - Paginated list fetched from PokéAPI.
  - Offline-first: loads from Core Data if network is unavailable.
  - Incremental caching: fetched pages are stored locally.
                                            
- **Search**
  - Search your favorite Pokémon processeed locally.
                                            
- **Pokémon Detail**
  - Displays stats, abilities, and other details.

- **Offline Mode**
  - List can be browsed even without internet.
  - Core Data handles local persistence.

- **Authentication**
  - User data stored locally using Core Data
  - User action includes login, register, reset password, and logout
  - Automatic redirect to login when user token is not valid

---

## 🏗️ Architecture

- **MVVM + Clean Architecture**
  - `UseCase` layer handles business logic.
  - `Repository` layer abstracts Core Data & network.
  - `ViewModel` handles UI states and data flow.
  - `View` layer represents the user interface.

- **Persistence**
  - Core Data with two entities:
    - `PokeEntity` → Pokémon list info.
    - `UserEntity` → User list info

---

## 📸 Screenshots

- **Onboarding View**<br />
![onboarding page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Onboarding.png?raw=true)

- **Home**<br />
![home page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Home.png?raw=true)

- **Detail View**<br />
![detail page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Detail.png?raw=true)

- **Search View**<br />
![home page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Home.png?raw=true)

- **Authentication View**<br />
![login page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Login.png?raw=true)<br />
![register page](https://github.com/seanka/Swift-PokePeek/blob/main/Resources/Register.png?raw=true)

---
