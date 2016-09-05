package dbl;

public class GeneralUtils {
  public static boolean querySkip(String query, String database) {
    if (query != null)
      if (database == null || !database.toLowerCase().contains(query.toLowerCase()))
        return true;
    return false;
  }
}
