class CreateGymOwner {
  const CreateGymOwner({
    required this.names,
    required this.surnames,
    required this.email,
    required this.cellPhone,
    required this.user,
    required this.gym,
  });

  Map<String, dynamic> toJson() {
    return {
      'names': names,
      'surnames': surnames,
      'email': email,
      'cellPhone': cellPhone,
      'user': {
        'userName': user.userName,
        'password': user.password
      },
      'gym': {
        'name': gym.name,
        'address': gym.address,
      },
    };
  }

  final String names;
  final String surnames;
  final String email;
  final String cellPhone;
  final CreateUserGymOwner user;
  final CreateGym gym;
}

class CreateUserGymOwner {
  const CreateUserGymOwner({
    required this.userName,
    required this.password,
    required this.typeUser,
  });
  final String userName;
  final String password;
  final String typeUser;
}

class CreateGym {
  const CreateGym({
    required this.name,
    required this.address
  });
  final String name;
  final String address;
}
