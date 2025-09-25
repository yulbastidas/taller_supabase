import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import 'add_recipe_page.dart';
import 'edit_recipe_page.dart';

class HomePage extends StatelessWidget {
  final RecipeController controller = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📖 Recetas con Supabase")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.recipes.isEmpty) {
          return const Center(child: Text("No hay recetas aún"));
        }

        return ListView.builder(
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.recipes[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(
                  recipe.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(recipe.ingredients),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => Get.to(() => EditRecipePage(recipe)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteRecipe(recipe.id!),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddRecipePage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
