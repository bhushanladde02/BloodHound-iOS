package com.smallemperor.base;
// Import required java libraries
import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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

    public void doPost(HttpServletRequest request, 
               HttpServletResponse response)
              throws ServletException, java.io.IOException {
	   
	   init(); //just to set filePath
	  
	    String beaconID= (String) request.getAttribute("deviceID");
	    String fname= (String) request.getAttribute("firstname");
	    String lname= (String) request.getAttribute("lastname");
	    String age= (String) request.getAttribute("age");
	    String height= (String) request.getAttribute("height");
	    String weight= (String) request.getAttribute("weight");
	    String hcolor= (String) request.getAttribute("hcolor");
	    String ecolor= (String) request.getAttribute("ecolor");
	    String feature= (String) request.getAttribute("feature");
	    String street= (String) request.getAttribute("street");
	    String zip= (String) request.getAttribute("zip");
	    String special= (String) request.getAttribute("special");
	    String action= (String) request.getAttribute("action");
	    String adID = (String)request.getAttribute("uniqueID");
	   
	    beaconID = beaconID==null?"":beaconID;
	    fname = fname==null?"":fname;
	    lname = lname==null?"":lname;
	    age = age==null?"":age;
	    height = height==null?"":height;
	    weight = weight==null?"":weight;
	    hcolor = hcolor==null?"":hcolor;
	    ecolor = ecolor==null?"":ecolor;
	    feature = feature==null?"":feature;
	    street = street==null?"":street;
	    zip = zip==null?"":zip;
	    special= special==null?"":special;
	    action= action==null?"":action;
	    
	   
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
	   
	  
	   //insert to lost db
	   LostDAO lostDAO = new LostDAO();
	   lostDAO.insertToDB(lost);	   
	   
	   
	   
	   
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

      try{ 
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
   }catch(Exception ex) {
       System.out.println(ex);
   }
   }
   public void doGet(HttpServletRequest request, 
                       HttpServletResponse response)
        throws ServletException, java.io.IOException {
        
        throw new ServletException("GET method used with " +
                getClass( ).getName( )+": POST method required.");
   } 
}