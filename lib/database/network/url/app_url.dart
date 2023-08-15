class AppUrls {
  static String domain = "https://api.pexels.com";
  static final String _v1 = "$domain/v1";
  static final String search = "$_v1/search";
  static final String curated = "$_v1/curated";
  static String  getPhoto(int id) => "$_v1/photos/$id";
}
