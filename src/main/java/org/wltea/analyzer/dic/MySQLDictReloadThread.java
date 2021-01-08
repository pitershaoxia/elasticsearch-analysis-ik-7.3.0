package org.wltea.analyzer.dic;

import org.apache.logging.log4j.Logger;
import org.wltea.analyzer.help.ESPluginLoggerFactory;

/**
 * MySQLDictReloadThread Runnable实现类，去执行Dictionary.reLoadSQLDict() 加载热词
 *
 * created by yangyu on 2019-09-26
 */
public class MySQLDictReloadThread implements Runnable{

    private static final Logger logger = ESPluginLoggerFactory.getLogger(MySQLDictReloadThread.class.getName());

    @Override
    public void run() {
        while (true) {
            logger.info("[==========]reloading hot dict from mysql......");
            Dictionary.getSingleton().reLoadMainDict();
        }
    }
}
