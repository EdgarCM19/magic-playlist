class SpotifyAuth {

  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final String scope;

  const SpotifyAuth({ required this.accessToken, required this.tokenType, required this.refreshToken, required this.scope });
  
  factory SpotifyAuth.fromJson(Map<String, dynamic> json){
    return SpotifyAuth(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      refreshToken: json['refresh_token'],
      scope: json['scope']
    );
  }

}