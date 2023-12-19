import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/custom_drawer.dart';

import '../models/meal.dart';

const kFiltersMap = {
  Filters.Glutenfree: false,
  Filters.Lactosefree: false,
  Filters.Vegetarian: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedItemIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filters, bool> _selectedFilters = kFiltersMap;

  void _toggleFavMeals(Meal meal) {
    if (_favoriteMeals.contains(meal))
      setState(() {
        _favoriteMeals.remove(meal);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Recipe removed from your favorites",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ));
      });
    else
      setState(() {
        _favoriteMeals.add(meal);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Recipe added to your favorites",
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ));
      });
  }

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
    final filteredMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filters.Glutenfree]! ||
          !meal.isLactoseFree && _selectedFilters[Filters.Lactosefree]! ||
          !meal.isVegetarian && _selectedFilters[Filters.Vegetarian]!) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      toggleFav: _toggleFavMeals,
      filteredMeals: filteredMeals,
    );

    if (_selectedItemIndex == 1)
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        toggleFav: _toggleFavMeals,
      );

    return Scaffold(
      appBar: AppBar(
        title: _selectedItemIndex == 1 ? Text('Favorites') : Text('Categories'),
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
