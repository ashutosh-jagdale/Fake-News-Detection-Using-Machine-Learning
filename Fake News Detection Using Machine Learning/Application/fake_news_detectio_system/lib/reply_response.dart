// ignore: camel_case_types
class ReplyApi {
  final String finalResult;
  final String rr;
  final String spam;
  final String category;
  final String sentiment;
  final String toxicity;
  final String stance;
  final String clickbait;
  final String domain;
  final String political;

  ReplyApi({this.finalResult, this.rr, this.spam, this.category, this.sentiment, this.stance, this.toxicity, this.clickbait, this.domain, this.political});

  factory ReplyApi.fromJson(final json){
    return ReplyApi(
        finalResult: json['final'],
        rr : json['result'],
        spam : json['spam'],
    category : json['category'],
        sentiment : json['sentiment'],
        toxicity : json['toxicity'],
        stance : json['stance'],
        clickbait : json['clickbait'],
      domain : json['domain'],
      political : json['political'],);
  }
}


// class StudentModel{
//   final String name;
//   final String skill;
//   final String education;
//
//   StudentModel({this.name, this.skill, this.education});
//
//   factory StudentModel.fromJson(final json){
//     return StudentModel(
//         name: json["name"],
//         education: json["education"],
//         skill: json["skill"]
//     );
//   }
// }