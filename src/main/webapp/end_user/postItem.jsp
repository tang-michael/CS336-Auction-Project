<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="persistence.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="../css/core.css" rel="stylesheet" />
        <title>Post Item</title>
    </head>
    <script type="text/javascript">
    
    function selectCharacteristics(){
    	if(document.getElementById('computerAccessories').checked){
    		
    		document.getElementById('comp_acc_connectivity').style.display = 'block';
    		document.getElementById('comp_acc_color').style.display = 'block';
    		document.getElementById('comp_acc_battery').style.display = 'block';
    		
    		document.getElementById('comp_size').style.display = 'none';
    		document.getElementById('comp_proc').style.display = 'none';
    		document.getElementById('comp_ram').style.display = 'none';
    		
    		document.getElementById('phone_connectivity').style.display = 'none';
    		document.getElementById('phone_storage').style.display = 'none';
    		document.getElementById('phone_camera').style.display = 'none';
    		
    		document.getElementById('camera_pixel').style.display = 'none';
    		document.getElementById('camera_zoom').style.display = 'none';
    		document.getElementById('camera_lenses').style.display = 'none';
    		
    	}
    	else if(document.getElementById('computers').checked){
    		
    		document.getElementById('comp_acc_connectivity').style.display = 'none';
            document.getElementById('comp_acc_color').style.display = 'none';
            document.getElementById('comp_acc_battery').style.display = 'none';
            
            document.getElementById('comp_size').style.display = 'block';
            document.getElementById('comp_proc').style.display = 'block';
            document.getElementById('comp_ram').style.display = 'block';
            
            document.getElementById('phone_connectivity').style.display = 'none';
            document.getElementById('phone_storage').style.display = 'none';
            document.getElementById('phone_camera').style.display = 'none';
            
            document.getElementById('camera_pixel').style.display = 'none';
            document.getElementById('camera_zoom').style.display = 'none';
            document.getElementById('camera_lenses').style.display = 'none';
    		
    	}
    	else if(document.getElementById('phones').checked){
    		
    		document.getElementById('comp_acc_connectivity').style.display = 'none';
            document.getElementById('comp_acc_color').style.display = 'none';
            document.getElementById('comp_acc_battery').style.display = 'none';
            
            document.getElementById('comp_size').style.display = 'none';
            document.getElementById('comp_proc').style.display = 'none';
            document.getElementById('comp_ram').style.display = 'none';
            
            document.getElementById('phone_connectivity').style.display = 'block';
            document.getElementById('phone_storage').style.display = 'block';
            document.getElementById('phone_camera').style.display = 'block';
            
            document.getElementById('camera_pixel').style.display = 'none';
            document.getElementById('camera_zoom').style.display = 'none';
            document.getElementById('camera_lenses').style.display = 'none';
    		
    	}
    	else{
    		
    		document.getElementById('comp_acc_connectivity').style.display = 'none';
            document.getElementById('comp_acc_color').style.display = 'none';
            document.getElementById('comp_acc_battery').style.display = 'none';
            
            document.getElementById('comp_size').style.display = 'none';
            document.getElementById('comp_proc').style.display= 'none';
            document.getElementById('comp_ram').style.display = 'none';
            
            document.getElementById('phone_connectivity').style.display = 'none';
            document.getElementById('phone_storage').style.display = 'none';
            document.getElementById('phone_camera').style.display = 'none';
            
            document.getElementById('camera_pixel').style.display = 'block';
            document.getElementById('camera_zoom').style.display = 'block';
            document.getElementById('camera_lenses').style.display = 'block';
    		
    	}
    }
    
    </script>
    <body>
        
        <form action="setItem.jsp" method="post">
            <input type="radio" onclick="javascript:selectCharacteristics();" id="computerAccessories" name="type" value = "Computer Accessories">
            <label for="computerAccessories">Computer Accessories</label>
            <br>
            <input type="radio" onclick="javascript:selectCharacteristics();" id="computers" name="type" value = "Computers">
            <label for="computers">Computers</label>
            <br>
            <input type="radio" onclick="javascript:selectCharacteristics();" id="phones" name="type" value = "Phones">
            <label for="phones">Phones</label>
            <br>
            <input type="radio" onclick="javascript:selectCharacteristics();" id="cameras" name="type" value = "Cameras">
            <label for="cameras">Cameras</label>
            <br>
            <input type ="hidden" id="login_id" name="login_id" value=<%=(String)session.getAttribute("user")%>>
            
            Brand Name:<input type="text" name="brandName" />
            <br>
            Initial Price:<input type="text" name="initPrice" />
            <br>
            Item Name :<input type="text" name="itemName" />
            <br>
            <div id="comp_acc_connectivity" style="display:none"> Connectivity :<input type="text" id="compAccConnec" name="compAccConnec"></div>
            <br>
            <div id="comp_acc_color" style="display:none"> Color :<input type="text" id="compAccCol" name="compAccCol"></div>
            <br>
            <div id="comp_acc_battery" style="display:none"> Batteries :<input type="text" id="compAccBat" name="compAccBat"></div>
            <br>
            <div id="comp_size" style="display:none"> Screen Size :<input type="text" id="compScreenSize" name="compScreenSize"></div>
            <br>
            <div id="comp_proc" style="display:none"> Processor :<input type="text" id="compProc" name="compProc"></div>
            <br>
            <div id="comp_ram" style="display:none"> RAM :<input type="text" id="compRam" name="compRam"></div>
            <br>
            <div id="phone_connectivity" style="display:none"> Wireless Connectivity :<input type="text" id="phoneConnec" name="phoneConnec"></div>
            <br>
            <div id="phone_storage" style="display:none"> Storage :<input type="text" id="phoneStorage" name="phoneStorage"></div>
            <br>
            <div id="phone_camera" style="display:none"> Camera Features :<input type="text" id="phoneCamera" name="phoneCamera"></div>
            <br>
            <div id="camera_pixel" style="display:none"> MegaPixels :<input type="text" id="cameraPixel" name="cameraPixel"></div>
            <br>
            <div id="camera_zoom" style="display:none"> Zoom :<input type="text" id="cameraZomm" name="cameraZoom"></div>
            <br>
            <div id="camera_lenses" style="display:none"> Lenses :<input type="text" id="cameraLenses" name="cameraLenses"></div>
            <br>
            Bid Increment :<input type="text" name="bidIncrement" />
            <br>
            Minimum Price (Optional) :<input type="text" name="minPrice" />
            <br>
            <%
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            
            out.println("Please enter a date and time after: " + currentTime.toString() + "<br>");
            %>
            Closing Date (Please enter date in yyyy-mm-dd format) :<input type="text" name="closing_date" />
            <br>
            Closing Time (Please enter time in 24hr format in hh:mm:ss) :<input type="text" name="closing_time" />
            <br>
            <input type ="submit" value = "Submit" /> 
        </form>
        
    </body>
</html>