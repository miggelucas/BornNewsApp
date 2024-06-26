
# News App

This repository contains the source code for a news application developed as a technical challenge proposed by [Bornlogic](https://www.linkedin.com/company/bornlogic/) for the position of Mid-Level iOS Developer. Although the position was canceled by the company, I decided to archive this project in my portfolio due to my interest in the challenge and the opportunity to demonstrate my skills.

## Project Overview

The News App is a simple news reader application that consumes data from the [NewsAPI](https://newsapi.org/). Through this project, I practiced and demonstrated various iOS development skills, including:

- **Reactivity**: Utilizing reactive programming techniques for event handling.
- **Protocol-Oriented Programming**: Applying principles of protocol-oriented programming to create flexible and modular code.
- **Testing**: Writing unit and integration tests to ensure code reliability and correctness.
- **Clean Architecture**: Implementing clean architecture principles to maintain a scalable and maintainable codebase.

## Features

- Fetch and display the latest news articles from NewsAPI.
- View detailed information about selected articles.

## Technologies Used

- **Swift**: The primary programming language for iOS development.
- **URLSession**: To handle API requests and network communication.
- **XCTest**: For writing and executing unit and integration tests.
- **MVVM Architecture**: To separate concerns and facilitate testing and maintenance.


### Running the App

1. Open `NewsApp.xcodeproj` in Xcode.
2. Select a target device or simulator.
3. Build and run the project using the `Cmd + R` shortcut.

### Configuration

To fetch news articles, you need to obtain an API key from [NewsAPI](https://newsapi.org/). Once you have the key, add it to the project's configuration (or just mine. I don't care):

1. Open `Config.swift` file.
2. Replace the placeholder API key with your actual API key:
   ```swift
   static let apiKey = "YOUR_API_KEY"
   ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contact

For any questions or inquiries, please contact me at [your email address].

