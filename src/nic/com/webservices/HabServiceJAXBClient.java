package nic.com.webservices;

import java.io.ByteArrayInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import nic.com.webservices.dao.Asset;
import nic.com.webservices.dao.AssetDetails;
import nic.com.webservices.dao.DataBase;

import org.xml.sax.InputSource;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;

public class HabServiceJAXBClient {
	
	public static void main(String[] args) throws JAXBException{
		
		try {
			Connection con=null;
			Statement stmt1=null;
			Statement stmt2=null;
			ResultSet rs2=null;
			con=DataBase.getSQLServerConnection();
			stmt1=con.createStatement();
			stmt2=con.createStatement();
			String assetRegInserQry="";
			int updatedRecords=0;
			int totalRecordsRead=0;
			int insertStatus=0;
			String url = "http://localhost:8080/AssetRegistrationWS_Jaxb/rest/HabService/HabitationWiseAssets/1520418014011000/151";
			
			List<Asset> assets = getAssetsFromWebService(url);
			
			
			
			String habitationName="",habitationCode="",assetCode="",hpCode="",assetName="",assetLocation="",assetType="",assetStatus="",category="",capacity="";
			String noFillingsday="",drainExisting="",platformExisting="",make="",area="",yieldLPM="",discharge="",areaCovered="";
			String gpsLat="",gpsLong="",yield="",responseCode="";
			
			for(Asset a:assets){
				
				
				habitationName = a.getHabitationName();
				habitationCode = a.getHabitationCode();
				assetCode = a.getAssetCode();
				hpCode = a.getSourceCode();
				assetName = a.getAssetName();
				assetLocation = a.getAssetLocation();
				assetType = a.getAsseType();
				assetStatus = a.getAssetStatus();
				area = a.getDiameter();
				drainExisting = a.getDrainExisting();
				platformExisting = a.getPlatFormExisting();
				yield = a.getYield();
				gpsLat = a.getGPSLat();
				gpsLong = a.getGPSLong();
				responseCode = a.getRespondCode();
				// If the retrieved data is already existing in our db then data is not inserted
				String query="select * from rwss_asset_registration_details1 where source_code=?";
				PreparedStatement pst= con.prepareStatement(query);
				pst.setString(1, hpCode);
				rs2=pst.executeQuery();
				if(rs2.next()){
					System.out.println("Source Code already exist in Database :"+hpCode);
				}
				else{
				
					// After Parsing the XML,the data insert into the table	
	
			    assetRegInserQry="insert into rwss_asset_registration_details1(habitation_name, habitation_code, asset_type, asset_name, asset_location, asset_code, asset_status, area_covered, source_code, gps_lat, gps_long, yield, drain_existing, platform_existing, response_code) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
				pst=con.prepareStatement(assetRegInserQry);
			    pst.setString(1, habitationName);	
				pst.setString(2, habitationCode);	
				pst.setString(3, assetType);	
				pst.setString(4, assetName);	
				pst.setString(5, assetLocation);	
				pst.setString(6, assetCode);	
				pst.setString(7, assetStatus);
				pst.setString(8, areaCovered);	
				pst.setString(9, hpCode);	
				pst.setString(10, gpsLat);	
				pst.setString(11, gpsLong);	
				pst.setString(12, yield);	
				pst.setString(13, drainExisting);	
				pst.setString(14, platformExisting);
				pst.setString(15, responseCode);
				System.out.println(assetRegInserQry);
				insertStatus=pst.executeUpdate();
				if(insertStatus>0){
					updatedRecords++;
				 }
				
				}
				
			
			}
			System.out.println("Total records fetched :"+assets.size());
			System.out.println("Total records update  :"+updatedRecords);
		     
		} catch (Exception e) {
		
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		
		
		
		
	}
	
	public static List<Asset> getAssetsFromWebService(String url) throws JAXBException{
		
		 ClientConfig config = new DefaultClientConfig();
		  Client client = Client.create(config);
		  WebResource service = client.resource(url);
		  
		  String str = service.accept(MediaType.APPLICATION_XML).get(String.class);
		  
		  /* converting XML to List Object*/
		  
		  ByteArrayInputStream b = new ByteArrayInputStream(str.getBytes());
		  InputSource  is = new InputSource(b);
		  
		  JAXBContext context = JAXBContext.newInstance(AssetDetails.class);
		  Unmarshaller um = context.createUnmarshaller();
		  
		  @SuppressWarnings("unchecked")
		  AssetDetails d = (AssetDetails) um.unmarshal(is);
		  
		  System.out.println(d.getAsset());
		  return d.getAsset();
	}

}
