<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "drought daily.xls");


ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
Statement pst = null,pst2=null,pst3=null,pst4=null,pst5=null;
int count=1,hcount=0,pvtsum=0,display=0;
int habcount=0,habcount1=0,popcount=0,tankcount=0,qtycount=0,sourcecount=0,popcount1=0,tankcount1=0,qtycount1=0,commcount=0,tripcount=0;
int hab_sum=0,hab_sum1=0,hab_sum2=0,pop_sum=0,tank_sum=0,source_sum=0,pop_sum1=0,pop_sum2=0,comm_sum=0;
float trip_sum=0,trip_sum1=0,qty_sum=0,qty_sum1=0,qty_sum2=0;
//String h1values="",h3values="",h2values="";


StringBuffer h1values = new StringBuffer();
StringBuffer h2values = new StringBuffer();
StringBuffer h3values = new StringBuffer();
StringBuffer h4values = new StringBuffer();

//String currentdate=(String)session.getAttribute("currentdate");
StringBuffer currentdate=null;
currentdate=new StringBuffer(String.valueOf(session.getAttribute("currentdate")));
//////System.out.println("currentdate"+currentdate);
StringBuffer  rvalue= new StringBuffer();
rvalue.append(String.valueOf(session.getAttribute("rvalue")));
//////System.out.println("rvalue"+rvalue);

//String rvalue=(String)session.getAttribute("rvalue");
//StringBuffer rvalue=null;
//rvalue=new StringBuffer(String.valueOf(session.getAttribute("rvalue")));
if(rvalue.toString()==null)
rvalue.append(currentdate);


//String mydate = (String)session.getAttribute("rvalue");
StringBuffer mydate=null;
mydate=new StringBuffer(String.valueOf(session.getAttribute("rvalue")));
//////System.out.println("mydate"+mydate);


//String dcode = (String)session.getAttribute("dcode");
StringBuffer dcode=null;
dcode=new StringBuffer(String.valueOf(session.getAttribute("dcode")));
//////System.out.println("dcode"+dcode);


//String dname = (String)session.getAttribute("dname");
StringBuffer dname=null;
dname=new StringBuffer(String.valueOf(session.getAttribute("dname")));
//////System.out.println("dname"+dname);


//String edate = (String)session.getAttribute("edate");
StringBuffer edate=null;
edate=new StringBuffer(String.valueOf(session.getAttribute("edate")));
//////System.out.println("edate"+edate);


//////System.out.println("year"+year);
SimpleDateFormat df = new SimpleDateFormat("yyyy");
Date date1= new Date();


StringBuffer year=new StringBuffer();
year=new StringBuffer(String.valueOf(session.getAttribute("year")));

%>

<html>

<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		

<%

//String h1v1="";
//String h1v2="";
//String h1v3="";
//String h1v4="";
//String h1v5="";
//String h1v6="";
StringBuffer h1v1=new StringBuffer();
StringBuffer h1v2=new StringBuffer();
StringBuffer h1v3=new StringBuffer();
StringBuffer h1v4=new StringBuffer();
StringBuffer h1v5=new StringBuffer();
StringBuffer h1v6=new StringBuffer();


//String h2v1="";
//String h2v2="";
//String h2v3="";
//String h2v4="";
//String h2v5="";
//String h2v6="";
StringBuffer h2v1=new StringBuffer();
StringBuffer h2v2=new StringBuffer();
StringBuffer h2v3=new StringBuffer();
StringBuffer h2v4=new StringBuffer();
StringBuffer h2v5=new StringBuffer();
StringBuffer h2v6=new StringBuffer();

//String h3v1="";
//String edate="";
//String cdate="";
StringBuffer h3v1=new StringBuffer();
//StringBuffer edate=new StringBuffer();
StringBuffer cdate=new StringBuffer();


StringBuffer h4v1=new StringBuffer();
StringBuffer h4v2=new StringBuffer();
StringBuffer h4v3=new StringBuffer();
StringBuffer h4v4=new StringBuffer();
StringBuffer h4v5=new StringBuffer();
StringBuffer h4v6=new StringBuffer();

