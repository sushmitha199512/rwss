package nic.com.webservices;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import nic.com.webservices.dao.AssetDetails;
import nic.com.webservices.dao.SchemeWiseAssetsDAO;

@Path("SchemeAssetsService")
public class SchemeWiseAssetsService {
	@Path("/SchemeWiseAssets/{schemeCode}/{districtId}")
	@GET
	@Produces(MediaType.APPLICATION_XML)
	public AssetDetails getSchemeWiseAssets(
			@PathParam("schemeCode") String schemeCode,@PathParam("districtId") String districtId) {

		/* List<Data> list = new ArrayList<Data>(); */

		AssetDetails ad = null;

		try {

			String query = "select habitation_name, habitation_code, arm.asset_type, asset_name, asset_location, asset_code, asset_status, area_covered, source_code, gps_lat, gps_long, yield, drain_existing, platform_existing, response_code,substring(source_code,20,2) as abbr from rwss_asset_registration_details rd,asset_types_master arm where rd.asset_type=arm.asset_type_id and asset_code='"+schemeCode+"'";
			System.out.println("Query -->" + query);

			ad = SchemeWiseAssetsDAO.getSchemeWiseAssetDetails(query,schemeCode);  // getSchemeWiseAssetDetails Method by passing query and habitationId parameters

			System.out.println("list-->" + ad);

		} catch (Exception ex) {
			System.out.println(ex);

		}

		return ad;
	}
}
