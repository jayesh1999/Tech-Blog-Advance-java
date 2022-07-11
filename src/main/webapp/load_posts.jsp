<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.connectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
					LikeDao ld = new LikeDao(connectionProvider.getConnection());
	
					
					%>
					<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>
    <div class="row">
    <%
    Thread.sleep(500);
    PostDao d = new PostDao(connectionProvider.getConnection());
    
    int cid= Integer.parseInt(request.getParameter("cid"));
    List<Posts> posts = null;
    if(cid == 0){
    	posts = d.getAllPosts();
    }
    else{
    	posts = d.getPostByCatId(cid);
    }
    if(posts.size() == 0){
    	out.println("<h2 class=display-3 text-center>No Post int this category....</h2>");
    	return;
    }
    for(Posts p:posts){
    	%>
    <div class="col-md-6 mt-2">
    <div class="card">
    <img class="card-img-top img-fluid" style="height:200px" src="./blog_pics/<%= p.getpPic() %>" alt="Card image cap">
    <div class="card-body">
    <b><%= p.getpTitle() %></b>
    <p><%= p.getpContent()%></p>
   
    </div>
    <div class="card-footer bg-primary text-center">
    <a href="#!" onclick ="doLike(<%= p.getPid()%>,<%= user.getId() %>)"  class=" btn btn-outline-light btn-sm"><l class="fa fa-thumbs-up"></l><span class="like-counter"><%=ld.countLikeOnPost(p.getPid()) %></span></a>
    <a href="show_blog_page.jsp?post_id=<%=p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>   
    <a href="#!" class="btn btn-outline-light btn-sm"><l class="fa fa-commenting-o"></l><span></span>20</a>

    </div>
    </div>
    </div>	
  
    <% }
    %>
</div>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<script src="js/myjs.js"></script>

</body>
</html>