package nic.com.webservices;
import nic.watersoft.commons.RwsOffices;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

public class ExcelEx{

   @SuppressWarnings("unchecked")
    public static void main(String[] args) throws Exception {
        //
        // An excel file name. You can create a file name with a full path
        // information.
        //
        String filename = "D:\\sss1.xls";

        //
        // Create an ArrayList to store the data read from excel sheet.
        //
        List sheetData = new ArrayList();

        FileInputStream fis = null;
        try {
            //
            // Create a FileInputStream that will be use to read the excel file.
            //
            fis = new FileInputStream(filename);
            //
            // Create an excel workbook from the file system.
            //
            HSSFWorkbook workbook = new HSSFWorkbook(fis);
            //
            // Get the first sheet on the workbook.
            //
            HSSFSheet sheet = workbook.getSheetAt(0);
            String cellValue="";

          
            // When we have a sheet object in hand we can iterator on each
            // sheet's rows and on each row's cells. We store the data read
            // on an ArrayList so that we can printed the content of the excel
            // to the console.
            //
            
            Iterator<Row> rowIter = sheet.rowIterator();
            while (rowIter.hasNext()) {
            	
                HSSFRow myRow = (HSSFRow) rowIter.next();
                Iterator<Cell> cellIter = myRow.cellIterator();
                List<HSSFCell> cellStore = new ArrayList<HSSFCell>();
                while (cellIter.hasNext()) {
                    HSSFCell myCell = (HSSFCell) cellIter.next();
                    
               
          /*  Iterator rows = sheet.rowIterator();
            while (rows.hasNext()) {
            	
                HSSFRow row = (HSSFRow) rows.next();
               
                Iterator cells = row.cellIterator();

                List data = new ArrayList();
               
                while (cells.hasNext()) {
                	//System.out.println(cells.next().toString());
                    HSSFCell cell = (HSSFCell) cells.next();*/
                                   
                   // System.out.println("aaaaaaa"+cell.getStringCellValue());
                    cellStore.add(myCell);
                    
                }
                System.out.println(cellStore.size());
                sheetData.add(cellStore);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fis != null) {
                fis.close();
            }
        }

        showExelData(sheetData);
    }

