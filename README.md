# SnapFeed

A modern iOS social media application built with SwiftUI, demonstrating professional architectural patterns and best practices.

## 📱 Features

- **User Authentication**: Email/password authentication with Firebase
- **Social Feed**: Browse and view posts from other users
- **Profile Management**: Create and edit user profiles with image uploads
- **User Search**: Discover and explore other users
- **Post Upload**: Create and share posts with images
- **Multilanguage Support**: Turkish and English (with extensible architecture for more languages)

## 🏗️ Architecture

SnapFeed follows a clean, modular architecture combining multiple design patterns for maintainability, testability, and scalability.

### Architectural Patterns

#### 1. **MVVM (Model-View-ViewModel)**
- Separation of concerns between UI (View), business logic (ViewModel), and data (Model)
- ViewModels handle presentation logic and communicate with services
- Views are reactive and observe ViewModel state changes

#### 2. **Coordinator Pattern**
- Manages navigation flow and routing logic
- Decouples navigation from Views
- Handles deep linking and navigation state

```
AppCoordinator
├── AuthenticationCoordinator (Login/Register flow)
└── MainCoordinator (Main app navigation)
```

#### 3. **Dependency Injection (DI)**
- Protocol-based dependency injection for testability
- DependencyContainer manages service registration and resolution
- Composition Root pattern in `SnapFeedApp.swift`

#### 4. **Factory Pattern**
- `ViewModelFactory`: Creates ViewModels with injected dependencies
- `ViewFactory`: Creates Views with their ViewModels
- Centralized object creation logic

#### 5. **Protocol-Oriented Programming**
- Services and ViewModels conform to protocols
- Easy to mock for testing
- Loose coupling between components

## 📂 Project Structure

```
SnapFeed/
├── Core/
│   ├── Coordinators/          # Navigation coordination
│   │   ├── Coordinator.swift
│   │   ├── AppCoordinator.swift
│   │   ├── AuthenticationCoordinator.swift
│   │   └── MainCoordinator.swift
│   ├── DI/                    # Dependency Injection
│   │   └── DependencyContainer.swift
│   ├── Factories/             # Object creation factories
│   │   ├── ViewModelFactory.swift
│   │   └── ViewFactory.swift
│   ├── Services/              # Business logic services
│   │   ├── AuthService.swift
│   │   ├── UserService.swift
│   │   ├── ImageUploader.swift
│   │   └── Protocols/
│   │       ├── AuthServiceProtocol.swift
│   │       └── UserServiceProtocol.swift
│   └── Utilities/             # Utilities and helpers
│       ├── Constants/
│       │   └── FirestoreConstants.swift
│       ├── Extensions/
│       │   └── String+Localized.swift
│       ├── LanguageManager.swift
│       └── PreviewHelpers.swift
├── Models/                    # Data models
│   ├── User.swift
│   └── Post.swift
├── ViewModels/                # ViewModels (business logic)
│   ├── ContentViewModel.swift
│   ├── LoginViewModel.swift
│   ├── RegisterViewModel.swift
│   ├── SearchViewModel.swift
│   ├── EditProfileViewModel.swift
│   ├── UploadPostViewModel.swift
│   └── Protocols/             # ViewModel protocols
├── Views/                     # SwiftUI Views
│   ├── Authentication/
│   ├── Components/
│   ├── Content/
│   ├── Feed/
│   ├── Profile/
│   ├── Search/
│   ├── TabBar/
│   └── UploadPostView/
├── Resources/                 # Assets and localizations
│   ├── Assets.xcassets/
│   ├── tr.lproj/
│   ├── en.lproj/
│   └── GoogleService-Info.plist
└── SnapFeedApp.swift          # App entry point & Composition Root
```

## 🔧 Key Components

### DependencyContainer

Centralized dependency management following Dependency Injection principles.

```swift
let container = DependencyContainer()
container.registerDefaultServices()

// Services are registered as protocols
container.register(AuthServiceProtocol.self, instance: AuthService())
container.register(UserServiceProtocol.self, instance: UserService())
```

**Features:**
- Protocol-based service registration
- Singleton and factory pattern support
- Type-safe dependency resolution

### ViewModelFactory

Creates ViewModels with all dependencies injected.

