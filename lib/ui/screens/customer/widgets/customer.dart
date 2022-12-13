import 'package:flutter/material.dart';
import 'package:gym/ui/screens/customer/sections/customer_list.dart';
import 'package:gym/ui/widgets/app_background.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen();

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: CustomerList(),
    );
  }
}
