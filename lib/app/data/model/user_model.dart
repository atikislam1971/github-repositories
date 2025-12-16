class UserModel {
  String? name;
  String? company;
  String? blog;
  String? location;
  Null email;
  String? bio;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {
        this.name,
        this.company,
        this.blog,
        this.location,
        this.email,
        this.bio,
        this.publicRepos,
        this.publicGists,
        this.followers,
        this.following,
        this.createdAt,
        this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    company = json['company'];
    blog = json['blog'];
    location = json['location'];
    email = json['email'];
    bio = json['bio'];
    publicRepos = json['public_repos'];
    publicGists = json['public_gists'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['company'] = company;
    data['blog'] = blog;
    data['location'] = location;
    data['email'] = email;
    data['bio'] = bio;
    data['public_repos'] = publicRepos;
    data['public_gists'] = publicGists;
    data['followers'] = followers;
    data['following'] = following;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
