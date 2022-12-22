<%@ include file="/reports/conn.jsp"  %>
<%@ page import="nic.watersoft.commons.*"  %>
<%@ page import="java.io.*,java.util.*,java.text.*" %>



<% 
String finYear="2013-2014";
String type=request.getParameter("type");
String strXML="";


ArrayList colorsCodes=new java.util.ArrayList();	
colorsCodes.add("F6BD0F");
colorsCodes.add("8BBA00");

colorsCodes.add("FF8E46");
colorsCodes.add("008E8E");
colorsCodes.add("8E468E");
colorsCodes.add("D64646");
colorsCodes.add("588526");
colorsCodes.add("B3AA00");
colorsCodes.add("008ED6");
colorsCodes.add("9D080D");
colorsCodes.add("A186BE");
colorsCodes.add("F6BD0F");
colorsCodes.add("000080");
colorsCodes.add("006400");
colorsCodes.add("7cfc00");
colorsCodes.add("ffff00");
colorsCodes.add("ffa07a");
colorsCodes.add("e9967a");


if(type!=null && type.equals("phy")){
	  	

       
		//Initialize <graph> element
		strXML = "<graph caption='Habitaion Achievement (%) -(Single Village Scheme) ' subCaption='Financial Year "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
         

		try{
               String query="select *from rws_svs_graph_view_tbl where type='SVS' order by dcode";
               //System.out.println("Query:"+query);
               Statement stmtgraph = conn.createStatement();
   			ResultSet rrs = stmtgraph.executeQuery(query);
   			int jj=0;
               while(rrs.next()){
				
            	   if(jj==17){
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
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }  else if(type!=null && type.equals("fin")){
  	
	
      
		//Initialize <graph> element
		strXML = "<graph caption='Expenditure Achievement (%) -(Single Village Scheme)' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl  where type='SVS' order by dcode";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==17){
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

<% }  else if(type!=null && type.equals("phyM")){
  	
	
      
		//Initialize <graph> element
		strXML = "<graph caption='Habitaion Achievement (%) (Multi Village Scheme)' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl  where type='MVS' order by dcode";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==17){
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
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }  else if(type!=null && type.equals("finM")){
  	
	
      
		//Initialize <graph> element
		strXML = "<graph caption='Expenditure Achievement (%) -(Multi Village Scheme)' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl  where type='MVS' order by dcode";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==17){
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

<% }  else if(type!=null && type.equals("sch")){
  	
	
      
		//Initialize <graph> element
		strXML = "<graph caption='Schools Achievement (%) ' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl  where type='SCH' order by dcode";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==17){
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
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }  else if(type!=null && type.equals("ang")){
  	
	
      
		//Initialize <graph> element
		strXML = "<graph caption='Anganwadi Achievement (%) ' subCaption='Financial Year  "+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='District' yAxisName='Achievement' numberPrefix=''>";
		//Add all data
        

		try{
              String query="select *from rws_svs_graph_view_tbl  where type='ANG' order by dcode";
             // System.out.println("Query:"+query);
              Statement stmtgraph = conn.createStatement();
  			ResultSet rrs = stmtgraph.executeQuery(query);
  			int jj=0;
              while(rrs.next()){

           	   if(jj==17){
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
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }    %>