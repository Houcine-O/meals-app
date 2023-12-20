import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/favorite_meals_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/custom_drawer.dart';

const kFiltersMap = {
  Filters.Glutenfree: false,
  Filters.Lactosefree: false,
  Filters.Vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedItemIndex = 0;
  Map<Filters, bool> _selectedFilters = kFiltersMap;

  void _selectItem(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  void _selectDrawer(String screenId) async {
    Navigator.of(context).pop();
    if (screenId == 'filters') {
      final result = await Navigator.of(context)
          .push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (ctx) => FiltersScreen(
          initFilters: _selectedFilters,
        ),
      ));
      setState(() {
        _selectedFilters = result ?? kFiltersMap;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final filteredMeals = meals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filters.Glutenfree]! ||
          !meal.isLactoseFree && _selectedFilters[Filters.Lactosefree]! ||
          !meal.isVegetarian && _selectedFilters[Filters.Vegetarian]!) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      filteredMeals: filteredMeals,
    );

    if (_selectedItemIndex == 1) {
      var favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _selectedItemIndex == 1
            ? const Text('Favorites')
            : const Text('Categories'),
      ),
      drawer: CustomDrawer(onSelectDrawer: _selectDrawer),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItemIndex,
        onTap: (index) {
          _selectItem(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
