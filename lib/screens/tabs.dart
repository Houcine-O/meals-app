import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedItemIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleFavMeals(Meal meal) {
    if (_favoriteMeals.contains(meal))
      _favoriteMeals.remove(meal);
    else
      _favoriteMeals.add(meal);
  }

  void _selectItem(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      toggleFav: _toggleFavMeals,
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
