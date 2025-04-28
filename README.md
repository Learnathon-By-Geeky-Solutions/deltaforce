# DeltaForce - Learning App for Autistic Children

<div align="center">
  
![DeltaForce Logo](https://via.placeholder.com/200x100?text=DeltaForce+Logo)  
**🧩 DeltaForce**  

*Empowering Autistic Children Through Interactive Learning*  

![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-239120?style=for-the-badge)
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

</div>

## 📖 About DeltaForce

DeltaForce is an interactive educational app designed to support children with speech and learning autism. Built with a focus on engagement, skill development, and emotional growth, DeltaForce combines learning modules, assessments, games, and secure user management — all in a safe, child-friendly environment.

## 🎯 The Problem We Address

- ❌ Lack of tailored educational apps for autistic children
- ❌ Scarcity of accessible emotion and motor skills training
- ❌ Inadequate progress tracking for parents and therapists

## ✅ Our Solution

- ✅ Animated, gamified alphabet and social learning
- ✅ Emotion recognition and family relationship building
- ✅ Fun games (Fruit Slice) for motor control improvement
- ✅ Assessment and tracking to monitor child progress
- ✅ Secure, child-friendly login and data storage

## 📋 Table of Contents

1. [Team Members](#-team-members)
2. [Project Overview](#-project-overview)
3. [Key Features](#-key-features)
4. [Tech Stack](#-tech-stack)
5. [Project Structure](#-project-structure)
6. [Installation](#-installation)
7. [App Screenshots](#-app-screenshots)
8. [Testing Strategy](#-testing-strategy)
9. [Contributing](#-contributing)

## 👥 Team Members

| Name | Role | GitHub Profile |
|------|------|----------------|
| Uttam-Sarkar | Team Leader & Dev | [@Uttam-Sarkar](https://github.com/Uttam-Sarkar) |
| sbfrusho | Contributor | [@sbfrusho](https://github.com/sbfrusho) |
| majidbhuiyan20 | Contributor | [@majidbhuiyan20](https://github.com/majidbhuiyan20) |
| shahriarRahmanShaon | Mentor | [@shahriarRahmanShaon](https://github.com/shahriarRahmanShaon) |

## 🚀 Project Overview

DeltaForce makes learning fun, interactive, and empowering for autistic children — blending education with games, visuals, and emotional intelligence building.

**Target Users:**
- Children aged 3-12 diagnosed with autism
- Parents and therapists for child progress tracking

## 🌟 Key Features

| Feature | Description |
|---------|-------------|
| Alphabet Learning | Text animations, voiceover for letter recognition |
| Emotion Recognition | Helping kids recognize and express emotions |
| Social Skills | Scenarios for conversations, greetings, sharing |
| Animal Identification | Learn animals with images and sounds |
| Daily Living Skills | Basics like brushing, dressing, mealtime routines |
| Family Relations | Understanding family roles and names |
| Fruit Slice Game | Boosts motor control and hand-eye coordination |
| Progress Tracker | Test-based learning outcomes and reports |
| Authentication | Secure login/signup, password reset with SharedPreferences |

## 🛠️ Tech Stack

- **Frontend**: Flutter (MVVM architecture), Dart
- **Backend**: Firebase Authentication, Firestore
- **Local Storage**: Shared Preferences
- **State Management**: GetX
- **Testing**: Unit and Widget tests

## 🏗️ Project Structure

![Project Structure](screenshots/Screenshot_from_2025-04-28_10-04-24.png)

deltaforce/
│── core/
│── features/
│ ├── authentication/
│ │ ├── const/
│ │ ├── models/
│ │ ├── services/
│ │ ├── view_models/
│ │ └── views/
│── Profile/
│── Settings/
│── service/
│── UI/
│── view-model/
│── theme/
│── resources/
│ ├── assets/
│ ├── colors/
│ └── fonts/
│── getx_localization/
│── routes/
│── screens/
│ ├── base/
│ ├── end_drawer/
│ ├── learn_item_screen/
│ ├── learnScreen/
│ ├── navigation/
│ ├── parentScreen/
│ ├── practiceScreen/
│ ├── sessionScreen/
│ ├── testScreen/
│── utils/
│── widgets/
│── firebase_options.dart
│── main.dart


## 💻 Installation

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Firebase project setup
- Android Studio or VSCode

## 📸 App Screenshots

<div align="center">

| Login Screen | SignUp Screen | Forgot Password |
|--------------|------------------|-----------------|
| ![Login](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092340.png) | ![Alphabet](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092347.png) | ![Emotion](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092355.png) |

| Home | App Drawer | Study |
|--------------------|-----------------|---------------|
| ![Animals](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092426.png) | ![Game](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092431.png) | ![Test](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092441.png) |

| Living Skills | Family Relationship | Emotion |
|---------------|-----------------|--------------|
| ![Social](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092456.png) | ![Settings](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092502.png) | ![Profile](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092507.png) |
| **Social Skills** | **Settings Screen** | **Profile View** |
| ![Screen 10 - Family](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092519.png) | ![Screen 11 - Living Skills](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092527.png) | ![Screen 12 - Navigation](https://raw.githubusercontent.com/Learnathon-By-Geeky-Solutions/deltaforce/SBF_RUSHO/voice_bridge/assets/DeltaForce-20250428T033830Z-001/DeltaForce/Screenshot_20250428_092533.png) |
</div>

### Steps
```bash
# Clone the repo
git clone https://github.com/Learnathon-By-Geeky-Solutions/deltaforce.git

# Navigate to the project directory
cd deltaforce

# Install dependencies
flutter pub get

# Run the app
flutter run

📸 App Screenshots
<div align="center">
		
Screen 1	Screen 2	Screen 3
Screen 4	Screen 5	Screen 6
Screen 7	Screen 8	Screen 9
Screen 10	Screen 11	Screen 12
</div>
🧪 Testing Strategy
Test Type	Description
Unit Tests	Test logic inside ViewModels and Services
Widget Tests	Verify individual UI components
Integration Tests	Simulate real user journeys and backend interaction
