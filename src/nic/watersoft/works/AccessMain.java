/*
 * Created on 6-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

package nic.watersoft.works;


import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Types;

/**

/**
 * @author RWSS_DPT1
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AccessMain {

	

	    private static Database createDatabase(String databaseName) throws IOException {
	       return null;
	    }

	    private static TableBuilder createTable(String tableName) {
	        return new TableBuilder(tableName);
	    }

	    public static void addColumn(Database database, TableBuilder tableName, String columnName, Types sqlType) throws SQLException, IOException {
	        tableName.addColumn(new ColumnBuilder(columnName).setSQLType(Types.INTEGER).toColumn()).toTable(database);
	    }

	    public static void startDatabaseProcess() throws IOException, SQLException {
	        String databaseName = "C:/Users/compaq/Desktop/employeedb.mdb"; // Creating an MS Access database
	        Database database = createDatabase(databaseName);

	        String tableName = "Employee"; // Creating table
	        Table table = createTable(tableName)
	                .addColumn(new ColumnBuilder("Emp_Id").setSQLType(Types.INTEGER).toColumn())
	                .addColumn(new ColumnBuilder("Emp_Name").setSQLType(Types.VARCHAR).toColumn())
	                .addColumn(new ColumnBuilder("Emp_Employer").setSQLType(Types.VARCHAR).toColumn())
	                .toTable(database);

	        
	        String a[]={"123","prasad"};
	        table.addRow(a);//Inserting values into the table
	    }

	    public static void main(String[] args) throws IOException, SQLException {
	    	AccessMain.startDatabaseProcess();
	    }
	}

