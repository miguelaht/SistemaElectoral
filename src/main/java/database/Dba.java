package database;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author miguelaht
 */
public class Dba {
    private final Dotenv dotenv = Dotenv.configure()
            .ignoreIfMalformed()
            .ignoreIfMissing()
            .load();
    private Connection conexion = null;
    public Statement query;

    public static void main(String[] args) {
        Dba obconeccion = new Dba();
        obconeccion.Conectar();
    }

    public Connection getConexion() {
        return conexion;
    }

    public void setConexion(Connection conexion) {
        this.conexion = conexion;
    }

    public Dba Conectar() {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            String BaseDeDatos = "jdbc:oracle:thin:@"+dotenv.get("ORACLE_IP")+":"+dotenv.get("ORACLE_SID");
            conexion = DriverManager.getConnection(BaseDeDatos, dotenv.get("ORACLE_USER"), dotenv.get("ORACLE_PASS"));
            query = conexion.createStatement();

            if (conexion != null) {
                System.out.println("Conexion exitosa ");
            } else {
                System.out.println("Conexion fallida");
            }
        } catch (ClassNotFoundException | SQLException e) {
        }
        return this;
    }

    public void desconectar() {
        try {
            query.close();
            conexion.close();
        } catch (SQLException e) {
        }
    }

    public void commit() {
        try {
            conexion.commit();
        } catch (SQLException e) {
        }
    }
}
