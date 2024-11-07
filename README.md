# Aisle-Assignment-iOS 
This is a sample mobile application for a take home assignment by Aisle.
Built with Swift and SwiftUI.

## Tech Stack
- **iOS**: Swift, SwiftUI
- **Architecture**: [TCA (The Composable Architecture)](https://github.com/pointfreeco/swift-composable-architecture)
- **Dependency Management**: Swift Package Manager

## Features
- Secure authentication
- Basic Home Screen

## Merge Guidlines
- Merging into main must be done only when it is a release candidate (RC)
- All merges to `main`, and `develop` branches must be made via Pull Requests

## Approach
I have decided to go with a modular approach that gives room to grow as and when the App decided to add on new feature, facilitated by TCA and SPM

If I had more time for submission this is what I would do differently:
 - Have a different navigation approach
 - Use some form of persistence to store logged in state and auth token on the keychain
 - Built a more scalable APIClient with end-points segregated (I did try this approach but I figured I would not be able to complete the submission on time)
 - Decouple the RootView away from the Login Flow 
