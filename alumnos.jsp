<%@page import="com.anahuac.garibaldi.utils.LocalFunctions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%boolean child = false;%>
<%@include file="/fragments/validate.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="es-mx" xmlns="http://www.w3.org/1999/xhtml">
   <head>
       <title>Concurso academico | Maestros</title>
       <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <!-- <meta http-equiv="refresh" content="5">  -->
<link href="css/principal.css" rel="stylesheet" type="text/css" />
<script src="js/aks.main.js"></script>
<script src="js/aks.ajax.js"></script>
<script>
//local functions
var theForm		= null;
var theFilters	= null;
var page		= null;

//first function onLoad, modify as needed but do not delete the function
function onLoad()
{
	theForm		= document.frmMain;
	theFilters	= document.frmFilters;
	page	= '<%=LocalFunctions.getPageNoExt(request.getRequestURI())%>';
	
	browse();
	
	
}

//function to responde to the checkEnter global function
function validate()
{
	return false;
	//browse();
}
</script>
   </head>  
   <body onload="onLoad();">
    <!-- Barra superior -->
  	 <div style="position: absolute;width: 100%;height: 13.06%;background: #009945;mix-blend-mode: normal;">
   		<h1 style="position:absolute;height: 13.8%;left: 2.2%;bottom:90% ;font-family: Roboto Slab;font-style: normal;font-weight: normal;font-size: 80px;line-height: 106px;color: #FFFFFF;">Concurso Académico 2K19</h1>
   	</div>

    <!-- Barra inferior -->
   	<div style="position: absolute;width: 100%;height: 13.06%;bottom: 0%;background: #009945;mix-blend-mode: normal;">
      <h1 style="position:absolute;height: 13.8%;left: 50%;bottom: 70%;font-family: Roboto Slab;font-style: normal;font-weight: normal;font-size: 375%;color: #FFFFFF;">Ingenierías XXVIII</h1></div>

    <!-- Texto maestros -->
    <h1 style="position:absolute;width: 1004px;height: 106px;left: 558px;top: 80px;font-family: Roboto Slab;font-style: normal;font-weight: normal;font-size: 60px;line-height: 106px;">Alumnos</h1>

    <!-- Workarea -->
    <div class="container">
	    <div class="main-content">
	      <form action="" method="post" name="frmFilters" id="frmFilters" onkeydown="checkEnter();">
	      </form>
	      <form action="" method="post" name="frmMain" id="frmMain" onkeydown="checkEnter();">
	        <div id="workarea"></div>
	      </form>
	    </div>
	</div>
    
    <!-- Input y Button -->
    <div>
	    <form action = "UpRespAl.jsp" method = "post">
	    	<!-- Cuadro respuesta --> 
	    	<input type="Texto" id="inp" name = "inp" style="position: absolute;width: 100px;height: 100px;left: 545px;top: 380px;background: #E0E0E0;border: 3px solid #009945;box-sizing: border-box;" placeholder="Respuesta"></input> 
	    	<!-- Boton de enviar -->  
	    	<button onClick=alert(Tu respuesta esta siendo revisada) type="submit" style="position: absolute;width: 100px;height: 100px;left: 675px;top: 380px ;" class="btn btn-outline-success"> Enviar respuesta</button>
		</form>
	</div>

    <!-- Buenos cristianos -->
    <img src="cruz.png" alt="cruz" style="position: absolute;width:18%;height:46%;left:5%;top:26%;opacity: 0.6;">
    
    <!-- Honrados ciudadanos -->
    <img src="bchc.png" alt="bchc" style="position: absolute;width:23%;height:50%;left:72.5%;top:24.32%;opacity: 0.6;">
    

   </body>

   
</html>