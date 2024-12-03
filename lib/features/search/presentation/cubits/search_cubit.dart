import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_kevin_salazar/features/search/domain/search_repo.dart';
import 'package:social_app_kevin_salazar/features/search/presentation/cubits/search_states.dart';

class SearchCubit extends Cubit<SearchStates>{
  final SearchRepo searchRepo;


  SearchCubit({required this.searchRepo}): super(SearchInitial());

  Future<void> searchUsers(String query)async {
    if (query.isEmpty){
      emit(SearchInitial());
      return;
    }

    try {
      
      emit(SearchLoading());
      final users = await searchRepo.searchUsers(query);
      emit(SearchLoaded(users));
    }

    catch(e){
      emit(SearchError("Erro fetching search results"));
    }
    
  }

}