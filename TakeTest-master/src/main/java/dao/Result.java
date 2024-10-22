package dao;

import java.sql.Date;

public class Result {
	
	private int test_id;
	private int user_id;
	private String test_tag;
	private int max_marks;
	private int score;
	private String status;
	private Date date;
	
	public Result(int test_id, int user_id, String test_tag, int max_marks, int score, String status, Date date) {
		super();
		this.test_id = test_id;
		this.user_id = user_id;
		this.test_tag = test_tag;
		this.max_marks = max_marks;
		this.score = score;
		this.status = status;
		this.date = date;
	}
	
	public Result() {
		// TODO Auto-generated constructor stub
	}

	public int getTestId() {
		return test_id;
	}
	public void setTestId(int test_id) {
		this.test_id = test_id;
	}
	public int getUserId() {
		return user_id;
	}
	public void setUserId(int user_id) {
		this.user_id = user_id;
	}
	public String getTestTag() {
		return test_tag;
	}
	public void setTestTag(String test_tag) {
		this.test_tag = test_tag;
	}
	public int getMaxMarks() {
		return max_marks;
	}
	public void setMaxMarks(int max_marks) {
		this.max_marks = max_marks;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

}
