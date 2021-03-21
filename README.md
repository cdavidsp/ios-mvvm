# iOS App using Clean Architecture and MVVM 

iOS Project implemented with Clean Layered Architecture and MVVM. 

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
* [Dependency Injection]
* [Flow Coordinator]
* [Data Transfer Object (DTO)]
* [Response Data Caching]
* [ViewController Lifecycle Behavior]
* [SwiftUI and UIKit view] implementations by reusing same [ViewModel] (at least Xcode 11 required)
* Error handling examples: in [ViewModel], in [Networking]

## Includes

* [Unit Tests]
* Unit Tests for Use Cases(Domain Layer), ViewModels(Presentation Layer), NetworkService(Infrastructure Layer)
* UI test with XCUITests
* Size Classes and UIStackView in Detail view
* Dark Mode

## Requirements

* Xcode Version 11.2.1+  Swift 5.0+
