# Srimad Bhagavad Gita iOS App

## App Demo 

https://youtu.be/b8b5fwlpdp4

This iOS app provides access to chapters of the Srimad Bhagavad Gita in both Hindi and English, featuring chapter images, a skeleton loading view, and data fetching via Alamofire using a generic model.

## Features

- **Multi-language support**: The app supports two languages: Hindi and English, allowing users to toggle between them for the content.
  
- **Chapters with Images**: Each chapter from the Srimad Bhagavad Gita is displayed along with its corresponding image, fetched from the backend API.

- **API Integration**: The app uses the Bhagavad Gita API provided by [bhagavad-gita3.p.rapidapi.com](https://rapidapi.com/) to fetch the chapters' data, including images and translations.

- **Skeleton Loading View**: While the chapters are being fetched from the API, a skeleton view is displayed to enhance the user experience by showing a placeholder loading state.

- **Alamofire with Generic Model**: Network calls are made using **Alamofire** with a generic model, allowing reusable and flexible API handling for different data types.

## Design Pattern

The app is structured using the **MVVM (Model-View-ViewModel)** design pattern, separating business logic from the UI to create a more modular, testable codebase.

This focuses primarily on the features you used, including multi-language support, Alamofire with a generic model, and skeleton loading views. You can adjust the repository link and API key details as needed for your project.


