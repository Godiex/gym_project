import '../../../core/use_case.dart';
import '../../../data/repositories/gym_owner_repository.dart';

class CreateGymOwnerUseCase extends UseCase {
  const CreateGymOwnerUseCase(this.repository);

  final GymOwnerRepository repository;

  @override
  Future call(gymOwner) {
    return repository.create(gymOwner);
  }
}
