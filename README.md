Flutter PayPal Payment App with Python Backend
This is a Flutter app that integrates PayPal payments using Braintree, with a Python Flask backend to handle the payment process. The app allows users to make payments directly within the app, without redirecting them to the browser.

Features
PayPal Integration: Users can make payments using PayPal without leaving the app.
Braintree Support: The app utilizes Braintree for secure payment processing.
Backend Integration: A Python Flask server is used to handle payment requests, generate PayPal client tokens, and process transactions.
Cross-Platform: Supports both Android and iOS.
Flutter State Management: Uses setState() for UI updates and managing payment flows.
Technologies Used
Flutter: Frontend framework for building cross-platform mobile apps.
Braintree: Payment gateway to handle PayPal transactions.
Python: Flask backend server for handling payments.
Dart: Programming language for Flutter.
Getting Started
Follow these steps to set up the app on your local machine.

Prerequisites
Flutter SDK installed: Flutter Installation Guide
Dart SDK installed (comes with Flutter)
Python 3.12+ installed: Python Installation Guide
Braintree Sandbox account with PayPal enabled
Braintree and PayPal API credentials (client ID, secret)
Flutter Setup
Clone the Repository:

bash
Copy code
git clone https://github.com/khalid-zsh/Flutter-PayPal-Payment-Python-Server.git
cd Flutter-PayPal-Payment-Python-Server
Install Dependencies:

Install the required Flutter packages by running the following command:

bash
Copy code
flutter pub get
Configure the App:

In your Flutter project, configure the braintree_flutter package with your Braintree Client Token.

Add your PayPal Client ID and Secret in the Flutter app:

dart
Copy code
const String paypalClientId = '<YOUR_PAYPAL_CLIENT_ID>';
const String paypalSecret = '<YOUR_PAYPAL_SECRET>';
Run the App:

Run the app on an emulator or a connected device:

bash
Copy code
flutter run
Python Backend Setup
Navigate to the Backend Folder:

bash
Copy code
cd backend
Install Python Dependencies:

Install required Python dependencies using pip:

bash
Copy code
pip install -r requirements.txt
Set Up Environment Variables:

Create a .env file in the backend directory to store your PayPal client ID and secret:

bash
Copy code
touch .env
Add your credentials:

makefile
Copy code
PAYPAL_CLIENT_ID=<YOUR_PAYPAL_CLIENT_ID>
PAYPAL_SECRET=<YOUR_PAYPAL_SECRET>
Run the Backend Server:

Start the Flask server:

bash
Copy code
python server.py
The backend server will be available at http://localhost:5000.

Usage
When the app starts, the backend generates a PayPal client token and sends it to the app.
Users can then make payments within the app.
The backend handles payment verification and transaction processing.
Folder Structure
bash
Copy code
.
├── backend                   # Python Flask backend folder
│   ├── server.py             # Backend server code
│   ├── requirements.txt      # Python dependencies
│   └── .env                  # Environment variables for PayPal credentials
├── lib                       # Flutter app code
│   ├── main.dart             # Main entry point of the app
│   ├── screens               # Flutter screens folder
│   ├── services              # Payment service logic
│   └── widgets               # Flutter widgets folder
├── pubspec.yaml              # Flutter project configuration
└── README.md                 # Project README file
PayPal/Braintree Integration Details
PayPal: The app uses PayPal’s Braintree SDK to process payments. The Python backend generates a client token that allows the frontend to initiate a transaction.
Braintree: The backend communicates with Braintree's API to securely handle payments.
Troubleshooting
Common Errors
Merchant account not found: Ensure that your Braintree and PayPal sandbox credentials are correct and that PayPal is enabled in your Braintree sandbox account.

Failed to push refs to GitHub: If you face issues with pushing to GitHub, check if you have the proper Git credentials configured on your machine.

Contributing
Feel free to fork this repository and submit pull requests if you would like to contribute!

License
This project is licensed under the MIT License.
