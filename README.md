# CoffeeFinder
CoffeeFinder determines the current location to the nearest ten metres and will display the coffee shops closest to the user’s location. The coffee shops listed are updated as the user moves every 50m. The search for coffee shops is within a 500m radius. Users are able to click on a "Show in Maps" button to see the location of the coffee shop in the iOS Maps application.

## How to run code
The source code can be found on GitHub at: 
- https://github.com/a-carrillo/CoffeeFinder
- git@github.com:a-carrillo/CoffeeFinder.git

Simply clone the project or download the zip file using the above links.

After cloning project, you will need to build the project in Xcode to run in the simulator. The simulator will need to have a location set (see Debug - Location and set a custom location).

## Approach taken
CoffeeFinder has been coded as an iOS 9 Objective-C application for the iPhone.
I decided not to use storyboards for the application to save bit of time, but also because if it were to grow to a large application with multiple developers it would be easier to manage in source control. 

AFNetworking is integrated via Cocoapods and has been included in the repository to make it easier for reviewer.

## Assumptions
The below are the assumptions for the application:
- It is an iOS 9 iPhone only application
- It does not work if the application is running in the background

## Other Comments
Due to time constraints the following have not been done as part of this exercise, but would be part of subsequent revisions/releases:
- Security: has not been entirely reviewed, we should review whether the client id and client key should be secured and implement SSL certificate pinning.
- Accessibility features: handling dynamic font sizes to resize the fonts in accordance with what the user has specified in their device's settings
- Review how often the application will update coffee shops and the accuracy of the current location considering battery life
- Need to cater for different device orientations
- Cater for saving, loading for different application states

