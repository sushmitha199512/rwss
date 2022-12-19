<%@ include file="/reports/conn.jsp" %>
<html>
<body >
<%! String[] habs; %>
<center>You have selected: 
<% 
String sourceCode=(String)session.getAttribute("sourceCode");

String type=request.getParameter("type");
String table=""; 
    
               table ="RWS_SOURCE_HABITATION_TBL";

int count=0;

 
  habs = request.getParameterValues("selectedHabCode");
 
   try{
          conn.setAutoCommit(false);
         stmt=conn.createStatement();
   habs = request.getParameterValues("selectedRevHabCode");
   if (habs != null) 
   {
  stmt.addBatch("delete from "+table+" where source_code='"+sourceCode+"'");
     for (int i = 0; i < habs.length; i++) 
      {
         String q1="insert into "+table+" (source_code,HAB_CODE) values('"+sourceCode+"','"+habs[i]+"')";
        System.out.println("q1"+q1);
       count++;
		 stmt.addBatch(q1);
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