import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/expense.dart';
import '../../../categories/domain/entities/category.dart';

class ExpenseState {
  final List<Expense> expenses;
  final bool isLoading;
  final String? error;

  const ExpenseState({
    this.expenses = const [],
    this.isLoading = false,
    this.error,
  });

  ExpenseState copyWith({
    List<Expense>? expenses,
    bool? isLoading,
    String? error,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  ExpenseNotifier() : super(const ExpenseState());

  // Mock data for now - in real app this would connect to backend
  final List<Expense> _mockExpenses = [];

  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime date,
    String description = '',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Create mock category
      final mockCategory = Category(
        id: category,
        name: category,
        description: '',
        color: '#6366F1',
        icon: 'category',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final expense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        amount: amount,
        category: mockCategory,
        date: date,
        userId: '1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      _mockExpenses.add(expense);
      
      state = state.copyWith(
        expenses: List.from(_mockExpenses),
        isLoading: false,
      );
      
      print('Expense added: ${expense.title} - \$${expense.amount}');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to add expense: $e',
      );
    }
  }

  Future<void> loadExpenses() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 300));
      
      state = state.copyWith(
        expenses: List.from(_mockExpenses),
        isLoading: false,
      );
      
      print('Loaded ${_mockExpenses.length} expenses');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load expenses: $e',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
  return ExpenseNotifier();
});
