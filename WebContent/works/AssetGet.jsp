<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>
<script language="javascript">

</script>
<% 		
String astwrk=request.getParameter("astwrk");
String asttype = request.getParameter("asttype");
String index = request.getParameter("index");
String cir=request.getParameter("circle");
String div=request.getParameter("divcode");
String subdiv=request.getParameter("subdiv");
//System.out.println("circl:"+cir);
//System.out.println("div:"+div);
//System.out.println("subdivison:"+subdiv);

Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
  //  int len =a.length();
   String getMandals = "";
   if(astwrk.equals("1")){
   	//System.out.println("circl:"+cir);
  	//System.out.println("div:"+div);
	//System.out.println("subdivison:"+subdiv);
	   getMandals = "select asset_code,asset_name from rws_asset_mast_tbl where type_of_asset_code='"+asttype+"'";
	   if(cir!=null && !cir.equals(""))
	   {
		   getMandals +=" and  circle_office_code='"+cir+"'";
	   }
	    if(div!=null && !div.equals(""))
	   {
		 getMandals +=" and  division_office_code='"+div+"'";
	   }
	    if(subdiv!=null && !subdiv.equals(""))
	   {
	     getMandals +=" and  subdivision_office_code='"+subdiv+"'";
	   } 
	  } 
   else   if(astwrk.equals("2"))
		{
		//System.out.println("circl:"+cir);
		//System.out.println("div:"+div);
		//System.out.println("subdivison:"+subdiv);
		getMandals = "select work_id,work_name from rws_work_admn_tbl where substr(work_id,7,2)='"+asttype+"' and aug_new_code='1'";
		if(cir!=null && !cir.equals(""))
	   {
		   getMandals +=" and  substr(office_code,2,2)='"+cir+"'";
	   }
	    if(div!=null && !div.equals(""))
	   {
		 getMandals +=" and  substr(office_code,4,1)='"+div+"'";
	   }
	   if(subdiv!=null && !subdiv.equals(""))
	   {
	     getMandals +=" and  substr(office_code,5,2)='"+subdiv+"'";
	   } 
		}
   Statement gmst = conn.createStatement();
   //System.out.println("qry:"+getMandals);
   ResultSet gmrs = gmst.executeQuery(getMandals);
   ArrayList gm = new ArrayList();
   int i = 0;
%>
<select name=assets<%=index%> style=width:250px  styleClass=mycombo onchange="fnAssets(<%=index%>)">
<OPTION VALUE="">SELECT..</OPTION>


<%
   while(gmrs.next())
	{
%>
<option value="<%=gmrs.getString(1)%>"><font face=verdana size=2><%=gmrs.getString(1)%>-<%=gmrs.getString(2)%></font><br>
<%
 
}
%>
</select>
<%
}
   catch(Exception e)
   {
		// System.out.println("EXCEPTION IN AssetGet Jsp: "+e.getMessage());
   } 
   finally
   {
try
{
	   if(rs123!=null)rs123.close();
	   if(st!=null)st.close();
}
catch(Exception d)
{
	
}
   }
	%>

