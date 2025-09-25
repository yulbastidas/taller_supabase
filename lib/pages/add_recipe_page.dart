import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';

class AddRecipePage extends StatelessWidget {
  final RecipeController controller = Get.find();

  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("➕ Nueva Receta")),
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
                  controller.addRecipe(name, ingredients);
                } else {
                  Get.snackbar("Error", "Todos los campos son obligatorios");
                }
              },
              icon: const Icon(Icons.save),
              label: const Text("Guardar Receta"),
            ),
          ],
        ),
      ),
    );
  }
}
