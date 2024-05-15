import 'package:nf_og/model/catergory.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel(
    categoryName: 'Business',
    imageUrl:
        'https://th.bing.com/th/id/R.fe4f6dd5bdc8d666dbe3f1ea6ef13de0?rik=v%2f2b0%2bYGSAwXHQ&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2fc%2f5%2fc%2f293356.jpg&ehk=HdClrQRPLLGvSRvuISQh%2f%2b4AQfcjbeToPYF8Jf1hLI4%3d&risl=&pid=ImgRaw&r=0',
  );

  category.add(categoryModel);

  categoryModel = CategoryModel(
    categoryName: 'Entertainment',
    imageUrl:
        'https://images.unsplash.com/photo-1499364615650-ec38552f4f34?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1372&q=80',
  );

  category.add(categoryModel);

  // categoryModel = CategoryModel(
  //   categoryName: 'General',
  //   imageUrl:
  //       'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',
  // );

  // category.add(categoryModel);

  categoryModel = CategoryModel(
    categoryName: 'Health',
    imageUrl:
        'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=799&q=80',
  );

  category.add(categoryModel);

  categoryModel = CategoryModel(
    categoryName: 'Science',
    imageUrl:
        'https://images.unsplash.com/photo-1507413245164-6160d8298b31?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  );

  category.add(categoryModel);

  categoryModel = CategoryModel(
    categoryName: 'Sports',
    imageUrl:
        'https://images.unsplash.com/photo-1523497804259-88c4c134ca90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1288&q=80',
  );

  category.add(categoryModel);

  categoryModel = CategoryModel(
    categoryName: 'Technology',
    imageUrl:
        'https://www.dailyliberal.com.au/images/transform/v1/crop/frm/gQFChmftLwURjFztaywNzt/039904c8-21e3-4a96-abbf-56d077f24687.jpg/r0_568_5809_3834_w1200_h678_fmax.jpg',
  );

  category.add(categoryModel);

  return category;
}
