package com.fpt.learning.context;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.util.List;

public abstract class DBContext<T> {

    protected Connection connection;

    public DBContext() {

        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=event_mgt";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public abstract List<T> findAll();

    public abstract T findById(int id);

    public abstract void insert(T model);

    public abstract void update(T model);

    public abstract void delete(int id);

    



}
