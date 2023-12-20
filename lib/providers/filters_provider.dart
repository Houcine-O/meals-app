import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  Glutenfree,
  Lactosefree,
  Vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.Glutenfree: false,
          Filter.Lactosefree: false,
          Filter.Vegetarian: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (!meal.isGlutenFree && activeFilters[Filter.Glutenfree]! ||
        !meal.isLactoseFree && activeFilters[Filter.Lactosefree]! ||
        !meal.isVegetarian && activeFilters[Filter.Vegetarian]!) {
      return false;
    }
    return true;
  }).toList();
});
