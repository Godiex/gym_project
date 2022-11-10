import 'package:gym/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();

  Future<List<Item>> getItems({required int limit, required int page});
}

class ItemDefaultRepository extends ItemRepository {
  @override
  Future<List<Item>> getAllItems() async {
    List<Item> items = [
      Item(name: "prueba1", image: "image1", category: "category1", effect: "effect1"),
      Item(name: "prueba2", image: "image2", category: "category2", effect: "effect2"),
      Item(name: "prueba3", image: "image3", category: "category3", effect: "effect3")
    ];
    return items;
  }

  @override
  Future<List<Item>> getItems({required int limit, required int page}) async {
    List<Item> items = [
      Item(name: "prueba1", image: "image1", category: "category1", effect: "effect1"),
      Item(name: "prueba2", image: "image2", category: "category2", effect: "effect2"),
      Item(name: "prueba3", image: "image3", category: "category3", effect: "effect3")
    ];
    return items;
  }
}
