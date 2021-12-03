class User {

  const User({required this.name, required this.image});

  final String name;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) => 
    User(
      name: json['username'], 
      image: json['image']
    );
}