DateFormat formatter1;
java.util.Date hdate ; 
float v11=0,v12=0,v13=0,v14=0,v15=0,v16=0,v17=0,v18=0;
float v19=0,v20=0,v21=0,v22=0;
StringBuffer query=new StringBuffer();
try
{   
              
	%>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=14>DAILY REPORT ON DRINKING WATER SITUATION&nbsp;&nbsp;:&nbsp;&nbsp;<%=rvalue.toString()%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>

		
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>
            <td class=btext rowspan=2>Daily report<br>data available<br>as on given date</td>
            <td class=btext colspan="4">Transportation</td>
             <td class=btext colspan="4">Cattle</td>
            <td class=btext colspan="4">Hiring of Private Sources</td>
            <td class=btext rowspan=2>No.of Habitations <br>having irregular<br> Power Supply/Low <br>Voltage/Insufficient <br>Supply</td>
			
 		</tr>
		<tr align="center">
            <td class=btext>No. of Habs</td>	
			<td class=btext>Population Covered</td>	
			<td class=btext>No.of Trips </td>
            <td class=btext>Quantity in KL </td>
            <td class=btext>No. of Habs</td>	
			<td class=btext>Population Covered</td>	
			<td class=btext>No.of Trips </td>
            <td class=btext>Quantity in KL </td>
            
			<td class=btext>No of Habs</td>
			<td class=btext>Population Served</td>
			<td class=btext>No.of Sources</td>
            <td class=btext>Quantity in KL</td>
			
		</tr>
       <tr align="center">
            <td class=btext>1</td>	
			<td class=btext>2</td>	
			<td class=btext>3</td>
            <td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7</td>
            <td class=btext>8</td>
            <td class=btext>9</td>
			<td class=btext>10</td>
            <td class=btext>11</td>
            <td class=btext>12</td>
             <td class=btext>13</td>
			<td class=btext>14</td>
            <td class=btext>15</td>
            <td class=btext>16</td>
			
			
		</tr>
     
        <%
        
      
        
      

        Hashtable h2=(Hashtable)session.getAttribute("h2");
        Hashtable h1=(Hashtable)session.getAttribute("h1");
        Hashtable h3=(Hashtable)session.getAttribute("h3");
        Hashtable h4=(Hashtable)session.getAttribute("h4");
         
          
          
  	    query.delete(0,query.length());
  	    
            //String qry1="select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
          query.append("select dcode,dname from rws_district_tbl order by dcode");  
            pst2=conn.createStatement();
            //rs2=pst2.executeQuery(qry1);
            rs2=pst2.executeQuery(query.toString());
   //         ////System.out.println("fourth-(district) qry..."+query.toString());
            while(rs2.next())
            {
              //h3values
              //h3values=(String)h3.get(rs2.getString(1));
              h3values.delete(0,h3values.length());
              h3values.append(h3.get(rs2.getString(1)));
              if(h3values!=null&& !h3values.toString().equals("null"))
  	        {

               //String v3[]=h3values.split("@");
               String v3[]=h3values.toString().split("@");
                        
               h3v1.delete(0,h3v1.length());
               h3v1.append(v3[0]);//entry date
               
               
               edate.delete(0,edate.length());
               edate.append(h3v1.toString().substring(0,10));//string date
               cdate.delete(0,cdate.length());
               cdate.append(edate.toString().replace("-","/"));

  	//		////System.out.println("Converted string to date : " + cdate); 
               }
  			else
  			{
               //h3v1="";
                 h3v1.delete(0,h3v1.length());
               h3v1.append("");
  			}

              //end
              

            // h1values=(String)h1.get(rs2.getString(1)+cdate);
              h1values.delete(0,h1values.length()); 
              h1values.append(h1.get(rs2.getString(1)+cdate));
               
              if(h1values!=null&& !h1values.toString().equals("null"))
  	        {
             
              // String v1[]=h1values.split("@");
              String v1[]=h1values.toString().split("@");
              
            
            h1v1.delete(0,h1v1.length());
            h1v2.delete(0,h1v2.length());
            h1v3.delete(0,h1v3.length());
            h1v4.delete(0,h1v4.length());
            h1v5.delete(0,h1v5.length());
            h1v6.delete(0,h1v6.length());
            
            
             h1v1.append(v1[0]);//count
             h1v2.append(v1[1]);//pop
             h1v3.append(v1[2]);//trips
             h1v4.append(v1[3]);//qty
             h1v5.append(v1[4]);//date
             h1v6.append(v1[5]);//power
             
             

             v17=Integer.parseInt(h1v1.toString().equals("null")?"0":h1v1.toString());//count
			 v11=Integer.parseInt(h1v2.toString().equals("null")?"0":h1v2.toString());//pop
			 v12=Float.parseFloat(h1v3.toString().equals("null")?"0":h1v3.toString());//trips
			 v13=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v4.toString());//qty
			
            hab_sum+=v17; 			
			pop_sum+=v11;
			trip_sum+=v12;
			qty_sum+=v13;
			
			}
          
			else
			{
                 v11=0;
                 v12=0;
                 v13=0;
                 v17=0;
                // h1v5="";//date
                h1v5.delete(0,h1v5.length());
                h1v5.append("");
               
	        } 


            
            
            //h2values=(String)h2.get(rs2.getString(1)+cdate);
            h2values.delete(0,h2values.length());
            h2values.append(h2.get(rs2.getString(1)+cdate));
            
            
            if(h2values!=null && !h2values.toString().equals("null"))
	        {
            	   
             //String v2[]=h2values.split("@");
             String v2[]=h2values.toString().split("@");
          
              
              h2v1.delete(0,h2v1.length());
              h2v2.delete(0,h2v2.length());
              h2v3.delete(0,h2v3.length());
              h2v4.delete(0,h2v4.length());
              h2v5.delete(0,h2v5.length());
              h2v6.delete(0,h2v6.length());
              
              
              
             h2v1.append(v2[0]);//count
             h2v2.append(v2[1]);//pop
             h2v3.append(v2[2]);//trips
             h2v4.append(v2[3]);//qty
             h2v5.append(v2[4]);//date
             h2v6.append(v2[5]);//power

             v18=Integer.parseInt(h2v1.toString().equals("null")?"0":h2v1.toString());//count
			 v14=Integer.parseInt(h2v2.toString().equals("null")?"0":h2v2.toString());//pop
			 v15=Float.parseFloat(h2v3.toString().equals("null")?"0":h2v3.toString());//trips
			 v16=Float.parseFloat(h2v4.toString().equals("null")?"0":h2v4.toString());//qty
				
                  
		            hab_sum1+=v18;			
					pop_sum1+=v14;
					source_sum+=v15;
					qty_sum1+=v16;
			    }
          
			else
			{
                 v14=0;
                 v15=0;
                 v16=0;
                 v18=0;
	        } 
            
            h4values.delete(0,h4values.length()); 
            h4values.append(h4.get(rs2.getString(1)+cdate));
             
            if(h4values!=null&& !h4values.toString().equals("null"))
	        {
           
            // String v4[]=h4values.split("@");
            String v4[]=h4values.toString().split("@");
            h4v1.delete(0,h4v1.length());
            h4v2.delete(0,h4v2.length());
            h4v3.delete(0,h4v3.length());
            h4v4.delete(0,h4v4.length());
            h4v5.delete(0,h4v5.length());
            h4v6.delete(0,h4v6.length());
            
            
          
            
            
             h4v1.append(v4[0]);//count
             h4v2.append(v4[1]);//pop
             h4v3.append(v4[2]);//trips
             h4v4.append(v4[3]);//qty
             h4v5.append(v4[4]);//date
             h4v6.append(v4[5]);//power
             v19=Integer.parseInt(h4v1.toString().equals("null")?"0":h4v1.toString());//count
			 v20=Integer.parseInt(h4v2.toString().equals("null")?"0":h4v2.toString());//pop
			 v21=Float.parseFloat(h4v3.toString().equals("null")?"0":h4v3.toString());//trips
			 v22=Float.parseFloat(h4v4.toString().equals("null")?"0":h4v4.toString());//qty
             
             

            
			 hab_sum2+=v19; 			
				pop_sum2+=v20;
				trip_sum1+=v21;
				qty_sum2+=v22;
			
           
			
			}
          
			else
			{
                 v19=0;
                 v20=0;
                 v21=0;
                 v22=0;
                // h1v5="";//date
                h4v5.delete(0,h4v5.length());
                h4v5.append("");
               
			}

          
         %>

            <tr align="center">
            <td class=rptvalue align="left"><%=count++%></td>
            <%if(v17>0||v18>0){ %>   
            <td class=rptvalue align="left"><b><%=rs2.getString(2)%></b></td>                
	        <%}else{%>
            <td class=rptvalue align="left"><%=rs2.getString(2)%></td>                
            <%}%>
          
            <%if(!h1v5.equals("")){ %>
            <td class=rptvalue align="right"><%=h1v5%></td>
            <%}else{%>
            <td class=rptvalue align="right"><%=h2v5%></td>
            <%}if(v17>0){ %>           
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h1v1%></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h1v2%></td>	
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v12%></td>	
			<td class=rptvalue align="right"  bgcolor="#FFB280"><%=v13%></td>	
             <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>
			<%}if(v19>0){ %>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h4v1%></td>
           	<td class=rptvalue align="right"  bgcolor="#FFB280"><%=h4v2%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v21%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v22%></td>	
            <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>		
            <%}if(v18>0){ %>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h2v1%></td>
           	<td class=rptvalue align="right"  bgcolor="#FFB280"><%=h2v2%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v15%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v16%></td>	
            <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>	
            <%}%>
		    <td class=rptvalue align="right">-</td>
			
		</tr>
<%
}

 %>
<tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=3>Totals</td>
           
            <td class=btext align="right"><%=hab_sum%></td>
            <td class=btext align="right"><%=pop_sum%></td>	
			<td class=btext align="right"><%=trip_sum%></td>	
			<td class=btext align="right"><%=qty_sum%></td>  
			<td class=btext align="right"><%=hab_sum2%></td>
            <td class=btext align="right"><%=pop_sum2%></td>	
			<td class=btext align="right"><%=trip_sum1%></td>	
			<td class=btext align="right"><%=qty_sum2%></td>                      
            <td class=btext align="right"><%=hab_sum1%></td>
			<td class=btext align="right"><%=pop_sum1%></td>
            <td class=btext align="right"><%=source_sum%></td>
            <td class=btext align="right"><%=qty_sum1%></td>          
			<td class=btext align="right"><%=comm_sum%></td>
            
			
		</tr>
<%

}
catch(Exception e)
{
	e.printStackTrace();
}

finally
{
	  h1values = null;
	  h2values = null;
	  h3values = null;
	  currentdate=null;
	  rvalue= null;
	  mydate=null;
	  dcode=null;
	  dname=null;
	  edate=null;
	  year=null;
	  h1v1=null;
	  h1v2=null;
	  h1v3=null;
	  h1v4=null;
	  h1v5=null;
	  h1v6=null;
	  h2v1=null;
	  h2v2=null;
	  h2v3=null;
	  h2v4=null;
	  h2v5=null;
	  h2v6=null;
	  h3v1=null;
	  h4v1=null;
	  h4v2=null;
	  h4v3=null;
	  h4v4=null;
	  h4v5=null;
	  h4v6=null;
	  cdate=null;
	  query=null;

			
try
{
	if(pst != null)
	{
	pst.close();
	}
	if(pst2 != null)
	{
	pst2.close();
	}
	if(pst3 != null)
	{
	pst3.close();
	}
	if(rs1 != null)
	{
	rs1.close();
	}
	if(rs2 != null)
	{
	rs2.close();
	}
	if(rs3 != null)
	{
	rs3.close();
	}
	if( conn != null )
	{
	conn.close();
	}
}catch(Exception e)
{
	e.printStackTrace();
}
}
%>
</table>
</body>
</html>
