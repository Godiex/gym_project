import 'package:gym/core/use_case.dart';
import '../../data/repositories/item_repository.dart';
import '../entities/item.dart';

class GetItemUseCase extends NoParamsUseCase<List<Item>> {
  const GetItemUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<List<Item>> call() {
    return repository.getAllItems();
  }
}
