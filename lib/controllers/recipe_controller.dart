import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';

class RecipeController extends GetxController {
  final supabase = Supabase.instance.client;

  var recipes = <Recipe>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('recipes').select();
      recipes.value = response
          .map((r) => Recipe.fromJson(r))
          .toList()
          .cast<Recipe>();
    } catch (e) {
      Get.snackbar("Error", "No se pudieron cargar las recetas");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addRecipe(String name, String ingredients) async {
    try {
      await supabase.from('recipes').insert({
        'name': name,
        'ingredients': ingredients,
      });
      fetchRecipes();
      Get.back();
      Get.snackbar("Éxito", "Receta agregada correctamente");
    } catch (e) {
      Get.snackbar("Error", "No se pudo guardar la receta");
    }
  }

  Future<void> updateRecipe(int id, String name, String ingredients) async {
    try {
      await supabase
          .from('recipes')
          .update({'name': name, 'ingredients': ingredients})
          .eq('id', id);
      fetchRecipes();
      Get.back();
      Get.snackbar("Éxito", "Receta actualizada");
    } catch (e) {
      Get.snackbar("Error", "No se pudo actualizar la receta");
    }
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await supabase.from('recipes').delete().eq('id', id);
      recipes.removeWhere((r) => r.id == id);
      Get.snackbar("Éxito", "Receta eliminada");
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar la receta");
    }
  }
}
