package nic.watersoft.commons;

public class SQLInjectionBlackList {
	public boolean isSecuritySensitive(String parameter) {
        boolean result = true;
        parameter = parameter.toLowerCase();

        try {
            if (parameter != null && parameter.trim().length() > 0) {
//
//                String[] blackList = {"--", ";--", ";", "/*", "*/", "@@", "??", "+", "||", "<", ">", "%","='",
//                    "<script", ".js", "xp_", "dbshut", "http", "</script>", "javascript:", "<style", "</style>",
//                    "alert(", "<a href=", "<img src=", "<frame", "<iframe", "style=", ".html", "|", "char", "nchar", "varchar", "nvarchar", "alter",
//                    "begin", "cast", "create", "cursor", "declare", "delete",
//                    "drop", "end", "exec", "execute", "fetch", "insert",
//                    "kill", "open", "select", "sys", "sysobjects", "syscolumns",
//                     "update","window"};
                
                                //String[] blackList =  { ";--", ";", "/*", "*/",  "??", "||", "<", ">"};//{"--", ";--", ";", "/*", "*/", "@@", "??", "||", "<", ">",
                    /*"<script", ".js", "xp_", "dbshut", "http", "</script>", "javascript:", "<style", "</style>",
                    "alert(", "<a href=", "<frame", "<iframe", "style=", ".html", "|", "alter",
                    "begin", "create", "cursor", "declare", "delete",
                    "drop", "fetch", "insert",
                    "kill",  "select", "update"};*/
            	
            	
            	String[] blackList =  {";--", ";", "/*", "*/",  "??", "||", "<", ">","--", ";--", ";", "/*", "*/", 
            			"??", "||", "<script", ".js", "xp_", "dbshut", "http", "</script>", "javascript:", "<style", "</style>",
                "alert(", "<a href=", "<frame", "<iframe", "style=", ".html", "|", "alter", "begin", "create",
                "cursor", "declare", "drop", "fetch",  "kill","select"};
            	//String[] blackList =  {";--", ";", "/*", "*/",  "??", "||","--", ";--", ";", "/*", "*/", "create"};
            	String[] blackList1 =  {".do", ".jsp"};
                parameter = parameter.toLowerCase(); //convert the input to lowercase
               // System.out.println("p--qqq---"+parameter);
                for (int i = 0; i < blackList.length ; i++) {
                    if (parameter.indexOf(blackList[i]) >= 0) { //this condition needs to be checked
                    	//System.out.println("parameter-----"+parameter);
                    	/*System.out.println("parameter.indexOf-----"+parameter.indexOf(blackList[i]));
                    	System.out.println("p-----"+blackList[i]);*/
                    	//System.out.println("p---tttttttt--"+false);
                        result = false;
                    }
                    /*else
                    {
                    	System.out.println("*******************************");
                    	System.out.println("else parameter1-----"+parameter);
                    }*/
                }
                
                	for (int ii = 0; ii < blackList1.length ; ii++) {  
                    if (parameter.indexOf(blackList1[ii]) >= 0) { //this condition needs to be checked
                    	//System.out.println("parameter-----"+parameter);
                    	/*System.out.println("parameter.indexOf-----"+parameter.indexOf(blackList1[ii]));
                    	System.out.println("p-----"+blackList1[ii]);*/
                    	//System.out.println("p---tttttttt--"+true);
                        result = true;
                    }
                    /*else
                    {
                    	System.out.println("*******************************");
                    	System.out.println("else parameter2-----"+parameter);
                    }*/
                }
            }
        } catch (Exception e) {
        	e.printStackTrace();
            return false;
        }
        //System.out.println("result final==="+result);
        return result;
    }
}
