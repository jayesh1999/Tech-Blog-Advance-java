package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.connectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/LikeServlet")
@MultipartConfig
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out = response.getWriter();
		
String operation = request.getParameter("operation");
int uid =Integer.parseInt(request.getParameter("uid"));
int pid =Integer.parseInt(request.getParameter("pid"));

//out.println("data from server");
//out.println(operation);
//out.println(uid);
//out.println(pid);

LikeDao ldao = new LikeDao(connectionProvider.getConnection());
if(operation.equals("like")) {
	
		boolean f =ldao.insertLike(pid, uid);
		out.print(f);
	
	
	
}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		
String operation = request.getParameter("operation");
int uid =Integer.parseInt(request.getParameter("uid"));
int pid =Integer.parseInt(request.getParameter("pid"));

out.println("data from server");
out.println(operation);
out.println(uid);
out.println(pid);
	}

}