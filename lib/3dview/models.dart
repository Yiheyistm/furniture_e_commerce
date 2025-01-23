import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/3dview/arview.dart';

class Model {
  final String name;
  final String imageUrl;
  final String modelUrl;

  Model({required this.name, required this.imageUrl, required this.modelUrl});
}

class ThreeDModelsList extends StatelessWidget {
  final List<Model> models = [
    Model(
      name: 'Trial',
      imageUrl: 'assets/models/couch.png',
      modelUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    ),
    Model(
      name: 'Chair',
      imageUrl: 'assets/models/couch.png',
      modelUrl: 'assets/models/couch.glb',
    ),
    Model(
      name: 'Couch Sofa',
      imageUrl: 'assets/models/Koltuk1.png',
      modelUrl: 'assets/models/koltuksofa.glb',
    ),
    Model(
      name: 'Modern - Chair',
      imageUrl: 'assets/models/modern-chair.png',
      modelUrl: 'assets/models/modern-chair.glb',
    ),
    Model(
      name: 'Office - Chair',
      imageUrl: 'assets/models/Office chair_1.jpg',
      modelUrl: 'assets/models/office_chair.glb',
    ),
    Model(
      name: 'Chair',
      imageUrl: 'assets/models/Office chair_1.jpg',
      modelUrl: 'https://modelviewer.dev/shared-assets/models/Chair.glb',
    ),
    // Add more models here
  ];

  ThreeDModelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Furniture Models'),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) {
            final model = models[index];
            return Card(
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    model.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  model.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FurnitureARview(
                        modelUrl: model.modelUrl,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
