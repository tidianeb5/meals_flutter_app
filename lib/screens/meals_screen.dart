import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key, required this.categoryId, required this.categoryTitle});

  final String categoryId;
  final String categoryTitle;

  List<Meal> _filterMealsByCategoryId() {
    return dummyMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final meals = _filterMealsByCategoryId();

    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'No meals were found',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 16),
        const Icon(Icons.fastfood_outlined, size: 100),
      ],
    ));

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: meals[index]);
        },
      );
    }

    print('${categoryTitle} has ${meals.length} meals');
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: content,
    );
  }
}
