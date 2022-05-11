#  ResumeApp

# Notes
- I deleted SceneDelete to allow older functions handle the app cycle.
- I used shared preferences to store JSON as string instead of CoreData since we do not need any filtered select queries. 
- I used Storyboard and UIKit instead of SwiftUI because I believe you already have a project with UIKit.
- The app's entry point is SplashViewController.storyboard. Since we can not put any code the original splash screen, I put a clone asplash to check user's status and navigate to the correct screen.
-  When the project get big, XCode shows serious performance issues. I created screens with xib file instead of storyboards to make project lighweight.
-  Instead of segues, I used static push functions to be able to implement Dependency Injection. We do not need to mind the next screen's data needings, the next screen already want them while initilizing.  
- I organized the project as folders to make easier work on project as the team and the project go bigger.
- Developers should not push to production branch directly. They should need to push development first. That should be added as a rule. 
- Developing a feature -> create a branch with dev's and feature name from production branch -> make development -> merge into development branch -> resolve conflict -> get build -> get approval from testers -> merge into production branch -> ready for the next release
- Since we do not have havy data, I didnt use UITableview.
