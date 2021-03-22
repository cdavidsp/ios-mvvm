# iOS App using Clean Architecture and MVVM

Demo iOS app implemented with Clean Layered Architecture and MVVM that consume [3 endpoints]:

- https://jsonplaceholder.typicode.com/posts
- https://jsonplaceholder.typicode.com/users
- https://jsonplaceholder.typicode.com/comments

The app have two screens:

- A first screen to present a list of posts.
- A second screen presenting post details.

The first time the app will get all data from API, and store that in a local DB,
and register the timestamp of the last call per endpoint.

The data in local DB will be active for 5 minutes, during this time if the user
open one screen the app doesn't call to API.

After the expiration of data(more of 5 minutes), if the user open one screen, the
app will call to API again and update local DB.

## Layers

* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views

### Dependency Direction

![Alt text](README_FILES/CleanArchitectureDependencies.png?raw=true "Modules Dependencies")

**Note:** **Domain Layer** should not include anything from other layers(e.g Presentation — UIKit  or Data Layer — Mapping Codable)

## Architecture concepts used here

* Clean Architecture https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
* Advanced iOS App Architecture https://www.raywenderlich.com/8477-introducing-advanced-ios-app-architecture
* [MVVM]
* Data Binding using [Observable] without 3rd party libraries
* [Dependency Injection] with `Swinject`
* [Networking] with `Alamofire`
* [Data Transfer Object (DTO)]
* [Response Data Caching]
* [ViewController Lifecycle Behavior]
* [UIKit view]
* [ViewModel] (at least Xcode 11 required)
* Error handling examples: in [ViewModel], in [Networking]

## Includes

* [Unit Tests]
* Unit Tests for Use Cases(Domain Layer), ViewModels(Presentation Layer)
* UI test with XCUITests

## How to run the Demo?

1. Clone this repo
2. Open shell window and navigate to project folder
3. Run `pod install`
4. Open `CleanMVVM.xcworkspace`  and run / test the project

## Requirements

* Xcode Version 11.2.1+  Swift 5.0+
