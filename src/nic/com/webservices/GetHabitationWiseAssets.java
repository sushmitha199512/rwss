package nic.com.webservices;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import nic.com.webservices.dao.Asset;
import nic.com.webservices.dao.AssetDetails;
import nic.com.webservices.dao.Source;
import nic.watersoft.commons.RwsOffices;


//URL http://localhost:8881/pred/rest/HabService/HabitationWiseAssets/0101410052013500

/**
 * 
 * @author Sai Prasad N
 * 
 */

@Path("HabService")
public class GetHabitationWiseAssets {

	private static final String ALLOWED_IP = "115.115.112.138";

	/*
	 * @GET
	 * 
	 * @Produces("application/xlm") public String getData(@Context
	 * HttpServletRequest request) { String ip = request.getRemoteAddr();
	 * System.out.println("Ip Address:" + ip); return ip; }
	 */

	@Path("/HabitationWiseAssets/{habitationId}")
	@GET
	@Produces(MediaType.APPLICATION_XML)
	public AssetDetails getHabitationWiseAssets(
			@PathParam("habitationId") String habitationId,
			@Context HttpServletRequest request) {
		String ip = request.getRemoteAddr();
		System.out.println("Ip Address:" + ip);

		if (ip != null && ip.equals(ALLOWED_IP)) {

			
			//The server is temporarily unable to service your request. Please try again later
			//return null;
		}

		/* List<Data> list = new ArrayList<Data>(); */

		AssetDetails ad = new AssetDetails();
		List<Asset> list = new ArrayList<Asset>();
		Connection conn = null;
		Statement stmt = null;
		try {

			conn = RwsOffices.getConn();
		    String query = "select * from rws_asset_mast_tbl a,rws_asset_type_tbl b  where a.TYPE_OF_ASSET_CODE=b.TYPE_OF_ASSET_CODE and hab_code=?";
			PreparedStatement stat = conn.prepareStatement(query);
			stat.setString( 1, habitationId );
			ResultSet rs = stat.executeQuery();
			while (rs.next()) {
				Asset a = new Asset();

				a.setAssetName(rs.getString(2));
				a.setHabitationCode(rs.getString(1));
				a.setAssetStatus(rs.getString(7));
				a.setGPSLat(rs.getString("LATITUDE"));
				a.setGPSLong(rs.getString("LONGITUDE"));
				a.setAsseType(rs.getString("TYPE_OF_ASSET_NAME"));
				Source s = new Source();
				s.setSourceCode("1254251452");
				a.setSource(s);

				list.add(a);

			}

			ad.setAsset(list);
			/*
			 * String query =
			 * "select habitation_name, habitation_code, arm.asset_type, asset_name, asset_location, asset_code, asset_status, area_covered, source_code, gps_lat, gps_long, yield, drain_existing, platform_existing, response_code,substring(source_code,20,2) as abbr from rwss_asset_registration_details rd,asset_types_master arm where rd.asset_type=arm.asset_type_id and habitation_code='"
			 * + habitationId +
			 * "' and substring(habitation_code,1,2)='"+districtId
			 * +"' and asset_name in('SUBSURFACE SOURCE','HANDPUMP')";
			 * System.out.println("Query -->" + query);
			 * 
			 * ad =
			 * HabitationWiseAssetsDAO.getHabWiseAssetDetails(query,habitationId
			 * ); // getHabWiseAssetDetails Method by passing query and
			 * habitationId parameters
			 * 
			 * System.out.println("list-->" + ad);
			 */

		} catch (Exception ex) {
			System.out.println(ex);

		} finally {

			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {

				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return ad;
	}

}
