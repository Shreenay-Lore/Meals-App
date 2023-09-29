import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';
enum Filters{
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>>{
  FiltersNotifier() : super({
    Filters.glutenfree : false,
    Filters.lactosefree : false,
    Filters.vegetarian : false,
    Filters.vegan : false,
  });

  void setFilters(Map<Filters, bool> chosenFilters){
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive){
    state = {
      ...state,
      filter : isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref){
  return FiltersNotifier();
});


final fliteredMealsProvider = Provider((ref){
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal){
      if(activeFilters[Filters.glutenfree]! && !meal.isGlutenFree){
        return false;
      }
        if(activeFilters[Filters.lactosefree]! && !meal.isLactoseFree){
        return false;
      }
        if(activeFilters[Filters.vegetarian]! && !meal.isVegetarian){
        return false;
      }
        if(activeFilters[Filters.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
});