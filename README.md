# Miles Education App

The **Miles Education App** is a mobile application built using Flutter. It allows users to log in, sign up, and manage their tasks. The app integrates Firebase for authentication and Firestore for task storage.

## Features

- **Authentication**: Users can sign up, log in, and log out using Firebase Authentication.
- **Task Management**: Users can add, edit, and delete tasks.
- **Responsive UI**: The app is designed to be responsive and user-friendly.
- **Firebase Integration**: Firebase is used for user authentication and Firestore as a backend database.

## Tech Stack

- **Flutter**: For building the mobile UI.
- **Firebase**: For authentication and Firestore as a backend database.
- **GetX**: For state management and routing.

## Setup

### Prerequisites

Before you begin, ensure you have the following installed on your system:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.29.3 or later)
- [Firebase Project](https://console.firebase.google.com/) with Firebase Authentication and Firestore enabled

### Steps to Run the App

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/miles_education_app.git
   cd miles_education_app


miles_education_app/
├── android/                # Android-specific code
├── ios/                    # iOS-specific code
├── lib/                    # Application code
│   ├── controllers/        # Business logic and controllers (e.g., AuthController, TaskController)
│   ├── routes/             # Routing and app navigation
│   ├── screens/            # App screens (e.g., LoginScreen, TaskListScreen)
│   ├── widgets/            # Custom UI components (e.g., CustomTextField, TaskTile)
│   └── main.dart           # Entry point of the app
├── test/                    # Unit tests
│   ├── controllers/        # Unit tests for controllers
│   ├── widgets/            # Unit tests for widgets
│   └── test_setup.dart     # Test setup for Firebase initialization
├── pubspec.yaml            # Dependencies and Flutter configuration
└── README.md               # This file
