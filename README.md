 <div align="center">

DeltaForce Logo
🧩 DeltaForce

Empowering Autistic Children Through Interactive Learning

Dart Flutter GetX
MIT License
</div> <table> <tr> <td>
📖 About DeltaForce

DeltaForce is an interactive educational app designed to support children with speech and learning autism. Built with a focus on engagement, skill development, and emotional growth, DeltaForce combines learning modules, assessments, games, and secure user management — all in a safe, child-friendly environment.
🎯 The Problem We Address

    ❌ Lack of tailored educational apps for autistic children

    ❌ Scarcity of accessible emotion and motor skills training

    ❌ Inadequate progress tracking for parents and therapists

✅ Our Solution

    ✅ Animated, gamified alphabet and social learning

    ✅ Emotion recognition and family relationship building

    ✅ Fun games (Fruit Slice) for motor control improvement

    ✅ Assessment and tracking to monitor child progress

    ✅ Secure, child-friendly login and data storage

</td> </tr> </table> <details> <summary><h2>📋 Table of Contents</h2></summary>

    👥 Team Members

    🚀 Project Overview

    🌟 Key Features

    🛠️ Tech Stack

    🏗️ Project Structure (MVVM)

    🗃️ Local & Backend Data Management

    💻 Installation

    🧪 Testing Strategy

    🤝 Contributing

    📚 Resources

</details> <div align="center">
👥 Team Members
Name	Role	GitHub Profile
[Your Name]	Team Leader & Dev	@yourgithub
[Other Members]	Contributors	@teammember
[Mentor Name]	Project Mentor	@mentor
</div>
🚀 Project Overview

DeltaForce makes learning fun, interactive, and empowering for autistic children — blending education with games, visuals, and emotional intelligence building.

Target Users:

    Children aged 3-12 diagnosed with autism

    Parents and therapists for child progress tracking

🌟 Key Features
Feature	Description
Alphabet Learning	Text animations, voiceover for letter recognition
Emotion Recognition	Helping kids recognize and express emotions
Social Skills	Scenarios for participating in conversations, greetings, sharing
Animal Identification	Learn common animals with images and sounds
Daily Living Skills	Basics like brushing, dressing, and mealtime routines
Family Relations	Understanding family roles and names
Fruit Slice Game	Boosts motor control and hand-eye coordination
Progress Tracker	Test-based learning outcomes and reports
Authentication	Secure login/signup, password reset, local storage with SharedPreferences
🛠️ Tech Stack

    Frontend: Flutter (MVVM architecture), Dart

    Backend: Firebase Authentication, Firestore

    Local Storage: Shared Preferences

    State Management: GetX (minimal and reactive)

    Testing: Unit and Widget tests

🏗️ Project Structure (MVVM)

deltaforce/
│── data/  
│   ├── models/  
│   │   ├── user_model.dart  
│   │   ├── learning_content_model.dart  
│   │   ├── test_result_model.dart  
│   ├── repositories/  
│   │   ├── auth_repository.dart  
│   │   ├── learning_repository.dart  
│   │   ├── test_repository.dart  
│── services/  
│   ├── auth_service.dart  
│   ├── firebase_service.dart  
│   ├── storage_service.dart  
│── utils/  
│   ├── validators.dart  
│   ├── custom_widgets.dart  
│── view/  
│   ├── auth/  
│   │   ├── login_screen.dart  
│   │   ├── signup_screen.dart  
│   │   ├── forgot_password_screen.dart  
│   ├── home/  
│   ├── learning/  
│   ├── games/  
│   ├── profile/  
│── view_model/  
│   ├── auth_viewmodel.dart  
│   ├── learning_viewmodel.dart  
│   ├── game_viewmodel.dart  
│   ├── profile_viewmodel.dart  

🗃️ Local & Backend Data Management
Storage Type	Use Case
Firebase Authentication	Secure user login and password management
Firestore Database	Store user profiles, progress reports
Shared Preferences	Lightweight local caching for quick access
💻 Installation
Prerequisites

    Flutter SDK (>=3.0.0)

    Dart SDK

    Firebase project setup

    Android Studio or VSCode

Steps

# Clone the repo
git clone https://github.com/Learnathon-By-Geeky-Solutions/deltaforce.git

# Navigate to the project directory
cd deltaforce

# Install dependencies
flutter pub get

# Run the app
flutter run

🧪 Testing Strategy
Test Type	Description
Unit Tests	Test logic inside ViewModels and Services
Widget Tests	Verify individual UI components
Integration Tests	Simulate real user journeys and backend interaction