    private static void showExelData(List sheetData) {
        //
        // Iterates the data and print it out to the console.
        //
    	try{
    	 Connection conn = RwsOffices.getConn();//DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "hr", "hr");
         PreparedStatement sql_statement = null;
          String jdbc_insert_sql = "INSERT INTO RWS_DROUGHT_HAB_TR_PVT_SO_TBL"
                         + "(DATE_OF_ENTRY,HABITATION_CODE,POPULATION_SER_TRANSPORT,TANKER_CAPACITY,TANKER_NO_OF_TRIPS,TANKER_QTY,TRANSPORT_COST_PER_TRIP,TRANSPORT_TOTAL_COST,TANKER_REMARKS,CAT_POPULATION_SER_TRANSPORT,CAT_TANKER_CAPACITY,CAT_TANKER_NO_OF_TRIPS,CAT_TANKER_QTY,CAT_TRP_COST_PER_TRIP,CAT_TRP_TOTAL_COST,CAT_TANKER_REMARKS,ASSET_TYPE_CODE,POPULATION_SER_PVT_HIRED,PVT_MODE_OF_SUPPLY,PVT_SOURCES_HIRED_NO,PVT_SOURCES_REMARKS,PVT_SOURCES_QTY,POWER_SUPPLY_REMARKS,POWER_SUPPLY_REG_IRREG_LOW,DATE_ENTERED) VALUES"
                         + "(to_date(?,'dd/MM/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(sysdate,'dd/MM/yyyy'))";
         sql_statement = conn.prepareStatement(jdbc_insert_sql);
      
         System.out.println(sheetData.size());
int x=0;;
      String cellValue="";
         
        for (int i = 3; i < sheetData.size(); i++) {
        	//HSSFRow row = (HSSFRow) sheetData.get(i);
        	List list = (List) sheetData.get(i);
            
            System.out.println("list Size  "+list.size());
            x=1;
            for (int j = 0; j < list.size(); j++) {
            	System.out.println("i,j value"+"       "+"("+i+","+j+")");
            	
            	
                HSSFCell cell = (HSSFCell) list.get(j);
                
                    System.out.println("xxxxxxxx"+x);
                   
          
                switch(cell.getCellType()) { 
                
                case Cell.CELL_TYPE_STRING: //handle string columns
                	System.out.println(cell.getStringCellValue());
                	sql_statement.setString(x, cell.getStringCellValue().trim());                                                                                     
                    break;
                case Cell.CELL_TYPE_NUMERIC: //handle double data
                	
                	if(HSSFDateUtil.isCellDateFormatted(cell)){
                		
                		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
						cellValue =  sdf.format(cell.getDateCellValue());
                		System.out.println("dateee"+cellValue);
                		 sql_statement.setString(x,cellValue );
                	}
                	else{
                		System.out.println(cell.getNumericCellValue());
                		sql_statement.setDouble(x,cell.getNumericCellValue() );
                	}
                    break;
                }
                    
                x++;
                if (j < list.size() - 1) {
                	
                    System.out.print(", ");
                }
                
            }
            sql_statement.executeUpdate();
            System.out.println("");
        }
        
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    }
}
/*import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;
 
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
 
*//**
 * A dirty simple program that reads an Excel file.
 * @author www.codejava.net
 *
 *//*
public class ExcelEx {
     
	 public static void main(String[] args) throws IOException {
        String excelFilePath = "D:\\sample.xls";
        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
         
        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet firstSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = firstSheet.iterator();
         
        while (iterator.hasNext()) {
            Row nextRow = iterator.next();
            Iterator<Cell> cellIterator = nextRow.cellIterator();
             
            while (cellIterator.hasNext()) {
                Cell cell = cellIterator.next();
                 
                switch (cell.getCellType()) {
                    case Cell.CELL_TYPE_STRING:
                        System.out.print(cell.getStringCellValue());
                        break;
                    case Cell.CELL_TYPE_BOOLEAN:
                        System.out.print(cell.getBooleanCellValue());
                        break;
                    case Cell.CELL_TYPE_NUMERIC:
                        System.out.print(cell.getNumericCellValue());
                        break;
                }
                System.out.print(" - ");
            }
            System.out.println();
        }
         
        //workbook.close();
        inputStream.close();
    }
 
}*/
/*import java.io.*;

import nic.watersoft.commons.RwsOffices;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.*;

import java.util.*;
import java.sql.*; 
public class ExcelEx {  
        public static void main(String[] args) throws Exception{                
                 Create Connection objects 
               
        		//Class.forName ("oracle.jdbc.OracleDriver"); 
                Connection conn = RwsOffices.getConn();//DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "hr", "hr");
                PreparedStatement sql_statement = null;
                String jdbc_insert_sql = "INSERT INTO XLS_POI"
                                + "(KEYWORD, TOTAL_COUNT) VALUES"
                                + "(?,?)";
                sql_statement = conn.prepareStatement(jdbc_insert_sql);
                 We should now load excel objects and loop through the worksheet data 
                FileInputStream input_document = new FileInputStream(new File("D:\\sample.xls"));
                 Load workbook 
               HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document);
                 Load worksheet 
                HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0);
                // we loop through and insert data
                Iterator<Row> rowIterator = my_worksheet.rowIterator();//iterator(); 
                while(rowIterator.hasNext()) {
                        Row row = rowIterator.next(); 
                        Iterator<Cell> cellIterator = row.cellIterator();
                                while(cellIterator.hasNext()) {
                                        Cell cell = cellIterator.next();
                                        switch(cell.getCellType()) { 
                                        case Cell.CELL_TYPE_STRING: //handle string columns
                                                sql_statement.setString(1, cell.getStringCellValue());                                                                                     
                                                break;
                                        case Cell.CELL_TYPE_NUMERIC: //handle double data
                                                sql_statement.setDouble(2,cell.getNumericCellValue() );
                                                break;
                                        }
                                       
                                }
                //we can execute the statement before reading the next row
                sql_statement.executeUpdate();
                }
                 Close input stream 
                input_document.close();
                 Close prepared statement 
                sql_statement.close();
                 COMMIT transaction 
                conn.commit();
                 Close connection 
                conn.close();
        }
}*/