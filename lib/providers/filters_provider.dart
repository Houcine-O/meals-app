import 'package:flutter_riverpod/flutter_riverpod.dart';

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
