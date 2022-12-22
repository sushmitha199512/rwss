package nic.watersoft.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.beanutils.RowSetDynaClass;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RoleViewAction extends Action 
{
	private Connection conn = null;
	private Statement stat = null;
	private ResultSet rset = null;
	private RowSetDynaClass rowSet = null;
	private String query =  null;
	private String target = null;
	
	private void fetchRecords(DataSource dataSource)
	{	
		query = " SELECT role_id, role_name, role_description FROM rws_roles_tbl "
			  + " ORDER BY role_id "	;
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			rowSet = new RowSetDynaClass(rset);
		}
		catch(Exception e)
		{	//System.out.println("Role View: " + e);
		}
		finally
		{
			if(rset != null)
			{
				try
				{	rset.close();	
				}
				catch(SQLException e)
				{	System.err.println(e);					
				}
				rset = null;
			}
			if(stat != null)
			{
				try
				{	stat.close();	
				}
				catch(SQLException e)
				{	System.err.println(e);
				}
				stat = null;
			}
			if(conn != null)
			{
				try
				{	conn.close();	
				}
				catch(Exception e)
				{	//System.out.println(e+"");
				}
				conn = null;
			}
		}
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		target = new String("success");
		String mode = request.getParameter("mode");
		fetchRecords(getDataSource(request));
		request.setAttribute("rowSet",rowSet);
		return(mapping.findForward(target));
	}
}
