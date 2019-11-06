<%@page import="java.sql.*"%>
<%
final boolean DEBUG = false;
	//String db 	= request.getParameter("db");
	String db 		= "concurso";
	String user 	= "USER";
	String passwd	= "CAUser";
	
	Connection conn = null;
	Statement stmt	= null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	Statement stmt4 = null;
	ResultSet rs	= null;
	ResultSet rsfil = null;
	ResultSet rscol = null;
	ResultSet rscal = null;
	
	
	String sql 		= null;
	String qst 		= null;
	Integer idre 	= null;
	
	HttpSession sesion = request.getSession();
	Integer id	= (Integer)sesion.getAttribute("idr");
	Integer t = (Integer)sesion.getAttribute("tr");
	
	if (DEBUG) System.out.println("id [" + id + "]");
	if (DEBUG) System.out.println("t [" + t + "]");
	
	try
	{
		Class.forName("org.gjt.mm.mysql.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, passwd);
		
		stmt  = conn.createStatement();
		stmt2 = conn.createStatement();
		stmt3 = conn.createStatement();
		stmt4 = conn.createStatement();
		
		sql = "SELECT p.pregunta, pr.respuesta_id FROM preguntas p, preg_respon pr WHERE pr.user_id = '"+ id.toString() +"' AND pr.resp_al IS NULL AND pr.pregunta_id = p.pregunta_id";
		
		if (DEBUG) System.out.println("sql [" + sql + "]");
		
		rs = stmt.executeQuery(sql);
		
		if (DEBUG) System.out.println("rs [" + rs.next() + "]");
		
		if (rs.next())
		{
			qst = rs.getString("pregunta");
			idre = rs.getInt("respuesta_id");
			sesion.setAttribute("idre", idre);
			out.println("<!-- Cuadro de pregunta --> <div type=\"Texto\" style=\"position: absolute;width: 600px;height: 150px;left: 375px;top: 200px;background: #E0E0E0;border: 3px solid #009945;box-sizing: border-box;\">" + qst + " </div>");

		}
		else
		{
			String i = null;
			String us = null;
			Integer cal = null;
			Integer cont = null;
			Integer num = null;
			
			String sqlus = "SELECT * FROM usuarios u, user_round ru, ronda r WHERE u.user_id = ru.user_id AND ru.ronda_id = r.ronda_id AND u.tipo_id = '" + t + "' AND r.activa = 1 ORDER BY u.username";
			
			rsfil = stmt2.executeQuery(sqlus);
			
			if (DEBUG) System.out.println("sqlus [" + sqlus + "]");
			
			String sqlpr = "SELECT u.user_id, COUNT(*) num_preguntas FROM preg_respon pr, preguntas p, usuarios u, ronda r WHERE pr.pregunta_id = p.pregunta_id AND pr.user_id = u.user_id AND u.tipo_id = '" + t + "' AND p.ronda = r.round AND r.activa = 1 GROUP BY u.user_id ORDER BY num_preguntas DESC LIMIT 1";
			
			if (DEBUG) System.out.println("sqlpr [" + sqlpr + "]");
			
			rscol = stmt3.executeQuery(sqlpr);
			
			if(rscol.next())
				num = rscol.getInt("num_preguntas");
			
			out.println("<br><br><br><br><br><br><br><br>");
			//out.println("<table class = \"centered\" style = \"width: 100%; height: 100%\"><tr style = \"height: 15%\"><td style = \"width:25%\"></td><td style = \"width: 50%\"></td><td style = \"width:25%\"></td></tr><tr style = \"height: 70%\"><td style = \"width:25%\"></td><td style = \"width: 50%\">");
			out.println("<div position=\"absolute\" valign=\"middle\" style=\"top: 20%\">");
			
			out.println("	<table class=\"table table-striped table-sm\" position=\"relative\" style=\"top: 0;bottom: 0;left: 0;right: 0;width: 50%;height: 30%;margin: auto\">");
			out.println("		<thead class=\"thead-light\">");
			out.println("			<tr>");
			
			if (t == 1)
			{
				out.println("    		<th scope=\"col\">Equipos</th>");
			}
			else if (t == 2)
			{
				out.println("	    	<th scope=\"col\">Grupos</th>");
			}
			
			cont = 1;
			while(cont<num+1){
				out.println("<th scope=\"col\">P" + cont + "</th>");
				cont++;
			}
			
			out.println("			</tr>");
			out.println("		</thead>");
			
			if (DEBUG) System.out.println("rsfil [" + rsfil.next() + "]");
			
			while(rsfil.next()) // Pinta las Filas
			{
				us = rsfil.getString("username");
				i = rsfil.getString("user_id");
				out.println("		<tr>");
				out.println("			<th scope=\"row\">" + us + "</th>");
				
				if (DEBUG) System.out.println("us [" + us + "]");
				if (DEBUG) System.out.println("i [" + i + "]");
				
				if(DEBUG) System.out.println("num [" + num + "]");
				
				cont = 1;
				
				while (num+1 > cont) // Pinta las columnas
				{
					
					out.println("			<td>");
					
					String sqlcal = "SELECT pr.calificacion, IF(pr.calificacion IS NOT NULL, 1, 0) ya_calificado FROM preg_respon pr, preguntas p, ronda r WHERE pr.pregunta_id = p.pregunta_id AND pr.user_id = '" + i + "' AND p.ronda = r.round AND r.activa = 1 ORDER BY pr.hora_entrada LIMIT " + cont;
					
					rscal = stmt4.executeQuery(sqlcal);
					
					while(rscal.next()) //Asigna Calificacion
					{
						cal = rscal.getInt("calificacion");
					}
					
					if(DEBUG) System.out.println("cal [" + cal + "]");
					
					{ //Imprime Calificacion

						if(cal == 0)
						{
							out.println("				<div> <img src = \"amarillo.png\" style=\"position: absolute;width: 2%;height: 3.5%;\"> </div>");
						}
						else if (cal == 1)
						{
							out.println("				<div> <img src = \"verde.png\" style=\"position: absolute;width: 2%;height: 3.5%;\"> </div>");
						}
						else if (cal == 2)
						{
							out.println("				<div> <img src = \"rojo.png\" style=\"position: absolute;width: 2%;height: 3.5%;\"> </div>");
						}
					}
					
					out.println("			</td>");
					rscal.close();
					
					cont++;
				}
				
				out.println("		</tr>");
				rscol.close();
			}
			out.println("	</table>");
			//out.println("</td><td style = \"width:25%\"></td></tr><tr style = \"height: 15%\"><td style = \"width:25%\"></td><td style = \"width: 50%\"></td><td style = \"width:25%\"></td></tr></table>");
			out.println("</div>");
			rsfil.close();
		}
			
		rs.close();
		
	}
	catch(SQLException e)
	{
		out.println("SQLException caught: " + e.getMessage());
	}
	finally
	{
		try{rscal.close();} catch(Exception e){}
		try{rscol.close();} catch(Exception e){}
		try{rsfil.close();} catch(Exception e){}
		try{rs.close();} catch(Exception e){}
		try{stmt.close();} catch(Exception e){}
		try{stmt2.close();} catch(Exception e){}
		try{stmt3.close();} catch(Exception e){}
		try{stmt4.close();} catch(Exception e){}
		try{conn.close();} catch(Exception e){}
	}
%>