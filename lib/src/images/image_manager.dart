class ImageApp{
  static String icCheck = ImagesPath.getPath('check.png');
  static String icMinus = ImagesPath.getPath('minus.png');
  static String logoNike = ImagesPath.getPath('nike.png');
  static String icPlus = ImagesPath.getPath('plus.png');
  static String icTrash = ImagesPath.getPath('trash.png');
}

extension ImagesPath on ImageApp {
  static String getPath(String name) {
    if (name.contains('.svg')) {
      return 'assets/svg/$name';
    }
    if (name.contains('.png')) {
      return 'assets/images/$name';
    }
    if (name.contains('.json')) {
      return 'assets/json/$name';
    }
    return 'assets/images/$name';
  }
}