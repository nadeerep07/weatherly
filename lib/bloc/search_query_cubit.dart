import 'package:flutter_bloc/flutter_bloc.dart';

class SearchQueryCubit extends Cubit<String> {
  SearchQueryCubit() : super('');

  void updateQuery(String query) => emit(query);
  void clearQuery() => emit('');
}
