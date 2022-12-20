<%@ page import="java.io.*,java.util.*,java.sql.*, javax.sql.DataSource,javax.naming.*,java.util.Arrays"%>

<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>



<body>
<form name="leform">
	<%
	  //String fileLocation = "C:\\Tomcat 5.0\\webapps\\pred\\uploads\\proposals";
		
		//String fileLocation = "/pred/uploads/proposals";
		
		
		String fileLocation = "/apd8/pred/app/uploads/estimates";

		File f=new File(fileLocation);
		String[] fileNames=f.list();
		String[] leFileNames;
		String[] years;
		String[] years1;
		String[] circles;
		String[] circlenames;
		int count=0,j=0;
		String mode;
		mode=request.getParameter("mode");
		Set s;
		%>

		
		<%		
		if(mode.equalsIgnoreCase("data"))
		{		
		%>
		
		
		
		<%
		if(fileNames!=null && fileNames.length>0)
		{
			
			leFileNames=new String[fileNames.length];
			
			years1=new String[fileNames.length];
			
			%>

			<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="Line Estimates" />
				<jsp:param name="TWidth" value="160" />
			</jsp:include>

			<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="200">

			<tr><td>Year</td><td>
			<input type="hidden" name="mode" value="data1"/>
			<select name="year" styleClass="mycombo" style="width:100" onChange="document.leform.submit()">
			
			<%
			out.println("<option >select...</option>");
			for(int i=0;i<fileNames.length;i++)
			{	
				if(fileNames[i].substring(0,3).equalsIgnoreCase("LE_"))
				{
					count++;
					leFileNames[j]=fileNames[i];
					j=j+1;
//					
				}
			}
			years=new String[j];
            j=0;
			count=0;
			for(int i=0;i<fileNames.length;i++)
			{	
				if(fileNames[i].substring(0,3).equalsIgnoreCase("LE_"))
				{
					count++;
					leFileNames[j]=fileNames[i];
					years[j]=leFileNames[j].substring(5,9);
					j=j+1;
//					
				}
			}



		

		
		
		int k = 1; 
		//System.out.println("years len="+years.length);
		//Arrays.sort(years);
		for (int i = 1; i <years.length; i++) 
        { 
            //System.out.println("years[i]="+years[i]+"years[i-1]="+years[i-1]);
			if (! years[i].equals(years[i -1])) 
            years[k++] = years[i]; 
        } 
		
		
		String[] unique = new String[k]; 
		//System.arraycopy(years, 0, unique, 0, k);
		//System.out.println(unique.length);
		for (int i=0; i<unique.length; i++) 
		out.println("<option>"+unique[i]+"</option>"); 

		%>
		
		</select>
		</td></tr>

		</table>
		<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
		   <TR>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_left1.gif'/>" ALT=""></TD>
			  <TD  bgcolor="#8A9FCD" width=160>
			  <FONT  style="font-size:8pt" color="#FFFFFF"><font color="#FF6666" >*</font>&nbsp;Select Data</FONT></td>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_right1.gif'/>" ALT=""></TD>
		</TABLE>
		<%			
	}
	else
			
	  out.println("<center><font color='#FF6666'>NO Estimates In This Directory</font></center>");

		
}

