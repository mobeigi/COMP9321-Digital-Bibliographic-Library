package dbl;

public class GeneralUtils {
  /**
   * Determines if item should be skipped (because it failed to match query)
   * Limitations: Does not handle casefold comparisons for various special characters.
   *
   * @param query the query string
   * @param data the data being queried against
   * @return true if item should be skipped (match failed), false otherwise
   */
  public static boolean querySkip(String query, String data) {
    if (query != null)
      if (data == null || !data.toLowerCase().contains(query.toLowerCase()))
        return true;
    return false;
  }
  
  /**
   * Determines if item should be skipped (because it failed to match query).
   * In this case, there may be multiple queries (which all need to match).
   * In other words, for each query, there needs to be a match for some element
   * of data.
   *
   * @param query the query string
   * @param data the data being queried against
   * @return true if item should be skipped (match failed), false otherwise
   */
  public static boolean querySkipArray(String[] query, String[] data) {
    if (query.length  != 0) {
      if (data.length == 0) {
        return true;
      }
  
      //Iterate through queries
      for (String sQuery : query) {
        boolean found = false;
        
        //Iterate through data
        for (String sData : data) {
          if (!querySkip(sQuery, sData)) {  //delegate to querySkip for string,string comparisons
            found = true;
            break;
          }
        }
        
        //If we haven't found a match for this query then the entire match fails and we should skip
        if (!found)
          return true;
      }
    }
    
    return false;
  }
}
