abstract class ProductEvent {}

class FetchProduct extends ProductEvent {
  int catIndex;
  FetchProduct({required this.catIndex});
}


