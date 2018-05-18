package com.test.ex002;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class MemberMapper implements RowMapper<Member> {

	@Override
	public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Member m = new Member();
		m.setMid_(rs.getString("mid_"));
		m.setName_(rs.getString("name_"));
		m.setPhone(rs.getString("phone"));
		m.setEmail(rs.getString("email"));
		m.setRegDate(rs.getDate("regDate").toLocalDate());
		m.setDeptName(rs.getString("deptName"));
		
		return m;
	}

}
