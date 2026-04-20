import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/expenses/presentation/pages/home_page.dart';
import '../../features/expenses/presentation/pages/add_expense_page.dart';
import '../../features/expenses/presentation/pages/expenses_list_page.dart';
import '../../features/categories/presentation/pages/categories_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoginPage = state.uri.toString() == '/login';
      final isRegisterPage = state.uri.toString() == '/register';
      
      // If not authenticated and not on login/register page, redirect to login
      if (!isAuthenticated && !isLoginPage && !isRegisterPage) {
        return '/login';
      }
      
      // If authenticated and on login/register page, redirect to home
      if (isAuthenticated && (isLoginPage || isRegisterPage)) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/add-expense',
        builder: (context, state) => const AddExpensePage(),
      ),
      GoRoute(
        path: '/expenses',
        builder: (context, state) => const ExpensesListPage(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.toString()}'),
      ),
    ),
  );
});
