import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onSelectDrawer});

  final Function(String screenId) onSelectDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(children: [
            Icon(
              Icons.fastfood,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              width: 18,
            ),
            Text(
              "Cooking Up!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ]),
        ),
        ListTile(
          leading: Icon(
            Icons.restaurant,
            size: 34,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            "Recipes",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24),
          ),
          onTap: () {
            onSelectDrawer('recipes');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 34,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            "Filters",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24),
          ),
          onTap: () {
            onSelectDrawer('filters');
          },
        ),
      ]),
    );
  }
}
