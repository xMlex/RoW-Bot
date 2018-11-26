package ru.xmlex.common.dbcp;

import org.apache.commons.dbcp2.*;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;

import javax.sql.DataSource;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BasicDataSource implements DataSource {
    private final PoolingDataSource _source;
    private final GenericObjectPool<PoolableConnection> _connectionPool;

    /**
     * @param driver                 The fully qualified Java class name of the JDBC driver to be used.
     * @param connectURI             The connection URL to be passed to our JDBC driver to establish a connection.
     * @param uname                  The connection username to be passed to our JDBC driver to establish a connection.
     * @param passwd                 The connection password to be passed to our JDBC driver to establish a connection.
     * @param maxActive              The maximum number of active connections that can be allocated from this pool at the same time, or negative for no limit.
     * @param idleTimeOut            The minimum amount of time connection may stay in pool (in seconds)
     * @param idleTestPeriod         The period of time to check idle connections (in seconds)
     * @param poolPreparedStatements
     * @throws SQLException
     */
    public BasicDataSource(String driver, String connectURI, String uname, String passwd, int maxActive, int maxIdle, int idleTimeOut, int idleTestPeriod, boolean poolPreparedStatements) {
        GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();

        //connectionPool.setMaxActive(maxActive);
        poolConfig.setMaxIdle(maxIdle);
        poolConfig.setMinIdle(1);
        //connectionPool.setMaxWait(-1L);
        //connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_GROW);
        poolConfig.setTestOnBorrow(false);
        poolConfig.setTestWhileIdle(true);
        poolConfig.setTimeBetweenEvictionRunsMillis(idleTestPeriod * 1000L);
        poolConfig.setNumTestsPerEvictionRun(maxActive);
        poolConfig.setMinEvictableIdleTimeMillis(idleTimeOut * 1000L);


        Properties connectionProperties = new Properties();
        connectionProperties.put("user", uname);
        connectionProperties.put("password", passwd);

        ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(connectURI, connectionProperties);

        @SuppressWarnings("unused")
        PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory, null);
        poolableConnectionFactory.setValidationQuery("SELECT 1");

        GenericObjectPool<PoolableConnection> connectionPool = new GenericObjectPool<>(poolableConnectionFactory, poolConfig);
        poolableConnectionFactory.setPool(connectionPool);

        PoolingDataSource dataSource = new PoolingDataSource(connectionPool);

        _connectionPool = connectionPool;
        _source = dataSource;
    }

    public Connection getConnection(Connection con) throws SQLException {
        return con == null || con.isClosed() ? con = _source.getConnection() : con;
    }

    public int getBusyConnectionCount() throws SQLException {
        return _connectionPool.getNumActive();
    }

    public int getIdleConnectionCount() throws SQLException {
        return _connectionPool.getNumIdle();
    }

    public void shutdown() throws Exception {
        _connectionPool.close();
    }

    @Override
    public PrintWriter getLogWriter() throws SQLException {
        return _source.getLogWriter();
    }

    @Override
    public void setLogWriter(PrintWriter out) throws SQLException {
        _source.setLogWriter(out);
    }

    @Override
    public void setLoginTimeout(int seconds) throws SQLException {
        throw new UnsupportedOperationException();
    }

    @Override
    public int getLoginTimeout() throws SQLException {
        throw new UnsupportedOperationException();
    }

    @Override
    public Logger getParentLogger() throws SQLFeatureNotSupportedException {
        throw new UnsupportedOperationException();
    }

    @Override
    public <T> T unwrap(Class<T> iface) throws SQLException {
        throw new UnsupportedOperationException();
    }

    @Override
    public boolean isWrapperFor(Class<?> iface) throws SQLException {
        return false;
    }

    @Override
    public Connection getConnection() throws SQLException {
        return _source.getConnection();
    }

    @Override
    public Connection getConnection(String username, String password) throws SQLException {
        throw new UnsupportedOperationException();
    }

	/*@Override
     public Logger getParentLogger() throws SQLFeatureNotSupportedException {
         return null;
     }*/
}
