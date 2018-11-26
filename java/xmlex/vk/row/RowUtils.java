package xmlex.vk.row;

import xmlex.extensions.database.DatabaseUtils;
import xmlex.extensions.database.FiltredStatement;
import xmlex.extensions.database.L2DatabaseFactory;
import xmlex.extensions.database.ThreadConnection;

import java.sql.ResultSet;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Logger;

public class RowUtils {

    private static final Logger _log = Logger.getLogger(RowUtils.class
            .getName());
    /**
     * id,pos
     */
    private static ConcurrentHashMap<Integer, Integer> static_map = null;

    public synchronized static boolean inStaticMap(int id) {

        if (static_map == null) {
            static_map = new ConcurrentHashMap<Integer, Integer>();

            String query = "select * from row_static_map ORDER BY `pos` ASC";

            ThreadConnection con = null;
            FiltredStatement statement = null;
            ResultSet rset = null;
            try {
                con = L2DatabaseFactory.getInstance().getConnection();
                statement = con.createStatement();
                rset = statement.executeQuery(query);
                while (rset.next())
                    static_map.put(rset.getInt("id"), rset.getInt("pos"));

            } catch (Exception e) {
                _log.warning("Could not execute query '" + query + "': " + e);
                e.printStackTrace();
            } finally {
                DatabaseUtils.closeDatabaseCSR(con, statement, rset);
            }
        }

        for (Entry<Integer, Integer> el : static_map.entrySet())
            if (el.getKey() == id)
                return true;

        return false;
    }
}
