# ResumeApp

# Notes
- I deleted SceneDelete to allow older functions to handle the app cycle.
- I used shared preferences to store JSON as a string instead of CoreData since we do not need any filtered select queries. 
- I used Storyboard and UIKit instead of SwiftUI because I believe you already have a project with UIKit.
- The app's entry point is SplashViewController.storyboard. Since we can not put any code on the original splash screen, I put a clone splash to check the user's status and navigate to the correct screen.
-  When the project gets big, XCode shows serious performance issues. I created screens with xip files instead of storyboards to make the project lightweight.
-  Instead of segues, I used static push functions to be able to implement Dependency Injection. We do not need to mind the next screen's data needings, the next screen already wants them while initializing.  
- I organized the project as folders to make it easier to work on the project as the team and the project got bigger.
- Since we do not have heavy data, I didn't use UITableview.
- I am using UITest instead of the unit test. Unit tests are good for testing critical functions but I believe the backend should handle the critical calculations. We can not trust any calculation that is being calculated on the client side.
- I created an example test called testAddingSkill. It adds a skill with a random number then re-launches the app, and then expects the skill exists.