```swift
let factory = ViewModelFactory(container: container)
let viewModel = factory.makeLoginViewModel(authService: authService)
```

### ViewFactory

Creates Views with their ViewModels already injected.

```swift
let viewFactory = ViewFactory(container: container)
let loginView = viewFactory.makeLoginView()
```

### Coordinator Pattern

Manages navigation flow without coupling Views to navigation logic.

```swift
class AppCoordinator: ObservableObject {
    func showAuthentication() {
        currentView = .authentication
        authenticationCoordinator = AuthenticationCoordinator(container: container)
    }
}
```

## 🌍 Localization

SnapFeed supports multiple languages with an extensible architecture:

- **Supported Languages**: Turkish (tr), English (en)
- **Language Detection**: Automatically detects device language on first launch
- **Language Selection**: Users can change language (UI to be added)
- **Fallback**: Defaults to English for non-Turkish devices

### Usage

```swift
// In Views
Text("login.button".localized)

// With format arguments
Text("register.complete.title".localized(with: username))

// Change language programmatically
LanguageManager.shared.setLanguage(.turkish)
```

## 🛠️ Technologies

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for data flow
- **Firebase**: 
  - Authentication
  - Firestore (database)
  - Storage (image uploads)
- **Swift 6**: Latest Swift features including `any` keyword for existential types

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0+ deployment target
- Firebase project with Authentication, Firestore, and Storage enabled

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd SnapFeed
```

2. Open the project
```bash
open SnapFeed.xcodeproj
```

3. Configure Firebase
   - Add your `GoogleService-Info.plist` to the `Resources` folder
   - Ensure Firebase is properly configured in your Firebase Console

4. Build and run
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## 📝 Code Examples

### Creating a New View with DI

```swift
// 1. Create ViewModel Protocol
protocol MyViewModelProtocol: ObservableObject {
    var data: String { get }
}

// 2. Create ViewModel Implementation
class MyViewModel: MyViewModelProtocol {
    @Published var data: String = ""
    private let service: MyServiceProtocol
    
    init(service: MyServiceProtocol) {
        self.service = service
    }
}

// 3. Add to ViewModelFactory
func makeMyViewModel() -> MyViewModel {
    let service = container.resolve(MyServiceProtocol.self)
    return MyViewModel(service: service)
}

// 4. Add to ViewFactory
func makeMyView() -> MyView {
    let viewModel = viewModelFactory.makeMyViewModel()
    return MyView(viewModel: viewModel)
}
```

### Adding a New Localized String

1. Add key to `Resources/tr.lproj/Localizable.strings`:
```strings
"my.new.key" = "Yeni Metin";
```

2. Add key to `Resources/en.lproj/Localizable.strings`:
```strings
"my.new.key" = "New Text";
```

3. Use in code:
```swift
Text("my.new.key".localized)
```

## 🧪 Testing

The project structure supports easy unit testing through:

- Protocol-based services (easy to mock)
- Dependency injection (swap implementations)
- Separated ViewModels (test business logic independently)

Example test setup:
```swift
let mockAuthService = MockAuthService()
let container = DependencyContainer()
container.register(AuthServiceProtocol.self, instance: mockAuthService)
let viewModel = ViewModelFactory(container: container).makeLoginViewModel()
```

## 📐 Design Principles

1. **Separation of Concerns**: Each layer has a single responsibility
2. **Dependency Inversion**: Depend on abstractions (protocols), not concretions
3. **Single Responsibility**: Each class/struct has one reason to change
4. **Open/Closed**: Open for extension, closed for modification
5. **Testability**: All components are easily testable through DI

## 🔄 Data Flow

```
User Action
    ↓
View (SwiftUI)
    ↓
ViewModel (Business Logic)
    ↓
Service (Protocol)
    ↓
Service Implementation (Firebase)
    ↓
Response flows back through the chain
```

## 🎯 Future Enhancements

- [ ] Complete Coordinator implementation for deep linking
- [ ] Unit tests for ViewModels and Services
- [ ] UI tests for critical user flows
- [ ] Additional language support
- [ ] Settings screen for language selection
- [ ] Push notifications
- [ ] Social features (likes, comments, follows)

---

**Built with ❤️ using SwiftUI and modern iOS architecture patterns**

