
<%@ page import="java.text.DecimalFormat.*" %>
<%@ page import="nic.watersoft.commons.AAPreport1" %>
<%@ include file="/reports/conn.jsp" %>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "HabitationsCoverage.xls");

%>
<%
DecimalFormat ndf1 = new DecimalFormat("##.##");
Statement stmt8=null;
    ResultSet rs8=null;
    Hashtable wrks=(Hashtable)session.getAttribute("wrks");
    Hashtable est_hash=(Hashtable)session.getAttribute("est_hash");
    Hashtable exp_hash=(Hashtable)session.getAttribute("exp_hash");
    ArrayList aapdetails=(ArrayList)session.getAttribute("aapdetails");
    String qry="";
    int styleCount=0;
    String style="";

	String status="";
    String div="";
    int count=0;
    int sno=1;
    
    String nsscount="";
    String nccount="";
    String pc1count="";
    String pc2count="";
    String pc3count="";
    String pc4count="";
    String fccount="";
    int h1=0;
    int workcount=0;
    
    int ghabcount=0;
    int gnsscount=0;
    int gnccount=0;
    int gpc1count=0;
    int gpc2count=0;
    
    int gpc3count=0;
    int gpc4count=0;
    int gfccount=0;
    String dcode=(String)session.getAttribute("dcode");
    String financialyr=(String)session.getAttribute("financialyr");
    
    String yr =financialyr.substring(0,4);
    String yr1=""+(Integer.parseInt(yr)+1);
	
     
    
   	%>
	
<%@page import="java.text.DecimalFormat"%><table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	
	   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
      
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Total works</td>
        <td class=gridhdbg rowspan=2>Bal Est<br>As On 01.04.<%=yr %></br></td>
    
    <td class=gridhdbg rowspan=2>Total</td>
    <td class=gridhdbg colspan=7>Coverage Of Habitations</td>
    
	
	</tr>
	<tr>
	<td class=gridhdbg >NSS</td>
	<td class=gridhdbg >NC</td>
	<td class=gridhdbg >PC1</td>
	
	<td class=gridhdbg >PC2</td>
	<td class=gridhdbg >PC3</td>
	<td class=gridhdbg >PC4</td>
	<td class=gridhdbg >FC</td>
	</tr>
        
<%
try
{
	stmt8=conn.createStatement();
	   if(dcode.equals("00"))
	   {
	qry="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<> '16'";
	   }
	   else
	   {
		 qry=  "select  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+dcode+"'";
	   }
		
	   int gworkCount=0;
	   
	   int a1=0;
	  // ////System.out.println("qry1***************"+qry); 
		rs8=stmt8.executeQuery(qry);
		
	    double estimateamnt=0.0,expamnt=0.0,balance=0.0;
	    double gestimateamnt=0.0,gexpamnt=0.0,gbalance=0.0;
		while (rs8.next())
		{
			int nss1=0;
		    int nc1=0;
		    int pc1=0;
		    int pc2=0;
		    int pc3=0;
		    int pc4=0;
		    int fc=0;
		    int habcount=0;
			if(wrks.get(rs8.getString(1))!=null){
				workcount=(Integer)wrks.get(rs8.getString(1));
			}
			gworkCount+=workcount;
			
			
			
			
			//System.out.println("habcount="+habcount+"/totl"+ghabcount);
			if(est_hash.get(rs8.getString(1))!=null){
				estimateamnt=Double.parseDouble((String)est_hash.get(rs8.getString(1)));
			}
			if(exp_hash.get(rs8.getString(1))!=null){
				expamnt=Double.parseDouble((String)exp_hash.get(rs8.getString(1)));
			}
			balance=estimateamnt-expamnt;
			//
			for(int i=0;i<aapdetails.size();i++){
				if(((AAPreport1)aapdetails.get(i)).getHabtype().equals(rs8.getString(1))){
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("NC")){
						nc1++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("FC")){
						fc++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC1")){
						pc1++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC2")){
						pc2++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC3")){
						pc3++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC4")){
						pc4++;
					}
					if(((AAPreport1)aapdetails.get(i)).getStatus().equals("NSS")){
						nss1++;
					}
				}
				
			}
			habcount=nc1+fc+pc1+pc2+pc3+pc4+nss1;
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		

		 
	%>
		<tr>
		
	    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=workcount%></td>
	    <td  class="<%=style%> "style="text-align: right;"> <%=ndf1.format(balance)%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=habcount%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=nss1%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=nc1%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=pc1%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=pc2%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=pc3%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=pc4%></td>
	   <td  class="<%=style%> "style="text-align: right;"> <%=fc%></td>
	   
	   
	    <%
	    gnccount+=nc1;
	    gnsscount+=nss1;
	    gpc1count+=pc1;
	    gpc2count+=pc2;
	    gpc3count+=pc3;
	    gpc4count+=pc4;
	    gfccount+=fc;
	    gbalance+=balance;
	    ghabcount+=habcount;
		} %>
		<tr>
	   	<td  class=gridhdbg style="text-align: left;"> </td>
	   	<td  class=gridhdbg style="text-align: right;">Total: </td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gworkCount%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=ndf1.format(gbalance)%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=ghabcount%></td>
	   		<td  class=gridhdbg style="text-align: right;"> <%=gnsscount%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gnccount%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gpc1count%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gpc2count%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gpc3count%></td>
	   	<td  class=gridhdbg style="text-align: right;"> <%=gpc4count%></td>
	   	   	<td  class=gridhdbg style="text-align: right;"> <%=gfccount%></td>
	   	
	   	</tr>
	   	
		<%
		}catch(Exception e)
			{
			e.printStackTrace();
			}
	finally
	{
	try
	{
	if(stmt8 != null)
	{
	stmt8.close();
	}
	if(rs8 != null)
	{
	rs8.close();
	}
	if( conn != null )
	{
	conn.close();
	}

	}
	catch(SQLException p)
	{
	p.printStackTrace();
	}
	}
	%>
	    
	</table>
