# Maze
Maze is a quiz app that allow users to test their knowledge of various subjects using  past questions of different exam types.

## Pics

![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/login.png)  
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/home.png) 
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/history.png)
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/question%20page.png)
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/question%20page%20correct%20answer.png)
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/question%20page%20wrong%20answer.png)
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/result%20dialog.png)
![](https://github.com/CodeIsmail/Maze/blob/main/Maze%20pics/Answer%20Sheet.png)

## Requirements
 - Xcode 12.1+
 - iOS 14.1+
 - Swift 5.0+
 
## Installation
 - Firebase/Auth
 - Firebase/Firestore
 - FirebaseFirestoreSwift
 - SnapKit
 - GoogleSignIn
 
## How
Maze app uses Firebase Authentication to authenticate user and also access users exam history. After authentication, User is navigated to the home screen to select the exam type, subject and exam year. The app comsumes questions using the [ALOC API](https://github.com/Seunope/aloc-endpoints) and save them to core data for offline access. 
User is allowed to select one option at any time per question and swipe to the next question. Selected opton is saved back to core data. Option to upload result to Firestore is provided and User can upload result at any time during an ongoing exam. This automatically conclude the ongoing exam and User is nagivated back to home screen.

## NOTE
Firestore fail silently without as such an error alert is not displayed

## Dependencies
 - [Question Api](https://questions.aloc.ng/)
 - [Firebase Authentication](https://firebase.google.com/docs/auth/ios/start)
 - [Firebase Cloud Store](https://firebase.google.com/docs/firestore/quickstart#swift)
 - [Core Data](https://developer.apple.com/documentation/coredata)
 
 ## Credit
 - Tobi Dada [@TobiAlbert](https://github.com/TobiAlbert)

