package com.selfedu;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.Document;

public class HelloServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public HelloServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.execute(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.execute(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	private void execute (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String requestURL = request.getRequestURI();
		String method = request.getMethod();
		String param = request.getParameter("param");
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println(" <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println(" <BODY>");
		out.println("Use " + method + "to visit this page, parameter: " + param + ", url: "+ requestURL + "</br>");
		out.println("  <form action='" + requestURL + "' method = 'get'> <input type = 'text' name = 'param' value = 'param string'><input type = 'submit' value = '以get方式查询页面" + requestURL + "'></form>");
		out.println("  <form action = '" + requestURL + "' method = 'post'> <input type = 'text' name = 'param' value = 'param string'> <input type = 'submit' value = '以post方式查询页面" + requestURL + "'></form>");
		
		out.println("  <script>document.write('last updated:' + document.lastModified);</script>");
		
		out.println(" </BODY>");
		out.println("</HTML>");
		
		out.flush();
		out.close();
	}

}
