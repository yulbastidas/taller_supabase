import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe.dart';

class EditRecipePage extends StatelessWidget {
  final Recipe recipe;
  final RecipeController controller = Get.find();

  EditRecipePage(this.recipe, {super.key});

  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = recipe.name;
    ingredientsController.text = recipe.ingredients;

    return Scaffold(
      appBar: AppBar(title: const Text("✏️ Editar Receta")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nombre de la receta",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(labelText: "Ingredientes"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final name = nameController.text.trim();
                final ingredients = ingredientsController.text.trim();
                if (name.isNotEmpty && ingredients.isNotEmpty) {
                  controller.updateRecipe(recipe.id!, name, ingredients);
                } else {
                  Get.snackbar("Error", "Todos los campos son obligatorios");
                }
              },
              icon: const Icon(Icons.update),
              label: const Text("Actualizar Receta"),
            ),
          ],
        ),
      ),
    );
  }
}
