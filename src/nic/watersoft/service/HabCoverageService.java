package nic.watersoft.service;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;


@Path("/HabService")
public class HabCoverageService {

	HabCoverageDAO habCoverageDAO = new HabCoverageDAO();
	
	   @GET
	   @Path("/coverages/json")
	   @Produces(MediaType.APPLICATION_JSON)
	   public String getJSONCoverages() throws Exception{
	      return new Gson().toJson(habCoverageDAO.getAllCoverages());
	   }

	   @GET
	   @Path("/coverages/json/{dcode}")
	   @Produces(MediaType.APPLICATION_JSON)
	   public String getJSONCoverage(@PathParam("dcode") String dcode) throws Exception{
	      return new Gson().toJson(habCoverageDAO.getCoverage(dcode));
	   }
	   
	   @GET
	   @Path("/coverages/xml")
	   @Produces(MediaType.APPLICATION_XML)
	   public List<DistrictCoverage> getXMLCoverages() throws Exception{
	   return habCoverageDAO.getAllCoverages();
	   }

	   @GET
	   @Path("/coverages/xml/{dcode}")
	   @Produces(MediaType.APPLICATION_XML)
	   public DistrictCoverage getXMLCoverage(@PathParam("dcode") String dcode) throws Exception{
	   return habCoverageDAO.getCoverage(dcode);
	   }
	
}
