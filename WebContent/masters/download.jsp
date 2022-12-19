<%  
  String filename = request.getParameter("filename");

  //String filepath = "e:\\"; 
  response.setContentType("APPLICATION/OCTET-STREAM"); 
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\""); 
try{
	java.io.File f=new java.io.File(filename);
	System.out.println("File Name:"+f.getName());
  java.io.FileInputStream fileInputStream = new java.io.FileInputStream(f);
		  
  int i; 
  while ((i=fileInputStream.read()) != -1) {
    out.write(i); 
  } 
  fileInputStream.close(); 
}catch(Exception e){
e.printStackTrace();
}
%> 