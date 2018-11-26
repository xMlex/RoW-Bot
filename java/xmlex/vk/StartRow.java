package xmlex.vk;

import ru.xmlex.common.ConfigSystem;
import xmlex.common.ThreadPoolManager;
import xmlex.extensions.database.L2DatabaseFactory;
import xmlex.vk.row.RowClient;
import xmlex.vk.row.model.StaticData;

import java.sql.SQLException;
import java.util.logging.Logger;

public class StartRow {
    private static final Logger _log = Logger.getLogger(StartRow.class.getName());

    public static void main(String[] args) throws SQLException {
        ConfigSystem.load();
        ThreadPoolManager.getInstance();
        L2DatabaseFactory.getInstance();
        _log.info("*** ESTART ***");
        StaticData.getInstance();
        // Rikardo
        RowClient _client = new RowClient();
        _client.getVkInfo().authKey = "c91bca687e4cc9d4a9cfbcc918553cfc";
        _client.getVkInfo().userId = 226717686;
        _client.getVkInfo().fName = "Ivan";
        _client.getVkInfo().lName = "Ricardo";
        _client.getVkInfo().photo = "http://cs304206.vk.me/v304206686/5df1/L5Nr5UPEqF8.jpg";
        _client.go();

        RowClient _c1 = new RowClient();
        _c1.getVkInfo().photo = "http://cs305513.vk.me/v305513458/638b/vUqARs8JNPg.jpg";
        _c1.getVkInfo().authKey = "9c88e1cdb17c5a137e85f9b57aaac8a0";
        _c1.getVkInfo().userId = 42937458;
        _c1.getVkInfo().fName = "Alexandra";
        _c1.getVkInfo().lName = "Petrova";
        _c1.go();
        // Nasty
        RowClient _c2 = new RowClient();
        _c2.getVkInfo().photo = "http://cs305206.vk.me/v305206803/4478/H0jjK343lVA.jpg";
        _c2.getVkInfo().authKey = "af89c674d91cd26083414277a6228d91";
        _c2.getVkInfo().userId = 209965803;
        _c2.getVkInfo().fName = "Anastasja";
        _c2.getVkInfo().lName = "Mihalenkowa";
        _c2.go();

        while (true) {
            try {
                Thread.sleep(10000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                _log.info("*** END with error ***");
            }
        }

    }

}
