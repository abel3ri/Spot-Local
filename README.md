# Spot-Local

Spot-Local is a mobile application developed using Flutter that allows users to discover local businesses and services based on their location. The app integrates with various APIs and uses `flutter_map` for mapping functionalities, making it easy for users to locate and learn about nearby businesses with ease. 

## Features

- **Map Integration**: Uses `flutter_map` to display businesses on an interactive map based on user location.
- **Business Directory**: Lists businesses with details, including category and location, to help users make informed choices.
- **Multi-Language Support**: Supports multiple languages, catering to users from diverse backgrounds.
- **State Management**: Manages application state effectively with GetX, ensuring smooth and responsive UI interactions.
- **API Integration**: Pulls data from external sources to provide up-to-date information about businesses and services.
- **User-Friendly UI**: Intuitive design that makes it easy for users to search and navigate between different businesses.

## Tech Stack

- **Framework**: Flutter
- **State Management**: GetX
- **Mapping**: flutter_map
- **Routing/Direction**: OSRM
- **Backend**: Express.js
- **Database**: PostgreSQL
- **ORM**: Sequelize.js
- **Image Storage**: Cloudinary

### Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/abel3ri/Spot-Local.git
    cd spot-local
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

3. Run the app:

    ```bash
    flutter run
    ```

## Folder Structure

Here's an overview of the main folders and files in the project:

```plaintext
Spot-Local/
├── lib/
│   ├── app/
│   │   ├── modules/                # App modules and feature-specific logic
│   │   └── data/
│   │       ├── models/             # Data models
│   │       ├── providers/          # State management providers
│   │       └── repositories/       # Data repositories for handling API calls and data storage
│   ├── core/
│   │   ├── utils/                  # Utility classes and helper functions
│   │   ├── widgets/                # Reusable UI components
│   │   ├── controllers/            # Controllers for handling business logic
│   │   └── services/               # API services and backend integrations                   
├── pubspec.yaml                    # Flutter project configuration
└── README.md                       # Project README file
```
# Screens

<img src="https://github.com/user-attachments/assets/465ab438-fa7a-4894-a62a-327ad6527e60" alt="Image 1" width="400" height="400">
<img src="https://github.com/user-attachments/assets/32c39149-2d15-426f-a872-031dbd67e814" alt="Image 2" width="400" height="400">
<img src="https://github.com/user-attachments/assets/b1dc0208-f91a-41f8-8718-f653ef6a8c50" alt="Image 3" width="400" height="400">
<img src="https://github.com/user-attachments/assets/f71da4f5-94fc-44dd-b3be-fe25e01e9a65" alt="Image 4" width="400" height="400">
<img src="https://github.com/user-attachments/assets/9f590e9d-f700-46b5-9a87-ffcc901bf424" alt="Image 5" width="400" height="400">
<img src="https://github.com/user-attachments/assets/afb831b3-b0b6-45d3-a946-7ebfb78a61c5" alt="Image 6" width="400" height="400">
<img src="https://github.com/user-attachments/assets/1e5dfa4e-5469-4f2b-a9d5-836cd0a1ba6f" alt="Image 7" width="400" height="400">
<img src="https://github.com/user-attachments/assets/54f625de-eab8-4776-b3fd-dde98e378dd1" alt="Image 8" width="400" height="400">
<img src="https://github.com/user-attachments/assets/04541c00-c511-4a91-965a-b36d8ac8b649" alt="Image 9" width="400" height="400">
<img src="https://github.com/user-attachments/assets/115ad82e-0181-45ff-a014-95ea3cdfdbaf" alt="Image 10" width="400" height="400">
<img src="https://github.com/user-attachments/assets/d27e1627-9b6a-49ff-892a-1d1876a36301" alt="Image 11" width="400" height="400">
<img src="https://github.com/user-attachments/assets/53e1d813-9a25-42f2-b922-362e5c60134a" alt="Image 12" width="400" height="400">
<img src="https://github.com/user-attachments/assets/6ed0d818-9698-4979-8b56-1f7c710239d6" alt="Image 13" width="400" height="400">
<img src="https://github.com/user-attachments/assets/a54a8236-b026-4568-8550-8023b16d91f4" alt="Image 14" width="400" height="400">
<img src="https://github.com/user-attachments/assets/72feb9da-9252-4e39-8211-1484afc73c8f" alt="Image 15" width="400" height="400">
<img src="https://github.com/user-attachments/assets/c4f4ee91-9f74-4257-8b9b-8918834e88d4" alt="Image 16" width="400" height="400">
<img src="https://github.com/user-attachments/assets/9db977b0-5406-4678-8e37-cbed5bf7d433" alt="Image 17" width="400" height="400">
<img src="https://github.com/user-attachments/assets/1389d063-10a8-4ea7-b585-effc464b773b" alt="Image 18" width="400" height="400">
<img src="https://github.com/user-attachments/assets/fd1dbbf8-c913-4b9b-8467-66a052327beb" alt="Image 19" width="400" height="400">
<img src="https://github.com/user-attachments/assets/1b7edf9d-7649-45b9-88b3-6868f9c4a192" alt="Image 20" width="400" height="400">
<img src="https://github.com/user-attachments/assets/5471d69f-bca7-490e-bbcd-5d3248e41598" alt="Image 21" width="400" height="400">
<img src="https://github.com/user-attachments/assets/e56e03e7-019a-4b62-ab3e-e3365f1a42f7" alt="Image 22" width="400" height="400">