if(mode.equalsIgnoreCase("data1"))
	{

	%>

		<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="Line Estimates" />
				<jsp:param name="TWidth" value="160" />
			</jsp:include>

		<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="200">

		<%
		String year=request.getParameter("year");
		
		if(fileNames!=null && fileNames.length>0)
		{
			
			leFileNames=new String[fileNames.length];
			circles=new String[fileNames.length];
			circlenames=new String[fileNames.length];
		%>
		 <tr><td>Year</td><td>
			<input type="hidden" name="mode" value="data2"/>
			<select name="year" styleClass="mycombo" style="width:100" onChange="document.leform.submit())">			
			
			<option><%=year%></option></select></td></tr>
			<tr><td>Circle</td><td>
			<select name='circle' styleClass='mycombo' style='width:100' >
		<%				
			j=0;
			for(int i=0;i<fileNames.length;i++)
			{	
				if(fileNames[i].substring(0,3).equalsIgnoreCase("LE_") && fileNames[i].substring(5,9).equalsIgnoreCase(year))
				{					
					
					leFileNames[j]=fileNames[i];
					circles[j]=leFileNames[j].substring(9,11);

				try
					{
					Context ic = new InitialContext();
					DataSource ds =(DataSource)ic.lookup("java:comp/env/jdbc/pred");
					Connection conn = ds.getConnection();
					//System.out.println("Connection :"+conn);
					Statement stmt=conn.createStatement();
					
					ResultSet rs=stmt.executeQuery("select circle_office_name from RWS_CIRCLE_OFFICE_TBL where CIRCLE_OFFICE_CODE='"+circles[j]+"' and HEAD_OFFICE_CODE=1");
					j++;
					
					if(rs.next())
					{
						circlenames[j]=rs.getString(1);
						
					}
					}//try
					catch(Exception e)
					{
						//System.out.println("Exception due to:"+e);
					}//catch

				}//if
			}//for

		
		Set set = new HashSet(Arrays.asList(circlenames)); 
	    String[] array2 = (String[])(set.toArray(new String[set.size()])); 
		//System.out.println("len="+array2.length);
		for(int i=0;i<array2.length;i++)
		{
		if(array2[i]==null)
		continue;
		out.println("<option>"+array2[i]+"</option>");
		}
		


			out.println("</td></tr></select>"); 
		}//if
		%>

		
		<tr>
			<td colspan="2" align="center">
			<input type="button"  title="View the Fields" styleClass="btext" value="View" onClick="document.leform.submit()" />	 
			</td>
		</tr>


		</table>
		<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
		   <TR>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_left1.gif'/>" ALT=""></TD>
			  <TD  bgcolor="#8A9FCD" width=160>
			  <FONT  style="font-size:8pt" color="#FFFFFF"><font color="#FF6666" >*</font>&nbsp;Select Data</FONT></td>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_right1.gif'/>" ALT=""></TD>
		</TABLE>
	<%
	}//mode if
	
	if(mode.equalsIgnoreCase("data2"))
	{
		String year=request.getParameter("year");
		String circle=request.getParameter("circle");
		try
		{
			Context ic = new InitialContext();
			DataSource ds =(DataSource)ic.lookup("java:comp/env/jdbc/pred");
			Connection conn = ds.getConnection();
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select circle_office_code from rws_circle_office_tbl where circle_office_name='"+circle+"' and head_office_code=1");
			//System.out.println("file len="+fileNames.length);
			if(fileNames!=null && fileNames.length>0)
			{			
				leFileNames=new String[fileNames.length];
				%>

				<jsp:include page="/commons/TableHeader.jsp">
					<jsp:param name="TableName" value="List Of Line Estimates" />
					<jsp:param name="TWidth" value="190" />
				</jsp:include>
			
				<table  bgcolor="b0e2f" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse" width="230" >
				<%

				j=1;				
				rs.next();
				for(int i=0;i<fileNames.length;i++)
				{	
					

 					if(fileNames[i].substring(0,3).equalsIgnoreCase("LE_") && fileNames[i].substring(5,9).equalsIgnoreCase(year) && fileNames[i].substring(9,11).equalsIgnoreCase(rs.getString(1)))
					{					
						count++;
						leFileNames[j]=fileNames[i];						
						%>
						<tr align=center><td><font color=4682b4 size=2><%=j%>.<font><a href=/pred/uploads/proposals/<%=fileNames[i]%> target="_new"><%=fileNames[i] %></a></td></tr>
						<%
							j++;
					}
					
				}
			}//data2
		
			%>
		
		</table>
		<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
		   <TR>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_left1.gif'/>" ALT=""></TD>
			  <TD  bgcolor="#8A9FCD" width=190>
			  <FONT  style="font-size:8pt" color="#FFFFFF"><font color="#FF6666" >*</font>&nbsp;Click the file name to open</FONT></td>
			  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_right1.gif'/>" ALT=""></TD>
		</TABLE>
		<%

			}
			catch(Exception e)
			{
			//System.out.println("Exception due to :"+e);
			}
		}
	%>


</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>


