class CommonModel {
  String icon;
  String title;
  String url;
  String statusBarColor;
  bool hideAppBar;

  CommonModel();

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    CommonModel commonModel = CommonModel();
    commonModel.icon = json['icon'];
    commonModel.title = json['title'];
    commonModel.url = json['url'];
    commonModel.statusBarColor = json['statusBarColor'];
    commonModel.hideAppBar = json['hideAppBar'];
    return commonModel;
  }
}
