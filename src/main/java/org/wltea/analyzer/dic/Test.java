package org.wltea.analyzer.dic;

import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;

/**
 * created by yangyu on 2019-09-30
 */
public class Test {

    public static void main(String...args){
        String today = "hot_search_word" + LocalDateTime.now().toString(DateTimeFormat.forPattern("yyyyMMdd"));
        String yestToday = "hot_search_word" + LocalDateTime.now().minusDays(1).toString(DateTimeFormat.forPattern("yyyyMMdd"));

        String existSQL = String.format("SHOW TABLES LIKE '%s'",yestToday);
        System.out.println(today + yestToday +existSQL);
    }
}
