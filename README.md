# Maze
Maze is a quiz app that allow users to test their knowledge of various subjects using  past questions of different exam types.

## How
Maze app uses Firebase Authentication to authenticate user and also access users exam history. After authentication, User is navigated to the home screen to select the exam type, subject and exam year. The app comsumes questions using the [ALOC API](https://github.com/Seunope/aloc-endpoints) and save them to core data for offline access. 
User is allowed to select one option at any time per question and selected opton is saved back to core data. Option to upload result to Firestore is provided and User can upload result at any time during an ongoing exam. This automatically conclude the ongoing exam and User is nagivated back to home screen.

## Dependencies
 - [Question Api](https://questions.aloc.ng/)
 - [Firebase Authentication](https://firebase.google.com/docs/auth/ios/start)
 - [Firebase Cloud Store](https://firebase.google.com/docs/firestore/quickstart#swift)
 - [Core Data](https://developer.apple.com/documentation/coredata)
 

