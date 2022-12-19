<%@ include file = "/reports/conn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String typeOfAsset=request.getParameter("typeOfAsset");
	PreparedStatement statement=null;
	Statement statement1=null;
	ResultSet resultSet=null;
	int count=0;
	try{
		String assetCode="";
		String habCode="";
		String schemCode="";
		ArrayList assetList=new  ArrayList();
		statement1=conn.createStatement();
		String query="select asset_code, hab_code from rws_asset_mast_tbl where  substr(hab_code,1,2)= ? and substr(hab_code,6,2)= ? and type_of_asset_code= ? and asset_code not in (select asset_code from rws_asset_scheme_tbl) order by hab_code";
		ps=conn.prepareStatement(query);
		ps.setString(1, district);
		ps.setString(2, mandal);
		ps.setString(3, typeOfAsset);
		rs=ps.executeQuery();
		while(rs.next()){
			count++;
			int maxcode=0;
			assetCode=rs.getString("asset_code");	
			habCode=rs.getString("hab_code");
			if(typeOfAsset.equals("01")){
				assetList.add(assetCode);
				String schemeQuery="select max(substr(scheme_code,17,3)) from rws_asset_scheme_tbl where substr(scheme_code,1,16)= ? and substr(scheme_code,17,1)='6'";
				statement=conn.prepareStatement(schemeQuery);
				statement.setString(1, habCode);
				resultSet=statement.executeQuery();
				if(resultSet.next()){
					maxcode=resultSet.getInt(1);
					if(maxcode!=0){
						maxcode=maxcode+1;
					} else{
						maxcode=600;
					}
				} else{
					maxcode=600;
				}
				statement.close();
				resultSet.close();
			} else if(typeOfAsset.equals("02")){
				assetList.add(assetCode);
				String schemeQuery="select max(substr(scheme_code,17,3)) from rws_asset_scheme_tbl where substr(scheme_code,1,16)= ? and substr(scheme_code,17,1)='4'";
				statement=conn.prepareStatement(schemeQuery);
				statement.setString(1, habCode);
				resultSet=statement.executeQuery();
				if(resultSet.next()){
					maxcode=resultSet.getInt(1);
					if(maxcode!=0){
						maxcode=maxcode+1;
					}else{
						maxcode=400;
					}
				}else{
					maxcode=400;
				}
				statement.close();
				resultSet.close();		
			} else if(typeOfAsset.equals("03")){
				assetList.add(assetCode);
				String schemeQuery="select max(substr(scheme_code,17,3)) from rws_asset_scheme_tbl where substr(scheme_code,1,16)= ? and substr(scheme_code,17,1)='8'";
				statement=conn.prepareStatement(schemeQuery);
				statement.setString(1, habCode);
				resultSet=statement.executeQuery();
				if(resultSet.next()){
					maxcode=resultSet.getInt(1);
					if(maxcode!=0){
						maxcode=maxcode+1;
					} else{
						maxcode=800;
					}
				}
				else{
					maxcode=800;
				}
				statement.close();
				resultSet.close();		
		 } else if(typeOfAsset.equals("09")){
				assetList.add(assetCode);
				String schemeQuery="select max(substr(scheme_code,17,3)) from rws_asset_scheme_tbl where substr(scheme_code,1,16)= ? and substr(scheme_code,17,2)='45'";
				statement=conn.prepareStatement(schemeQuery);
				statement.setString(1, habCode);
				resultSet=statement.executeQuery();
				if(resultSet.next()){
					maxcode=resultSet.getInt(1);
					if(maxcode!=0){
						maxcode=maxcode+1;
					} else{
						maxcode=451;
					}
				}else{
					maxcode=451;
				}
				statement.close();
				resultSet.close();
		
	}
	schemCode=habCode+maxcode;
	String Query="insert into rws_asset_scheme_tbl values('"+assetCode+"','"+schemCode+"')";	
	System.out.println(Query);
	statement1.addBatch(Query);	
}
if(count!=0){
	int i[]=statement1.executeBatch();
	if(i.length!=0){
		request.setAttribute("message", "Scheme Code Generated Sucessfully");
		session.setAttribute("assets", assetList);
%>
    	<jsp:forward page="rws_asset_schemecode_generation_list.jsp"/>
<% 	} else{
		request.setAttribute("message", "Failed to Generate Scheme Code");
%>
    	<jsp:forward page="rws_asset_scheme_code_integration_frm.jsp"/>
<% 	}
	}else{
		request.setAttribute("message", "No Data Found For Generating Scheme Code");
%>
   		<jsp:forward page="rws_asset_scheme_code_integration_frm.jsp"/>
<%		}
	} catch(Exception e){
		System.out.println("The Exception in rws_asset_schemecode_generation is  = "+e.getMessage());
	}
	finally{
		if(conn!=null){
			conn.close();
		}
	}
%>
</body>
</html>