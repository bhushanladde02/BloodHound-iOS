package com.smallemperor.base;
// Import required java libraries
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.smallemperor.db.Lost;
import com.smallemperor.db.LostDAO;

public class UploadServlet extends HttpServlet {
   
   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
private boolean isMultipart;
   private String filePath;
   private int maxFileSize = 500 * 1024;
   private int maxMemSize = 100 * 1024;
   private File file ;

   @Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
	}

    public void doPost(HttpServletRequest request, 
               HttpServletResponse response)
              throws ServletException, java.io.IOException {
	   
	  // init(); //just to set filePath
	   
    	try{
    	
	 
	  String jsonString = request.getHeader("jsonString"); //not sure - this shouldn't be passed in header 
	   
    //String jsonString = getBody(request);
    	
	   System.out.println(jsonString);
	   
	   JsonElement jelement = new JsonParser().parse(jsonString);
	   JsonObject  jobject = jelement.getAsJsonObject();
	   
	  // request.get
	  
	    String beaconID= jobject.get("deviceID").toString();
	    String fname= jobject.get("firstname").toString();
	    String lname= jobject.get("lastname").toString();
	    String imgURL = jobject.get("imgURL").toString();
	    String age= jobject.get("age").toString();
	    String height= jobject.get("height").toString();
	    String weight= jobject.get("weight").toString();
	    String hcolor= jobject.get("hcolor").toString();
	    String ecolor= jobject.get("ecolor").toString();
	    String feature= jobject.get("feature").toString();
	    String street= jobject.get("street").toString();
	    String zip= jobject.get("zip").toString();
	    String special= jobject.get("special").toString();
	    String action= jobject.get("action").toString();
	    String adID = jobject.get("uniqueID").toString();
	    
	   
	   Lost lost = new Lost();
	   lost.setBeaconId(beaconID);
	   lost.setFirstname(fname);
	   lost.setLastname(lname);
	   lost.setCol0(age);
	   lost.setCol1(height);
	   lost.setCol2(weight);
	   lost.setHaircolor(hcolor);
	   lost.setEyecolor(ecolor);
	   lost.setCol3(feature);
	   lost.setAddress(street);
	   lost.setCol4(zip);
	   lost.setCol5(special);
	   lost.setCol6(action);
	   lost.setCol7("false"); //isReported field - Col7 - set to false
	   lost.setCol8(adID);  //unique deviceID
	   lost.setCol9(imgURL);
	   
	 
	   new LostDAO().insertToDB(lost);	   
	   
	   
	   
	   
	   /*
	    *  [_params setObject:beaconID  forKey:@"deviceID"];
    [_params setObject:fname  forKey:@"firstname"];
    [_params setObject:lname  forKey:@"lastname"];
    [_params setObject:age  forKey:@"age"];
    [_params setObject:height  forKey:@"height"];
    [_params setObject:weight  forKey:@"weight"];
    [_params setObject:hcolor  forKey:@"hcolor"];
    [_params setObject:ecolor  forKey:@"ecolor"];
    [_params setObject:feature  forKey:@"feature"];
    [_params setObject:street  forKey:@"street"];
    [_params setObject:zip  forKey:@"zip"];
    [_params setObject:special  forKey:@"special"];
    [_params setObject:action  forKey:@"action"];
    [_params setObject:adID  forKey:@"uniqueID"]; //unique ID for device
	    */
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   filePath =  "/var/lib/tomcat7/webapps/ROOT/images/";
	   
	   
      // Check that we have a file upload request
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
      java.io.PrintWriter out = response.getWriter( );
      if( !isMultipart ){
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      //factory.setRepository(new File("/root/bloodhound"));
      
      factory.setRepository(new File("/var/lib/tomcat7/webapps/ROOT/images/"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );

      // Parse the request to get file items.
      List fileItems = upload.parseRequest(request);
	
      // Process the uploaded file items	
      Iterator i = fileItems.iterator();

      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      while ( i.hasNext () ) 
      {
         FileItem fi = (FileItem)i.next();
         if ( !fi.isFormField () )	
         {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            String contentType = fi.getContentType();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
               file = new File( filePath + 
               fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
               file = new File( filePath + 
               fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
            out.println(file.getAbsolutePath());
            out.println("Uploaded Filename: " + fileName + "<br>");
         }
      }
      out.println("Success Inserting to Database");
      out.println("</body>");
      out.println("</html>");
      
    	}catch (Exception e) {
    					response.getWriter().print("Something went wrong, Please come back letter");
    					e.printStackTrace();
		}
   
   }
   
    
    public static String getBody(HttpServletRequest request) throws IOException {

        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        
        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }
    
    
   public void doGet(HttpServletRequest request, 
                       HttpServletResponse response)
    {

   } 
}