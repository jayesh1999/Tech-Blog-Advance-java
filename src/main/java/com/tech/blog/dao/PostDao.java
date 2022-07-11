package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Posts;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<Category>();

		try {
			String q = "select * from categories";
			Statement st = this.con.createStatement();
			ResultSet set = st.executeQuery(q);
			while (set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cid, name, description);
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean savePost(Posts p) {
		boolean f = false;

		try {

			String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(q);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getcatId());
			pstmt.setInt(6, p.getUserId());

			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return f;

	}


public List<Posts> getAllPosts(){
	
	List<Posts> list = new ArrayList<>();
	
	//fetch all the post
	try {
		
		PreparedStatement p =  con.prepareStatement("select * from posts");
		ResultSet set = p.executeQuery();
		
		while(set.next()) {
			int pid = set.getInt("pid");
			String pTitle  =set.getString("pTitle");
			String pContent=set.getString("pContent");
			String pPic  =set.getString("pPic");
			String pCode  =set.getString("pCode");
			Timestamp date = set.getTimestamp("pDate");
			int catId  = set.getInt("catId");
			int userId = set.getInt("userId");
			Posts posts = new Posts(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
			
			list.add(posts);
			
		}
		
		
	} catch (Exception e) {
	e.printStackTrace();
		// TODO: handle exception
	}
	
	
	return list;
}

public List<Posts> getPostByCatId(int catId){
	
	List<Posts> list = new ArrayList<>();
	//fetch all post by id
	
try {
		
		PreparedStatement p =  con.prepareStatement("select * from posts where catId=?");
		p.setInt(1, catId);
		ResultSet set = p.executeQuery();
		
		while(set.next()) {
			int pid = set.getInt("pid");
			String pTitle  =set.getString("pTitle");
			String pContent=set.getString("pContent");
			String pPic  =set.getString("pPic");
			String pCode  =set.getString("pCode");
			Timestamp date = set.getTimestamp("pDate");
			int userId = set.getInt("userId");
			Posts posts = new Posts(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
			
			list.add(posts);
			
		}
		
		
	} catch (Exception e) {
	e.printStackTrace();
		// TODO: handle exception
	}
	
	
	
	return list;
	
}



public Posts getPostByPostId(int postId){
	
	
	//fetch all post by id
	Posts posts = null;
try {
		
		PreparedStatement p =  con.prepareStatement("select * from posts where pid=?");
		p.setInt(1, postId);
		ResultSet set = p.executeQuery();
		
		if(set.next()) {
			
			int pid = set.getInt("pid");
			String pTitle  =set.getString("pTitle");
			String pContent=set.getString("pContent");
			String pPic  =set.getString("pPic");
			String pCode  =set.getString("pCode");
			int catId  =set.getInt("catId");
			Timestamp date = set.getTimestamp("pDate");
			int userId = set.getInt("userId");
			 posts = new Posts(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
		
			
		}
		
		
	} catch (Exception e) {
	e.printStackTrace();
		// TODO: handle exception
	}
	
	
	
	return posts;
	
}

}