class User {
  String? name;
  String? avatarUrl;
  String? bio;
  String? location;
  String? email;
  String? url;
  StarredRepositories? starredRepositories;

  User(
      {this.name,
      this.avatarUrl,
      this.bio,
      this.location,
      this.email,
      this.url,
      this.starredRepositories});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    bio = json['bio'];
    location = json['location'];
    email = json['email'];
    url = json['url'];
    starredRepositories = json['starredRepositories'] != null
        ? new StarredRepositories.fromJson(json['starredRepositories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['email'] = this.email;
    data['url'] = this.url;
    if (this.starredRepositories != null) {
      data['starredRepositories'] = this.starredRepositories!.toJson();
    }
    return data;
  }
}

class StarredRepositories {
  int? totalCount;
  List<Nodes>? nodes;

  StarredRepositories({this.totalCount, this.nodes});

  StarredRepositories.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((v) {
        nodes!.add(new Nodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.nodes != null) {
      data['nodes'] = this.nodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nodes {
  String? name;
  String? description;
  Stargazers? stargazers;

  Nodes({this.name, this.description, this.stargazers});

  Nodes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    stargazers = json['stargazers'] != null
        ? new Stargazers.fromJson(json['stargazers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.stargazers != null) {
      data['stargazers'] = this.stargazers!.toJson();
    }
    return data;
  }
}

class Stargazers {
  int? totalCount;

  Stargazers({this.totalCount});

  Stargazers.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    return data;
  }
}