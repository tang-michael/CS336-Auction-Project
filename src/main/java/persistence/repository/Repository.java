package persistence.repository;

import persistence.db.DbConnectionManager;

import java.sql.Connection;

/**
 * The super class of any "Repository" class (A class that manipulates one or more related database tables).
 * The class provides a database connection to all the subclasses.
 */
public abstract class Repository {
    protected final Connection dbConnection;

    public Repository() {
        try {
            this.dbConnection = DbConnectionManager.getConnection();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
