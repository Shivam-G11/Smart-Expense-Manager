# Smart Expense Manager

A production-ready expense tracking application built with Flutter and Node.js, featuring Clean Architecture, authentication, expense management, categories, and analytics.

## 🚀 Features

### MVP (Must-Have)
- ✅ **Authentication**: Login & Signup functionality
- ✅ **Expense Tracking**: Add, view, and manage expenses
- ✅ **Categories**: Organize expenses by categories
- ✅ **Clean Architecture**: Scalable and maintainable codebase

### V2 (Important) - Coming Soon
- 📊 **Charts**: Monthly analytics and visualizations
- 🔍 **Filters**: Advanced filtering options
- 📄 **Pagination**: Efficient data loading

### V3 (Advanced) - Coming Soon
- 📱 **Offline Support**: Sync data when online
- 🚨 **Budget Alerts**: Notifications for budget limits

## 🛠 Tech Stack

### Frontend (Flutter)
- **State Management**: Riverpod (modern + scalable)
- **Architecture**: Clean Architecture
- **Networking**: Dio
- **Local Database**: Hive
- **UI**: Material Design 3, ScreenUtil for responsive design
- **Navigation**: GoRouter

### Backend (Node.js)
- **Framework**: Express.js
- **Database**: MongoDB with Mongoose
- **Authentication**: JWT (JSON Web Tokens)
- **Security**: Helmet, CORS, Rate Limiting
- **Validation**: Express Validator

## 📁 Project Structure

```
smart_expense_manager/
├── lib/                          # Flutter source code
│   ├── src/
│   │   ├── core/                 # Core utilities and constants
│   │   │   ├── constants/        # App constants
│   │   │   ├── errors/          # Custom exceptions
│   │   │   ├── network/         # Network layer (Dio)
│   │   │   ├── theme/           # App themes
│   │   │   └── utils/           # Utility functions
│   │   ├── features/            # Feature modules
│   │   │   ├── auth/            # Authentication feature
│   │   │   ├── expenses/        # Expense management
│   │   │   └── categories/      # Category management
│   │   └── shared/              # Shared widgets and providers
│   └── main.dart               # App entry point
├── backend/                      # Node.js backend
│   ├── src/
│   │   ├── controllers/         # Route controllers
│   │   ├── models/             # MongoDB models
│   │   ├── routes/             # API routes
│   │   ├── middleware/         # Custom middleware
│   │   ├── utils/              # Utility functions
│   │   └── config/             # Configuration files
│   ├── package.json            # Node.js dependencies
│   └── .env.example            # Environment variables template
└── README.md                   # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>= 3.9.0)
- Node.js (>= 18.0.0)
- MongoDB (>= 5.0)
- Git

### 1. Clone the Repository
```bash
git clone <repository-url>
cd smart_expense_manager
```

### 2. Setup Backend

#### Install Dependencies
```bash
cd backend
npm install
```

#### Environment Configuration
```bash
cp .env.example .env
```

Edit `.env` file with your configuration:
```env
PORT=3000
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/smart_expense_manager
JWT_SECRET=your_super_secret_jwt_key_here
JWT_REFRESH_SECRET=your_super_secret_refresh_key_here
FRONTEND_URL=http://localhost:3000
```

#### Start MongoDB
Make sure MongoDB is running on your system.

#### Run Backend Server
```bash
# Development mode with auto-restart
npm run dev

# Production mode
npm start
```

The backend will be available at `http://localhost:3000`

### 3. Setup Flutter Frontend

#### Install Dependencies
```bash
cd ..  # Return to root directory
flutter pub get
```

#### Run Code Generation
```bash
flutter packages pub run build_runner build
```

#### Run the App
```bash
# Development mode
flutter run

# Release mode
flutter run --release
```

## 📱 Usage

### Authentication
- **Login**: Use email and password
- **Register**: Create a new account with name, email, and password
- **Mock Credentials**: Use `test@example.com` and `password` for testing

### Expense Management
- **Add Expense**: Navigate to home page and tap the + button
- **View Expenses**: Access from the home page quick actions
- **Categories**: Manage expense categories

### Navigation
- **Home**: Dashboard with quick actions and recent expenses
- **Add Expense**: Form to add new expenses
- **Expenses List**: View all expenses with filtering
- **Categories**: Manage expense categories

## 🧪 Testing

### Backend Tests
```bash
cd backend
npm test
```

### Flutter Tests
```bash
flutter test
```

## 📦 Build & Deployment

### Flutter Build
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

### Backend Deployment
```bash
cd backend
npm install --production
npm start
```

## 🔧 Configuration

### Environment Variables

#### Backend (.env)
- `PORT`: Server port (default: 3000)
- `NODE_ENV`: Environment (development/production)
- `MONGODB_URI`: MongoDB connection string
- `JWT_SECRET`: JWT signing secret
- `JWT_REFRESH_SECRET`: JWT refresh token secret
- `FRONTEND_URL`: Frontend URL for CORS

### Flutter Configuration

#### API Configuration
Edit `lib/src/core/constants/app_constants.dart`:
```dart
class AppConstants {
  static const String baseUrl = 'http://localhost:3000/api';
  // ... other constants
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Common Issues

#### MongoDB Connection Error
- Ensure MongoDB is running
- Check connection string in `.env` file
- Verify MongoDB is accessible on the specified port

#### Flutter Build Issues
- Run `flutter clean` and `flutter pub get`
- Ensure all dependencies are compatible with your Flutter version
- Check Android/iOS setup if building for mobile

#### Backend CORS Issues
- Verify `FRONTEND_URL` in `.env` matches your Flutter app URL
- Check that CORS middleware is properly configured

### Getting Help

- Check the [Issues](../../issues) page for known problems
- Create a new issue for bugs or feature requests
- Review the documentation in the code comments

## 🗺️ Roadmap

- [ ] Complete expense CRUD operations
- [ ] Implement category management
- [ ] Add analytics and charts
- [ ] Implement offline synchronization
- [ ] Add budget tracking and alerts
- [ ] Internationalization support
- [ ] Dark mode enhancements
- [ ] Export functionality (CSV, PDF)
- [ ] Recurring expenses
- [ ] Multi-currency support

## 📊 Architecture Decisions

### Clean Architecture
The project follows Clean Architecture principles with clear separation of concerns:
- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repositories

### State Management
Riverpod was chosen for:
- Compile-time safety
- Testability
- Flexibility
- Modern Flutter patterns

### Database Choices
- **MongoDB**: Flexible schema for expense data
- **Hive**: Fast local storage for offline support

---

Built with ❤️ using Flutter and Node.js
