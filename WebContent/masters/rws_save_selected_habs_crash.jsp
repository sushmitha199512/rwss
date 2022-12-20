<%@ include file="/reports/conn.jsp" %>
<html>
<body >
<%! String[] habs; %>
<center>You have selected: 
<% 
String sourcecode=(String)session.getAttribute("sourcecode");
System.out.println("sourcecode"+sourcecode);
String table=""; 
if(sourcecode.substring(19,21).equals("SO"))
{
	
table="rws_source_habitation_tbl";

}  
if(sourcecode.substring(19,21).equals("OS") && sourcecode.substring(19,21).equals("GL") )
{
	table="RWS_OHGLCI_HAB_LINK_TBL";
}
  

int count=0;
String q1="";

 
  habs = request.getParameterValues("selectedHabCode");
 
   try{
          conn.setAutoCommit(false);
         stmt=conn.createStatement();
   habs = request.getParameterValues("selectedRevHabCode");
   if (habs != null) 
   {
	   if(sourcecode.substring(19,21).equals("SO"))
	  	 {
		   
	  stmt.addBatch("delete from "+table+" where source_code='"+sourcecode+"'");
	  	 }
		   else if(sourcecode.substring(19,21).equals("OS") || sourcecode.substring(19,21).equals("GL"))
		   {
			   stmt.addBatch("delete from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+sourcecode+"'");
		   }
	   
		   else if(sourcecode.substring(19,21).equals("GL"))
		   {
			   stmt.addBatch("delete from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+sourcecode+"'");
		   }
	   
     for (int i = 0; i < habs.length; i++) 
      {
    	 if(sourcecode.substring(19,21).equals("SO"))
    	 {
        q1="insert into "+table+" (source_code,HAB_CODE) values('"+sourcecode+"','"+habs[i]+"')";
    	 }
    	 else if(sourcecode.substring(19,21).equals("OS"))
    	 {
    		  q1="insert into RWS_OHGLCI_HAB_LINK_TBL(SUBCOMP_CODE,HAB_CODE) values('"+sourcecode+"','"+habs[i]+"')";
    	 }
    	 else if( sourcecode.substring(19,21).equals("GL"))
    	 {
    		 q1="insert into RWS_OHGLCI_HAB_LINK_TBL(SUBCOMP_CODE,HAB_CODE) values('"+sourcecode+"','"+habs[i]+"')"; 
    	 }
    	
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