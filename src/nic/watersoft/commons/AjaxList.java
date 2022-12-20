package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

public class AjaxList  
{
	private DataSource dataSource;
	private Connection conn;
	private Statement stat;
	private ResultSet rset;
	
	private LabelValueBean labelValueBean;
	private SimpleDateFormat dateFormatter;
	
	private String query;
	private StringBuffer buffer = null;
	private String formName;
	private String formElement;
	
	public AjaxList(DataSource dataSource, String formName, String formElement)
	{
		this.dataSource = dataSource;
		this.formName = formName;
		this.formElement = formElement;
	}
			
	private void closeAll()
	{
		if(rset != null)
		{
			try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{
			try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	
	
	public String getHeadOffices() throws Exception
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			query = " SELECT head_office_name, head_office_code "
				  + " FROM rws_head_office_tbl ORDER BY head_office_name";
						 
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");			
			
		}
		catch(Exception e)
		{	
			//System.out.println("Exception in getHeadOffices(): \n" + e.getStackTrace());			
		}
		finally
		{	closeAll();
		}
		
		return buffer.toString();
	}
	
	
	public String getCircles(String headOfficeCode)
	{

		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			query = " SELECT circle_office_name, circle_office_code "
				  + " FROM rws_circle_office_tbl "
				  + " WHERE head_office_code = '"+ headOfficeCode + "' "
				  + " ORDER BY circle_office_name";
						
			rset = stat.executeQuery(query);
						
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		
		return buffer.toString();
	}
	
	
	public String getDivisions(String headOfficeCode, String circleOfficeCode)
	{
		
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			query = " SELECT division_office_name, division_office_code "
				  + " FROM rws_division_office_tbl "
				  + " WHERE head_office_code = '" + headOfficeCode + "' "
				  + " AND circle_office_code = '" + circleOfficeCode + "' " 
				  + " ORDER BY division_office_name ";
						 
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();			
		}
		return buffer.toString();
		
	}


	
	public String getSubDivisions(String headOfficeCode, String circleOfficeCode, 
		String divisionOfficeCode)
	{
			
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");	
		
		try
		{
			conn = dataSource.getConnection();
			stat = stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			query = " SELECT subdivision_office_name, subdivision_office_code "
				  + " FROM rws_subdivision_office_tbl "
				  + " WHERE head_office_code = '" + headOfficeCode + "' "
				  + " AND circle_office_code = '" + circleOfficeCode + "' "
				  + " AND division_office_code = '" + divisionOfficeCode + "' "
				  + " ORDER BY subdivision_office_name ";
						 
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		
		return buffer.toString();
	}
	
	public String getRepresentatives() 
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT rep_name, rep_code "
				  + " FROM rws_public_rep_tbl ORDER BY rep_name";
		 
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	
			closeAll();
		}
		return buffer.toString();
	}
	
	
	public String getConstituencies(String repCode)
	{
		//System.out.println("formName : " + formName);
		//System.out.println("formElement : " + formElement);
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			//conn = dataSource.getConnection();
			conn = RwsOffices.getConn();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT constituency_name, constituency_code "
				  + " FROM rws_constituency_tbl WHERE "
				  + " rep_code = " + repCode + " ORDER BY constituency_name ";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			//System.out.println("RowCount in getConstituencies(): " + rowCount);
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue><![CDATA[&nbsp;]]></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue><![CDATA[&nbsp;]]></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
		}
		catch(Exception e)
		{	//System.out.println("Exception in getConstituencies():\n " + e);
			
		}
		finally
		{
			closeAll();
		}
		buffer.append("</selectChoice>");
		return buffer.toString();
	}

	public String[] getRepresentativeDetails(String repCode, String constituencyCode) throws Exception
	{
		String[] repDetails = new String[2];
		//System.out.println("repCode " + repCode);
		//System.out.println("constituencyCode " + constituencyCode);
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT name, address from rws_mp_mla_tbl WHERE "
				  + " rep_code = " + repCode + " AND constituency_code = " + constituencyCode ;
					
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				repDetails[0] = rset.getString(1);
				repDetails[1] = rset.getString(2);
			}
		}
		catch(Exception e)
		{			
		}
		finally
		{
			closeAll();
		}
		return repDetails;
	}


	public String getProgrammes()
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT programme_name, programme_code "
				  + " FROM rws_programme_tbl ORDER BY programme_name ";
						 
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	
			closeAll();
		}
		return buffer.toString();
	}
	
	public String getSubProgrammes(String programmeCode)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT subprogramme_name, subprogramme_code "
				  + " FROM rws_subprogramme_tbl WHERE " 
				  + " programme_code='" + programmeCode + "'"
				  + " ORDER BY subprogramme_name ";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
		
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}
	

	/**	
	*	Gets the various Priorities
	*/
	public String getPriorities()
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT priority_description, priority_code "
				  + " FROM rws_priority_tbl order by priority_description";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}

	
	public String getAssetTypes()
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT type_of_asset_name , type_of_asset_code "
				  + " FROM rws_asset_type_tbl order by type_of_asset_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}

	public String getSourceTypes()
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();			 
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT source_type_name , source_type_code "
				  + " FROM rws_source_type_tbl ORDER BY source_type_name ";
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}
	
	public String getSubsourceTypes(String sourceType)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT subsource_type_name , subsource_type_code "
				  + " FROM rws_subsource_type_tbl WHERE " 
				  + " source_type_code = '" + sourceType + "' "
				  + " ORDER BY subsource_type_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}

	public String getSources(String sourceType, String subsourceType)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT source_name, source_code "
				  + " FROM rws_source_tbl WHERE "
				  + " source_type_code = '" + sourceType + "' "
				  + " AND subsource_type_code = '" + subsourceType + "' "
				  + " ORDER BY source_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}
	
	
	public String getAssetComponents(String assetType)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();		 
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT asset_component_name, asset_component_code "
				  + " FROM RWS_ASSET_COMPONENT_TYPE_TBL WHERE " 
				  +	" type_of_asset_code='" + assetType + "' "
				  + " ORDER BY asset_component_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}
	

	public String getAssetSubComponents(String assetTypeCode, String assetComponentCode)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
				
		try
		{
			conn = dataSource.getConnection();			 
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT asset_subcomponent_name, asset_subcomponent_code "
				  + " FROM rws_asset_subcomponent_tbl WHERE "
				  + " type_of_asset_code='" + assetTypeCode + "' "
				  + " AND asset_component_code = '" + assetComponentCode + "' "
				  + " ORDER BY asset_subcomponent_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{	
			closeAll();
		}
		return buffer.toString();
	}
	
	public String getAssetTasks(String assetType, String assetComponentCode, 
			String assetSubComponentCode)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT asset_task_name, asset_task_code "
				  + " FROM rws_asset_task_tbl "
				  + " WHERE type_of_asset_code = '" + assetType + "' "
				  + " AND asset_component_code = '" + assetComponentCode + "' "
				  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
				  + " ORDER BY asset_task_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
			
		}
		finally
		{
			closeAll();
		}
		return buffer.toString();
	}
	
	public String getAssetSubTasks(String assetType, String assetComponentCode, 
			String assetSubComponentCode, String assetTaskCode)
	{
		buffer = new StringBuffer();
		buffer.append("<?xml version=\"1.0\"?>");
		buffer.append("<selectChoice>");
		buffer.append("<selectElement>");
		buffer.append("<formName>" + formName + "</formName>");
		buffer.append("<formElement>" + formElement + "</formElement>");
		buffer.append("</selectElement>");
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			query = " SELECT asset_sub_task_name, asset_sub_task_code "
				  + " FROM rws_asset_sub_task_tbl "
				  + " WHERE type_of_asset_code = '" + assetType + "' "
				  + " AND asset_component_code = '" + assetComponentCode + "' "
				  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
				  + " AND asset_task_code = '" + assetTaskCode + "' "
				  + " ORDER BY asset_sub_task_name";
			
			rset = stat.executeQuery(query);
			rset.last();
			int rowCount = rset.getRow();
			if(rowCount == 0)
			{
				buffer.append("<entry>");
				buffer.append("<optionText>NO DATA...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
			}
			else
			{
				buffer.append("<entry>");
				buffer.append("<optionText>SELECT...</optionText>");
				buffer.append("<optionValue></optionValue>");
				buffer.append("</entry>");
				rset.beforeFirst();
				while(rset.next())
				{
					buffer.append("<entry>");
					buffer.append("<optionText>"+ rset.getString(1)+"</optionText>");
					buffer.append("<optionValue>"+ rset.getString(2)+"</optionValue>");
					buffer.append("</entry>");
				}
			}
			buffer.append("</selectChoice>");
		}
		catch(Exception e)
		{
		}
		finally
		{
			closeAll();
		}
		return buffer.toString();
	}
	public String getAssetSubTaskDesc(String assetType, String assetComponentCode, 
			String assetSubComponentCode, String assetTaskCode, String assetSubTaskCode)
	{
		String subTaskDesc ="";
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
			query = " SELECT asset_sub_task_desc "
				  + " FROM rws_asset_sub_task_tbl "
				  + " WHERE type_of_asset_code = '" + assetType + "' "
				  + " AND asset_component_code = '" + assetComponentCode + "' "
				  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
				  + " AND asset_task_code = '" + assetTaskCode + "' "
				  + " AND asset_sub_task_code = '" + assetSubTaskCode + "' "; 
				 
			rset = stat.executeQuery(query);
			if(rset.next())
				subTaskDesc = rset.getString(1); 			
		}
		catch(Exception e)
		{
		
		}
		finally
		{	closeAll();			
		}
		
		return subTaskDesc;
	}
	
	
	public String getWorkIds(String officeCode, String assetType)
	{
		ArrayList workIds = new ArrayList();
		try
		{
			query = " SELECT work_id , UPPER(proposal_name)  "
				  + " FROM rws_work_proposal_tbl WHERE substr(work_id,7,2) = '" + assetType + "' "
				  + " AND office_code = '" + officeCode + "' "
				  + " AND work_id NOT IN (SELECT work_id FROM rws_new_est_tbl) "
				  + " ORDER BY proposal_name" ;
			
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
				workIds.add(labelValueBean);
			}
		}
		catch(Exception e)
		{
			
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}
	
	public String getOMWorkIds(String officeCode, String assetType) throws Exception
	{
		ArrayList workIds = new ArrayList();
		
		try
		{
			query = " SELECT P.work_id , UPPER(A.asset_name) "
				  + " FROM rws_om_proposal_tbl P, rws_asset_mast_tbl A "
				  + " WHERE P.asset_code = A.asset_code "
				  + " AND work_id NOT IN (SELECT work_id FROM rws_om_est_tbl) "
				  + " AND P.work_id IS NOT NULL "
				  + " ORDER BY A.asset_name ";
						 
			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
				workIds.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}

	public String getFinancialYears(int num)
	{
		ArrayList financialYears = new ArrayList();
		
		dateFormatter = new SimpleDateFormat("yyyy");
		java.util.Date date = new java.util.Date();

		int currentYear = Integer.parseInt(dateFormatter.format(date));
		
		for(int i=0; i< num; i++)
		{
			String nextYear = String.valueOf(currentYear + "-") + String.valueOf(currentYear+1);
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(nextYear);
			labelValueBean.setLabel(nextYear);
			financialYears.add(labelValueBean);
			currentYear--;
		
		}
				
		return buffer.toString();
	}

	public String getProposalIds(String assetCode, String financialYear) throws Exception
	{
		financialYear = financialYear.substring(0,4);
		ArrayList proposalIds = new ArrayList();
		try
		{	
			query = " SELECT proposal_id FROM RWS_WORK_PROPOSAL_TBL "
				  + " WHERE substr(proposal_id,3,4) = '" + financialYear + "' "
				  + " AND type_of_asset = '" + assetCode + "' ";

			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1));
				proposalIds.add(labelValueBean);
			}
		}
		finally
		{	
			closeAll();
		}
		return buffer.toString();
	}


	public String getOMProposalIds(String financialYear) throws Exception
	{
		financialYear = financialYear.substring(0,4);
		ArrayList proposalIds = new ArrayList();
		try
		{	
			query = " SELECT om_proposal_id FROM rws_om_proposal_tbl "
				  + " WHERE substr(om_proposal_id,3,4) = '" + financialYear + "'";

			conn = dataSource.getConnection();
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1));
				proposalIds.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return buffer.toString();
	}

	
	public String getHabBeans(String[] habCodes) throws Exception
	{
		conn = dataSource.getConnection();
		ArrayList habitations = new ArrayList();
		for (int i=0; i<habCodes.length; i++)
		{
			query = " SELECT P.panch_code, P.panch_name, "
				  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
				  + " H.coverage_status FROM rws_panchayat_raj_tbl P, "
				  + " rws_habitation_directory_tbl H " 
				  +	" WHERE P.panch_code = H.hab_code AND "
				  + " P.panch_code = '" + habCodes[i] + "'";
						
			stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);		
			rset = stat.executeQuery(query);
			RwsLocationBean rwsLocation = null;
			
			while(rset.next())
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rset.getString(1));
				rwsLocation.setHabName(rset.getString(2));
				rwsLocation.setPopulation(rset.getString(3));
				rwsLocation.setStatus(rset.getString(4));
			}
			habitations.add(rwsLocation);
		}
		closeAll();
		return buffer.toString();
	}
	
	public String getAssetEndYears(String assetType) throws Exception
	{
		ArrayList endYears = new ArrayList();
		
		conn = dataSource.getConnection();
		stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		query = " SELECT distinct end_year FROM rws_asset_mast_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "'"
			  + " ORDER BY end_year ";
		rset = stat.executeQuery(query);
		 
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			endYears.add(labelValueBean);
		}
		closeAll();
		return buffer.toString();
	}
	
	/**
	 * Used in Representative Proposal Form for augmentation work
	 * @param assetType
	 * @param endYear
	 * @return String
	 * @throws Exception
	 */
	public String getAssetIds(String assetType, String endYear) throws Exception
	{
		
		
		conn = dataSource.getConnection();
		stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		query = " SELECT asset_code, asset_name FROM rws_asset_mast_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "'"
			  + " AND end_year = '" + endYear + "'";
		rset = stat.executeQuery(query);
		 
		while(rset.next())
		{
			
		}
		closeAll();
		return buffer.toString();
	}
	
	/* Remove this method 
	*/
	/*
	/**
	 * Gets dimensions for specified sub component 
	 * @param assetType
	 * @param componentCode
	 * @param subComponentCode
	 * @return ArrayList
	 * @throws Exception
	 */
	public String getComponentDimensions(String assetType, String componentCode, String subComponentCode)
	throws Exception
	{
		ArrayList dimensions = new ArrayList();
		conn = dataSource.getConnection();
		stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		query = " SELECT measurement_type, measurement_unit "
			  + " FROM rws_subcomp_param_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "' "
			  + " AND asset_component_code = '" + componentCode + "' "
			  + " AND asset_subcomponent_code = '" + subComponentCode+ "' ";

		rset = stat.executeQuery(query);
		while (rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setLabel(rset.getString(1));
			labelValueBean.setValue(rset.getString(2));
			dimensions.add(labelValueBean);
		}
		closeAll();
		return buffer.toString();
	}

}