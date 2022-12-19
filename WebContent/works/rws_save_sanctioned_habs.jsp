<%@ include file="/reports/conn.jsp" %>
<html>
<body >
<%! String[] habs; %>
<center>You have selected: 
<% 

String type=request.getParameter("type");
String table=""; 
    if( type!=null && type.equals("admin")){
               table ="rws_admn_hab_lnk_tbl";
}else if( type!=null && type.equals("tech")){
              table ="RWS_EST_NEW_HAB_LNK_TBL";
}else if(type!=null && type.equals("comp")){
table="RWS_WORK_COMP_HAB_LNK_TBL";
}
int count=0;
 String workId=request.getParameter("workId");
  habs = request.getParameterValues("selectedHabCode");
   try{
          conn.setAutoCommit(false);
         stmt=conn.createStatement();
   habs = request.getParameterValues("selectedRevHabCode");
   if (habs != null) 
   {
  stmt.addBatch("delete from "+table+" where work_id='"+workId+"'");
     for (int i = 0; i < habs.length; i++) 
      {
         String q1="insert into "+table+" (WORK_ID,HAB_CODE) values('"+workId+"','"+habs[i]+"')";
	       count++;
		 stmt.addBatch(q1);
     }

if( type!=null && type.equals("admin")){
     String updateQ="update rws_work_admn_tbl set no_of_habs='"+count+"' where work_id='"+workId+"'";
 stmt.addBatch(updateQ);
            }
    }

boolean flag=true;
int res[]=stmt.executeBatch();
int i=0;
        while(i<res.length){  
            if(res[i]<0){
               flag=false;
				}
i++;
     }
        if(!flag){
          conn.rollback();
          conn.setAutoCommit(true);
       } else {
 conn.setAutoCommit(true);
		conn.commit();
        
}
     	}catch(Exception e){
			e.printStackTrace();
		}finally{
     try{
conn.setAutoCommit(true);
		conn.commit();
}catch(Exception e){
e.printStackTrace();
       }
}
   
    
%>
<script>
alert("Saved Successfully");
 window.close();
</script>
</center>
</body>
</html>