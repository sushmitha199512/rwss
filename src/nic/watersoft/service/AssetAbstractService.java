package nic.watersoft.service;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;


@Path("/AssetService")
public class AssetAbstractService {

	AssetAbstractDAO assetDAO = new AssetAbstractDAO();
	
	   @GET
	   @Path("/assets/json")
	   @Produces(MediaType.APPLICATION_JSON)
	   public String getJSONAssets() throws Exception{
	      return new Gson().toJson(assetDAO.getAllAssets());
	   }

	   @GET
	   @Path("/assets/json/{dcode}")
	   @Produces(MediaType.APPLICATION_JSON)
	   public String getJSONAsset(@PathParam("dcode") String dcode) throws Exception{
	      return new Gson().toJson(assetDAO.getAsset(dcode));
	   }
	   
	   @GET
	   @Path("/assets/xml")
	   @Produces(MediaType.APPLICATION_XML)
	   public List<DistrictAsset> getXMLAssets() throws Exception{
	   return assetDAO.getAllAssets();
	   }

	   @GET
	   @Path("/assets/xml/{dcode}")
	   @Produces(MediaType.APPLICATION_XML)
	   public DistrictAsset getXMLAsset(@PathParam("dcode") String dcode) throws Exception{
	   return assetDAO.getAsset(dcode);
	   }
	
}
