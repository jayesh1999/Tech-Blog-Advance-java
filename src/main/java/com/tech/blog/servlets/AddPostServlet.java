package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Posts;
import com.tech.blog.entities.User;
import com.tech.blog.helper.Helper;
import com.tech.blog.helper.connectionProvider;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   PrintWriter out = response.getWriter();
	   
	   int cid = Integer.parseInt(request.getParameter("cid"));
	   String pTitle = request.getParameter("pTitle");
	   String pContent =request.getParameter("pContent");
	   String pCode = request.getParameter("pCode");
	   Part part  = request.getPart("pic");
	   String fileName = part.getSubmittedFileName();
	   
	   //getting current user name
	   HttpSession session = request.getSession();
	   User user =(User)session.getAttribute("currentUser");
	   
	   out.println("your post title is"+ pTitle);
	   
	   Posts p = new Posts(pTitle,pContent,pCode,fileName,null,cid,user.getId());
	   PostDao postDao = new PostDao(connectionProvider.getConnection());
	   if(postDao.savePost(p)) {
			String path =request.getRealPath("")+"blog_pics" +File.separator+fileName;
			
			Helper.saveFile(part.getInputStream(), path);
			   out.println("done");

	   }
	   else {
		   out.println("error");

	   }
	}

}
