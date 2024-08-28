# NYTimesArticlesApp

## NewYork Times Most Popular Articles

---

## Overview

The NYTimesArticlesApp is an iOS application designed with Clean Architecture, leveraging MVVM, Repository, and Coordinator patterns to deliver a modular, testable, and maintainable codebase with robust features like image caching, dark mode support, and comprehensive error handling.

---

## Features

### 1. Clean Architecture

The app follows Clean Architecture principles, ensuring a modular, testable, and maintainable codebase through clear separation of concerns.

### 2. MVVM Pattern

Utilizes the MVVM pattern to decouple UI from business logic, promoting easier testing and maintenance by structuring the app into Model, View, and ViewModel layers.

### 3. Repository Pattern

Implements the Repository pattern to abstract data sources, providing a consistent API for the ViewModel and enabling flexible data management.

### 4. Coordinator Pattern

Navigation is managed using the Coordinator pattern, centralizing navigation logic and enhancing the modularity and testability of view controllers.

### 5. Image Caching

Incorporates thread-safe image caching to reduce network requests, improving performance and user experience.

### 6. Dark Mode Support

The app adapts seamlessly to dark mode, ensuring a consistent and visually appealing experience aligned with the user’s system preferences.

### 7. Error Handling

Features robust error handling to maintain app stability, providing user-friendly messages when issues arise.

### 8. Comprehensive Testing

Includes extensive unit tests to ensure high reliability and correctness, with a strong focus on core components like ViewModels, Repositories, and Coordinators.

---

## Test Cases

### Overview

The NYTimesArticlesApp includes comprehensive unit and UI tests to ensure the robustness and reliability of the application. The tests cover critical components such as network operations, data repositories, view models, image caching, coordinators, and the user interface.

### How to Run Tests and Generate Coverage Report

1. **Open the Project**: Open the `NYTimesArticlesApp.xcodeproj` file in Xcode.

2. **Select the Test Target**:
   - For network-related tests, select the `NYTimesArticlesAppTests` target.
   - For repository and view model tests, select the `NYTimesArticlesAppTests` target.
   - For UI-related tests, select the `NYTimesArticlesAppUITests` target.

3. **Run the Tests**:
   - Build and run the tests by choosing `Product` -> `Test` from the Xcode menu bar, or by pressing `Cmd + U`.
   - Xcode will execute the tests and display the results and coverage report in the Test Navigator and console output.

---

### Unit Tests

#### **Mock Network Tests**

- **`testSuccessfulAPICall`**: Verifies that the `MockNetworkManager` successfully fetches articles from the API. This test decodes the mock JSON data and checks that the correct number of articles is returned, and that the first article’s title matches the expected value.

- **`testAPICallFailure`**: Simulates a network failure scenario by configuring the `MockNetworkManager` to return an error. This test ensures that the app correctly handles the error, verifies that the error domain and code match the expected values, and that an appropriate error message is returned.

#### **Mock Repository Tests**

- **`testFetchArticlesFromNetworkSuccess`**: Ensures that the `ArticlesRepository` successfully retrieves articles from the network, verifies the correct number of articles, and checks that the returned data is non-nil and accurate.

- **`testFetchArticlesFromLocalDatabase`**: Tests the `ArticlesRepository` for fetching articles from a local database first, ensuring that the network manager is not called if data is available locally. Verifies that the correct data is returned from the local data source.

#### **ArticlesViewModel Tests**

- **`testFetchArticlesSuccess`**: Verifies that the `ArticlesViewModel` successfully loads articles when the repository fetches data correctly, ensuring that the returned articles match the expected data.

- **`testFetchArticlesFailure`**: Ensures that the `ArticlesViewModel` properly handles errors during data fetching by setting an appropriate error message and confirming that no articles are loaded.

#### **Image Cache Tests**

- **`testImageCaching`**: Verifies that an image is correctly cached and can be retrieved from the cache, ensuring that the cached image matches the original image.

- **`testCacheMiss`**: Confirms that a cache miss correctly returns `nil` when attempting to retrieve an image using a non-existent key.

- **`testImageCachingAndRetrieval`**: Ensures that an image can be cached and later retrieved from the cache, even after the image view is cleared, verifying the integrity of the cached data.

#### **Request Factory Tests**

- **`testBaseURLComponents`**: Verifies that the base URL components, including the scheme and host, are correctly set to the expected values for New York Times API requests.

- **`testBaseURLRequest`**: Ensures that the `NYTimesRequestFactory` creates a base URL request with the correct URL and sets the "Content-type" header to "application/json".

#### **Coordinator Tests**

- **`testStartSetsRootViewController`**: Verifies that the `ArticlesCoordinator` correctly sets the root view controller to `ArticlesViewController` when it starts, ensuring that the ViewModel and Coordinator are properly initialized.

- **`testShowArticleDetailsPushesDetailsViewController`**: Ensures that when the coordinator triggers navigation to the article details, the `ArticleDetailViewController` is pushed onto the navigation stack with the correct ViewModel and Coordinator.

- **`testNavigationFlow`**: Validates the complete navigation flow, ensuring that after navigating from the articles list to the details view, the correct sequence of view controllers is present in the navigation stack.

---

### UI Tests

- **`testTitleMatchBetweenListAndDetail`**: Verifies that the title of an article displayed in the list matches the title shown on the detail page after tapping on the article, ensuring consistency between the list and detail views.

---

### How to Generate and Access the Coverage Report

1. **Enable Code Coverage**: Ensure that code coverage is enabled in your Xcode project settings.

2. **Run Tests**: Run the tests using `Cmd + U` as described above.

3. **View Coverage**: Open the `Report Navigator` in Xcode (`Cmd + 9`) and select the `Coverage` tab to view detailed coverage metrics.

4. **Export Coverage**:
   - Use the following command to export the coverage report to a file:

     ```bash
     xcrun xccov view --archive /path/to/your/.xcresult/file.xcresult > docs/coverage.txt
     ```

   - This will create a `coverage.txt` file in the `docs` directory of your project.

