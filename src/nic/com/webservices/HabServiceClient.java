package nic.com.webservices;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.core.MediaType;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import nic.com.webservices.dao.DataBase;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class HabServiceClient {

	

	public static void main(String[] args) throws SAXException,
			MalformedURLException, IOException {
		
		// the below url has web service that will retrieve data by passing the habitation id 
		//Ex - http://localhost:8080/AssetRegistrationWS/rest/HabService/HabitationWiseAssets/<HabitaionId>
        String url ="http://localhost:8080/AssetRegistrationWS_Jaxb/rest/HabService/HabitationWiseAssets/1520418014011000/15";
		
		URL l_url = new URL(url);
		URLConnection urlConnection = l_url.openConnection();
		InputStream inputStream = l_url.openStream();

		DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory
				.newInstance();
		DocumentBuilder documentBuilder = null;
		Connection con=null;
		Statement stmt1=null;
		Statement stmt2=null;
		ResultSet rs2=null;
		
		int insertStatus=0;
		
		try {
			con=DataBase.getConnection();
			stmt1=con.createStatement();
			stmt2=con.createStatement();
			

			
			documentBuilder = documentBuilderFactory.newDocumentBuilder();
		
			Document inputXML = documentBuilder.parse(inputStream);
			System.out.println("Root element :"
					+ inputXML.getDocumentElement().getNodeName());
			NodeList nList = inputXML.getElementsByTagName("AssetDetails");
			String habitationName="",habitationCode="",assetCode="",sourceCode="",assetName="",assetLocation="",assetType="",assetStatus="",category="",capacity="";
			String noFillingsday="",drainExisting="",platformExisting="",make="",area="",yieldLPM="",discharge="",areaCovered="";
			String gpsLat="",gpsLong="",yield="",responseCode="";
			String assetRegInserQry="";
			int updatedRecords=0;
			int totalRecordsRead=0;
			for (int temp = 0; temp < nList.getLength(); temp++) {

				Node nNode = nList.item(temp);

				System.out.println("\nCurrent Element :" + nNode.getNodeName()
						+ "nNode.getNodeType()-->" + nNode.getNodeType()
						+ "-->" + Node.ELEMENT_NODE);

				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					
					// assigning the XML elements values to the corresponding column names in the table

					Element eElement = (Element) nNode;
					
					habitationName=(String)eElement.getElementsByTagName("HabitationName").item(0).getTextContent();
					habitationCode=(String)eElement.getElementsByTagName("HabitationCode").item(0).getTextContent();
					assetType=(String)eElement.getElementsByTagName("AssetType").item(0).getTextContent();
					assetName=(String)eElement.getElementsByTagName("AssetName").item(0).getTextContent();
					assetLocation=(String)eElement.getElementsByTagName("AssetLocation").item(0).getTextContent();
					assetCode=(String) eElement.getElementsByTagName("AssetCode").item(0).getTextContent();
					assetStatus=(String)eElement.getElementsByTagName("AssetStatus").item(0).getTextContent();
					areaCovered=(String)eElement.getElementsByTagName("AreaCovered").item(0).getTextContent();
					sourceCode=(String)eElement.getElementsByTagName("HPCode").item(0).getTextContent();
					gpsLat=(String)eElement.getElementsByTagName("GPSLat").item(0).getTextContent();
					gpsLong=(String)eElement.getElementsByTagName("GPSLong").item(0).getTextContent();
					yield=(String)eElement.getElementsByTagName("Yield").item(0).getTextContent();
					drainExisting=(String) eElement.getElementsByTagName("DrainExisting").item(0).getTextContent();
					platformExisting=eElement.getElementsByTagName("PlatformExisting").item(0).getTextContent();
					responseCode=eElement.getElementsByTagName("ResponseCode").item(0).getTextContent();
					
					if(habitationName==null || habitationName.equals("") || habitationName.equals("null")){
						habitationName="NA";
					}
					
					
					if(habitationCode==null || habitationCode.equals("") || habitationCode.equals("null")){
						habitationCode="NA";
					}
					if(assetCode==null || assetCode.equals("") || assetCode.equals("null")){
						assetCode="NA";
					}
					if(sourceCode==null || sourceCode.equals("") || sourceCode.equals("null")){
						sourceCode="NA";
					}
					if(assetName==null || assetName.equals("") || assetName.equals("null")){
						assetName="NA";
					}
					if(assetLocation==null || assetLocation.equals("") || assetLocation.equals("null")){
						assetLocation="NA";
					}
					if(assetType==null || assetType.equals("") || assetType.equals("null")){
						assetType="NA";
					}
					if(assetStatus==null || assetStatus.equals("") || assetStatus.equals("null")){
						assetStatus="NA";
					}
					if(gpsLat==null || gpsLat.equals("") || gpsLat.equals("null")){
						gpsLat="NA";
					}
					if(gpsLong==null || gpsLong.equals("") ||  gpsLong.equals("null")){
						gpsLong="NA";
					}
					if(noFillingsday==null || noFillingsday.equals("") || noFillingsday.equals("null")){
						noFillingsday="NA";
					}
					if(drainExisting==null || drainExisting.equals("") ||  drainExisting.equals("null")){
						drainExisting="NA";
					}
					if(platformExisting==null || platformExisting.equals("")  || platformExisting.equals("null")){
						platformExisting="NA";
					}
					if(areaCovered==null || areaCovered.equals("") || areaCovered.equals("null")){
						areaCovered="NA";
					}
					
					if(yield==null || yield.equals("") ||  yield.equals("null")){
						yield="NA";
					}
					if(responseCode==null || responseCode.equals("") ||  responseCode.equals("null")){
						responseCode="NA";
					}
					
					
					habitationName=habitationName.trim();
					habitationCode=habitationCode.trim();
					assetType=assetType.trim();
					assetName=assetName.trim();
					assetLocation=assetLocation.trim();
					assetCode=assetCode.trim();
					assetStatus=assetStatus.trim();
					areaCovered=areaCovered.trim();
					sourceCode=sourceCode.trim();
					gpsLat=gpsLat.trim();
					gpsLong=gpsLong.trim();
					yield=yield.trim();
					drainExisting=drainExisting.trim();
					platformExisting=platformExisting.trim();
					responseCode=responseCode.trim();
					
					
					// If the retrieved data is already existing in our db then data is not inserted
					
					rs2=stmt2.executeQuery("select * from rwss_asset_registration_details where source_code='"+sourceCode+"'");
					if(rs2.next()){
						System.out.println("Source Code already exist in Database :"+sourceCode);
					}
					else{
					
						// After Parsing the XML,the data insert into the table	
						
					assetRegInserQry="insert into rwss_asset_registration_details(habitation_name, habitation_code, asset_type, asset_name, asset_location, asset_code, asset_status, area_covered, source_code, gps_lat, gps_long, yield, drain_existing, platform_existing, response_code) values('"+habitationName+"','"+habitationCode+"','"+assetType+"','"+assetName+"','"+assetLocation+"','"+assetCode+"','"+assetStatus+"','"+areaCovered+"','"+sourceCode+"','"+gpsLat+"','"+gpsLong+"','"+yield+"','"+drainExisting+"','"+platformExisting+"','"+responseCode+"') ";
					System.out.println(assetRegInserQry);
					insertStatus=stmt1.executeUpdate(assetRegInserQry);
					if(insertStatus>0){
						updatedRecords++;
					 }
					}
					
					
				}
				totalRecordsRead++;
			}
			System.out.println("Total records fetched :"+totalRecordsRead);
			System.out.println("Total records update  :"+updatedRecords);

		} catch (ParserConfigurationException e) {			
			e.printStackTrace();
		}
		catch(Exception ex){
			ex.printStackTrace();
		}

	}

	private static String getResponse(WebResource service) {
		return service.accept(MediaType.TEXT_XML).get(ClientResponse.class)
				.toString();
	}

	private static String getOutputAsXML(WebResource service) {
		return service.accept(MediaType.TEXT_XML).get(String.class);
	}
}