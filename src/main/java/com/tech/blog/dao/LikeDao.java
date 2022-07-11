package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.cj.protocol.Resultset;

public class LikeDao {

	Connection con;

	public LikeDao(Connection con) {
		this.con = con;

	}

	public boolean insertLike(int pid, int uid) {

		boolean f = false;
		try {

			String q = "insert into liked(pid,uid) values(?,?)";
			PreparedStatement p = this.con.prepareStatement(q);

			p.setInt(1, pid);
			p.setInt(2, uid);
			p.executeUpdate();
			f = true;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return f;
	}

	public int countLikeOnPost(int pid) {
		int count = 0;

		String q = "select count(*) from liked where pid=?";
		try {
			PreparedStatement p = this.con.prepareStatement(q);
			p.setInt(1, pid);

			ResultSet rs = p.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return count;
	}

	public boolean isLikedByUser(int pid, int uid) {

		boolean f = false;
		try {
			PreparedStatement ps = this.con.prepareStatement("select * from liked where pid=? and uid=?");
			ps.setInt(1, pid);
			ps.setInt(2, uid);

			ResultSet set = ps.executeQuery();

			if (set.next()) {
				f = true;
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return f;

	}

	public boolean deleteLike(int pid, int uid) {
		boolean f = false;

		try {

			PreparedStatement ps = this.con.prepareStatement("delete from liked where pid=? and uid=?");
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ps.executeQuery();
			f = true;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return f;
	}

}
