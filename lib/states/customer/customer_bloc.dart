import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gym/data/repositories/customer_repository.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/customer.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<CustomerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
