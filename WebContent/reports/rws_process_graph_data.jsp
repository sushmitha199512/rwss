<%@ include file="/reports/conn.jsp"  %>
<%@ page import="nic.watersoft.commons.*"  %>
<%@ page import="java.io.*,java.util.*,java.text.*" %>

<%@ include file="/dashboards/Includes/Functions.jsp" %>

<% 
String finYear="2013-2014";
String type=request.getParameter("type");
String strXML="";

if(type!=null && type.equals("phy")){
	  	
	 ArrayList colorsCodes=getColorCodes();
       
		//Initialize <graph> element
		strXML = "<graph caption='Habitaion Achievement (%) ' subCaption='Financial Year "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
         

		try{
               String query="select *from rws_svs_graph_view_tbl";
               //System.out.println("Query:"+query);
               Statement stmtgraph = conn.createStatement();
   			ResultSet rrs = stmtgraph.executeQuery(query);
   			int jj=0;
               while(rrs.next()){
				
            	   if(jj==11){
            		   jj=0;
            	   }
            	   strXML = strXML + "<set name='" + rrs.getString(2)
						+ "'  value='" + rrs.getString(3) + "' color='" + colorsCodes.get(jj)
						+ "' />";
						
            	   jj++;
               }



		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";
		System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }  else if(type!=null && type.equals("fin")){
  	
	 ArrayList colorsCodes=getColorCodes();
      
		//Initialize <graph> element
		strXML = "<graph caption='Expenditure Achievement (%)' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==11){
           		   jj=0;
           	   }
           	   
           	   strXML = strXML + "<set name='" + rrs.getString(2)
						+ "'  value='" + rrs.getString(4) + "' color='" + colorsCodes.get(jj)
						+ "' />";
						
           	   jj++;
              }



		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }   %>