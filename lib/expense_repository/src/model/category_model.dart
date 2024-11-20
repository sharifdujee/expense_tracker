import '../entities/category_entity.dart';

class MyCategory{
  String categoryId;
  String name;
  int totalExpense;
  String icon;
  int color;

  MyCategory({
    required this.categoryId,
    required this.name,
    required this.totalExpense,
    required this.icon,
    required this.color
});

  static final empty = MyCategory(categoryId: '', name: '', totalExpense: 0, icon: '', color: 0);

  CategoryEntity toEntity(){
    return CategoryEntity(
      categoryId : categoryId,
      name: name,
      totalExpense : totalExpense,
      icon : icon,
      color: color

    );
  }

  static MyCategory fromEntity(CategoryEntity entity){
    return MyCategory(categoryId: entity.categoryId,
        name: entity.name,
        totalExpense: entity.totalExpense
        , icon: entity.icon,
        color: entity.color);
  }
}