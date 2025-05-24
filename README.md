## Blog Viewer iOS App

This is a simple iOS app built with UIKit to display a list of blogs fetched from a remote API. The app uses modern libraries for networking, image loading, and UI enhancements to provide a smooth user experience.

## Features

- Fetch blogs from a REST API using Alamofire  
- Display blog images asynchronously with Kingfisher  
- Show a loading spinner using NVActivityIndicatorView while data is loading  
- Swipe table view cells to delete blogs  
- Edit blog details with a modal sheet dialog presentation
- Add blog with navigation controller.
- Smooth and responsive UI with UIKit components  

## Requirements

- iOS 14.0+  
- Xcode 12+  

## How It Works

1. When the app launches, it requests the list of blogs from the API asynchronously.  
2. While loading, a spinner from NVActivityIndicatorView is shown.  
3. Blogs are displayed in a table view with images loaded via Kingfisher for smooth scrolling.  
4. Users can swipe a blog cell to reveal a delete action.  
5. Tapping a blog allows editing details in a modal sheet dialog.
6. Tapping a Add Your Own Blog button in home allows navigate to blog details screen and edit.

## Libraries Used

- Alamofire — For handling network requests and responses easily.  
- Kingfisher — For loading images from URLs.  
- NVActivityIndicatorView — For displaying attractive loading animations.
- IQKeyboardManagerSwift - For handle Keyboard

## Usage

- Run the app.  
- Blogs will be loaded automatically.  
- Swipe a cell to delete.  
- Tap a blog to edit details in a modal dialog.  



## Screenshots
![WhatsApp Image 2025-05- 08 06 27](https://github.com/user-attachments/assets/bdeb65a5-dd5e-4639-a3d0-8d3647bd49fb)
![WhatsApp Image 2025-05-24 at 08 06 27](https://github.com/user-attachments/assets/6eb4df0b-c451-48cd-a998-b4e94cb486bd)
