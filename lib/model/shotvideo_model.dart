class ShortVideomodel {
  String url;
  String category;
  ShortVideomodel({required this.url,required this.category});

  ShortVideomodel.fromJson(Map<String, dynamic> parsedJSON)
      : url = parsedJSON['url'],
        category = parsedJSON['category'];

}