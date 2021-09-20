const String token = "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";
const String URL_BASE="https://api.github.com/graphql";

const String body="""
  query ReadRepositories(\$nlogin: String!) {
  user(login:\$nlogin){
    name
    avatarUrl
    bio
    location
    email
    url
    starredRepositories{
      totalCount
      nodes{
        name
        description
       stargazers{
        totalCount
      }
      }
    }
}
    
}
""";
