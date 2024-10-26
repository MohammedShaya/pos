abstract class CategoryEvent {}

class FetchCategory extends CategoryEvent {
}

class SelectCategory extends CategoryEvent {
   final int indexCategory;
   SelectCategory({required this.indexCategory});
}
