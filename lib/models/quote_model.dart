class QuoteModel {
  final String title;
  final String description;

  const QuoteModel({
    required  this.title,
    required this.description,
  });
  factory QuoteModel.fromJson(
    Map<String,dynamic> json,
  ){
      return QuoteModel(
        title: json["title"] ?? " ", 
        description: json["description"] ?? " ",
      );
  }
  QuoteModel copyWith({
    String? title,
    String ? description,
  }){
    return QuoteModel(
      title: title ?? this.title, 
      description: description?? this.description,
    );
  }
}
