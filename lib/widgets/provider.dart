import 'package:provider/provider.dart';
import 'package:wallet/base/base_bloc.dart';

class CustomProvider<T extends BaseBloc> extends Provider<T> {
  CustomProvider({
    super.key,
    required super.create,
    super.child,
  }) : super(
          dispose: (context, value) => value.dispose(),
        );
}
