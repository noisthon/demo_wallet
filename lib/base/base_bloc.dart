import 'package:wallet/repositories/auth_repositories.dart';

abstract class BaseBloc {
  final repository = Repository();

  void dispose();
}
