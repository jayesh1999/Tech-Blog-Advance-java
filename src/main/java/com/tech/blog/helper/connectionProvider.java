package com.tech.blog.helper;

import java.sql.*;

public class connectionProvider {

	private static Connection con;

	public static Connection getConnection() {

		try {

			if (con == null) {
				// driver class load
				Class.forName("com.mysql.cj.jdbc.Driver");

				// create a connection
				try {
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "root");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		return con;

	}

}
