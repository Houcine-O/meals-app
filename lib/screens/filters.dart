import 'package:flutter/material.dart';

enum Filters {
  Glutenfree,
  Lactosefree,
  Vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.initFilters});
  final Map<Filters, bool> initFilters;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  var _glutenfreeFilter = false;
  var _lactosefreeFilter = false;
  var _vegetarianFilter = false;

  @override
  void initState() {
    super.initState();
    _glutenfreeFilter = widget.initFilters[Filters.Glutenfree]!;
    _lactosefreeFilter = widget.initFilters[Filters.Lactosefree]!;
    _vegetarianFilter = widget.initFilters[Filters.Vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filters.Glutenfree: _glutenfreeFilter,
            Filters.Lactosefree: _lactosefreeFilter,
            Filters.Vegetarian: _vegetarianFilter
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenfreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _glutenfreeFilter = isChecked;
                });
              },
              title: Text(
                'Gluten free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include gluten free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactosefreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _lactosefreeFilter = isChecked;
                });
              },
              title: Text(
                'Lactose free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilter = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
