class AppConstants {
  static const String appName = 'Smart Expense Manager';
  
  // API Configuration
  static const String baseUrl = 'http://localhost:3000/api';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String expensesKey = 'expenses';
  static const String categoriesKey = 'categories';
  
  // Hive Box Names
  static const String userBox = 'user_box';
  static const String expenseBox = 'expense_box';
  static const String categoryBox = 'category_box';
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';
}

class ApiEndpoints {
  static const String auth = '/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String refresh = '$auth/refresh';
  
  static const String expenses = '/expenses';
  static const String categories = '/categories';
  
  static const String analytics = '/analytics';
  static const String monthlyReport = '$analytics/monthly';
  static const String categoryReport = '$analytics/category';
}
