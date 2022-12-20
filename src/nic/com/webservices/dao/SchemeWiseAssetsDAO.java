package nic.com.webservices.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SchemeWiseAssetsDAO {
	static String appendXML = "";
	public static AssetDetails getSchemeWiseAssetDetails(String query,
			String habitationId) {   // getHabWiseAssetDetails Method by passing query and habitationId parameters
		
		//Connection con = DataBase.getConnection(); //mysql conn
		Connection con = DataBase.getSQLServerConnection(); //sql server conn
		
		AssetDetails ad = new AssetDetails();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			String habitationName = "", habitationCode = "", assetCode = "", sourceCode = "", assetName = "", assetLocation = "", assetType = "", assetStatus = "", category = "", capacity = "";
			String noFillingsday = "", drainExisting = "", platformExisting = "", make = "", area = "", yieldLPM = "", discharge = "", areaCovered = "";
			String gpsLat = "", gpsLong = "", yield = "", responseCode = "", sourceCodeAbbr = "";

			String flag = "N";
			List<Asset> list = new ArrayList<Asset>();
			
  

			while (rs.next()) {

				// If the Habitation Code is valid and when data is fetched the XML code will be generated with all the column details
				
				
				
				flag = "Y";
				// String assetName = rs.getString(4);

				habitationName = rs.getString(1);
				habitationCode = rs.getString(2);
				assetType = rs.getString(3);
				assetName = rs.getString(4);
				assetLocation = rs.getString(5);
				assetCode = rs.getString(6);
				assetStatus = rs.getString(7);
				areaCovered = rs.getString(8);
				sourceCode = rs.getString(9);
				gpsLat = rs.getString(10);
				gpsLong = rs.getString(11);
				yield = rs.getString(12);
				drainExisting = rs.getString(13);
				platformExisting = rs.getString(14);
				responseCode = rs.getString(15);
				sourceCodeAbbr = rs.getString(16);

				if (sourceCodeAbbr.equalsIgnoreCase("SO")) {
					assetName = "NA";
					sourceCode = "NA";
				}

				if (habitationName == null || habitationName.equals("")
						|| habitationName.equals("null")) {
					habitationName = "NA";
				}

				if (habitationCode == null || habitationCode.equals("")
						|| habitationCode.equals("null")) {
					habitationCode = "NA";
				}
				if (assetCode == null || assetCode.equals("")
						|| assetCode.equals("null")) {
					assetCode = "NA";
				}
				if (sourceCode == null || sourceCode.equals("")
						|| sourceCode.equals("null")) {
					sourceCode = "NA";
				}
				if (assetName == null || assetName.equals("")
						|| assetName.equals("null")) {
					assetName = "NA";
				}
				if (assetLocation == null || assetLocation.equals("")
						|| assetLocation.equals("null")) {
					assetLocation = "NA";
				}
				if (assetType == null || assetType.equals("")
						|| assetType.equals("null")) {
					assetType = "NA";
				}
				if (assetStatus == null || assetStatus.equals("")
						|| assetStatus.equals("null")) {
					assetStatus = "NA";
				}
				if (gpsLat == null || gpsLat.equals("")
						|| gpsLat.equals("null")) {
					gpsLat = "NA";
				}
				if (gpsLong == null || gpsLong.equals("")
						|| gpsLong.equals("null")) {
					gpsLong = "NA";
				}
				if (noFillingsday == null || noFillingsday.equals("")
						|| noFillingsday.equals("null")) {
					noFillingsday = "NA";
				}
				if (drainExisting == null || drainExisting.equals("")
						|| drainExisting.equals("null")) {
					drainExisting = "NA";
				}
				if (platformExisting == null || platformExisting.equals("")
						|| platformExisting.equals("null")) {
					platformExisting = "NA";
				}
				if (areaCovered == null || areaCovered.equals("")
						|| areaCovered.equals("null")) {
					areaCovered = "NA";
				}

				if (yield == null || yield.equals("") || yield.equals("null")) {
					yield = "NA";
				}
				if (responseCode == null || responseCode.equals("")
						|| responseCode.equals("null")) {
					responseCode = "NA";
				}
				
				
				
				Asset asset = new Asset();
				asset.setAssetCode(assetCode);
				asset.setAssetName(assetName);
				asset.setAssetStatus(assetStatus);
				asset.setAsseType(assetType);
				asset.setHabitationName(habitationName);
				asset.setHabitationCode(habitationCode);
				//asset.setLocation(assetLocation);
				//asset.setArea(areaCovered);
				//asset.setHPCode(sourceCode);
				//asset.setGpsLat(gpsLat);
				//asset.setGpsLog(gpsLong);
				asset.setYield(yield);
				asset.setDrainExisting(drainExisting);
				asset.setPlatFormExisting(platformExisting);
				asset.setRespondCode("S");
				
				
				list.add(asset);
				
				
			}
			
			//If the Habitation is Invalid then Empty Record with the Column values as "NA" and response code as "N,Invalid Habitaiton" in the "reason" column 

			if (flag.equalsIgnoreCase("N")) {
				Asset asset = new Asset();
				asset.setAssetCode("NA");
				asset.setAssetName("NA");
				asset.setAssetStatus("NA");
				asset.setAsseType("NA");
				asset.setHabitationName("NA");
				asset.setHabitationCode(habitationId);
				//asset.setLocation("NA");
				//asset.setArea("NA");
				//asset.setHPCode("NA");
				//asset.setGpsLat("NA");
				//asset.setGpsLog("NA");
				asset.setYield("NA");
				asset.setDrainExisting("NA");
				asset.setPlatFormExisting("NA");
				asset.setRespondCode("N,Invalid Habitaiton");
				list.add(asset);
			}

			ad.setAsset(list);

			
			
			return ad;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		finally{
			DataBase.close(con);
		}

		

	}
}
