package ru.xmlex.common.dbcp;

import com.j256.ormlite.jdbc.DataSourceConnectionSource;
import com.j256.ormlite.support.ConnectionSource;
import ru.xmlex.common.ConfigSystem;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BaseDatabaseFactory extends BasicDataSource {

    private static BaseDatabaseFactory instance;
    private ConnectionSource connectionSource;

    public static BaseDatabaseFactory getInstance() {
        if (instance == null)
            instance = new BaseDatabaseFactory();
        return instance;
    }

    public BaseDatabaseFactory() {
        super(ConfigSystem.DATABASE_DRIVER, ConfigSystem.DATABASE_URL, ConfigSystem.DATABASE_LOGIN, ConfigSystem.DATABASE_PASSWORD, ConfigSystem.DATABASE_MAX_CONNECTIONS, ConfigSystem.DATABASE_MAX_CONNECTIONS, ConfigSystem.DATABASE_MAX_IDLE_TIMEOUT, ConfigSystem.DATABASE_IDLE_TEST_PERIOD, false);
        try {
            connectionSource = new DataSourceConnectionSource(this, ConfigSystem.DATABASE_URL);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ConnectionSource getConnectionSource() {
        return connectionSource;
    }

    @Override
    public Connection getConnection() throws SQLException {
        return getConnection(null);
    }
}
