package dao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;
import database.DbConnection;

public class TestDao {
	
	// -----------------------------------------------------------------------------------------------------------------------

	public static ArrayList<Test> getAllTests() throws Exception {

		ArrayList<Test> arr = new ArrayList<>();
		String query = "SELECT * FROM test";

		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();

			while (db.rs.next()) {
				Test test = new Test();
				test.setTestId(db.rs.getInt("test_id"));
				test.setTestTag(db.rs.getString("test_tag"));
				test.setNoOfQuestions(db.rs.getInt("questions"));
				test.setNoOfCandidates(db.rs.getInt("candidates"));
				test.setPassMarks(db.rs.getInt("pass_marks"));
				test.setLang(db.rs.getString("lang"));
				test.setTopic(db.rs.getString("topic"));
				test.setLevel(db.rs.getString("level"));
				arr.add(test);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// -----------------------------------------------------------------------------------------------------------------
	
	public static ArrayList<Test> filterTest(String lang, String topic, String level) throws Exception {
		
		ArrayList<Test> arr = new ArrayList<>();
		String query = "SELECT * FROM test WHERE";
		
		try (DbConnection db = new DbConnection()) {
			
			if(lang.equals("all")) query += " lang is not null";
			else query += " lang = ?";
			
			if(topic.equals("all")) query += " AND topic is not null";
			else query += " AND topic = ?";
			
			if(level.equals("all")) query += " AND level is not null";
			else query += " AND level = ?";
			
			db.pstm = db.con.prepareStatement(query);
			int paramCount = 1;

	        if (!lang.equals("all")) {
	            db.pstm.setString(paramCount, lang);
	            paramCount++;
	        }
	        if (!topic.equals("all")) {
	            db.pstm.setString(paramCount, topic);
	            paramCount++;
	        }
	        if (!level.equals("all")) {
	            db.pstm.setString(paramCount, level);
	            paramCount++;
	        }
			db.rs = db.pstm.executeQuery();
			while (db.rs.next()) {
				Test test = new Test();
				test.setTestId(db.rs.getInt("test_id"));
				test.setTestTag(db.rs.getString("test_tag"));
				test.setNoOfQuestions(db.rs.getInt("questions"));
				test.setNoOfCandidates(db.rs.getInt("candidates"));
				test.setPassMarks(db.rs.getInt("pass_marks"));
				test.setLang(db.rs.getString("lang"));
				test.setTopic(db.rs.getString("topic"));
				test.setLevel(db.rs.getString("level"));
				arr.add(test);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.print("query not run");
			return null;
		}
	}
	
	// ------------------------------------------------------------------------------------------------------
	
	public static ArrayList<Question> getAllQuestions(int test_id) throws Exception {

		ArrayList<Question> arr = new ArrayList<>();
		String query = "SELECT * FROM questions WHERE test_id = " + test_id;

		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();

			while (db.rs.next()) {
				Question q = new Question();
				q.setTestId(test_id);
				q.setQuesId(db.rs.getInt("ques_id"));
				q.setQuesText(db.rs.getString("ques_text"));
				q.setOption1(db.rs.getString("option1"));
				q.setOption2(db.rs.getString("option2"));
				q.setOption3(db.rs.getString("option3"));
				q.setOption4(db.rs.getString("option4"));
				q.setCorrectAnswer(db.rs.getInt("correct_answer"));
				arr.add(q);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// ------------------------------------------------------------------------------------------------------
	
	public static boolean addNewTest(String test_tag, String questions, String pass_marks, String lang, String topic, String level) {
		String query = "INSERT INTO test (test_tag, questions, pass_marks, candidates, lang, topic, level) VALUES (?,?,?,0,?,?,?)";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, test_tag);
			db.pstm.setString(2, questions);
			db.pstm.setString(3, pass_marks);
			db.pstm.setString(4, lang);
			db.pstm.setString(5, topic);
			db.pstm.setString(6, level);
			int count = db.pstm.executeUpdate();
			return count > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ----------------------------------------------------------------------------------------------------------
	
	public static boolean addResult(int test_id, int user_id, String test_tag, int total, int score, String status,
			Timestamp dateTime) {
		
		String query = "INSERT INTO result (test_id, user_id, test_tag, max_marks, score, status, date) VALUES (?,?,?,?,?,?,?)";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, test_id);	
			db.pstm.setInt(2, user_id);	
			db.pstm.setString(3, test_tag);
			db.pstm.setInt(4, total);
			db.pstm.setInt(5, score);	
			db.pstm.setString(6, status);
			db.pstm.setTimestamp(7, dateTime);
			int count = db.pstm.executeUpdate();
			return count > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static ArrayList<Result> getResults(int user_id) throws Exception {
				
		ArrayList<Result> arr = new ArrayList<>();
		String query = "SELECT * FROM result where user_id = " + user_id;

		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();

			while (db.rs.next()) {
				Result result = new Result();
				result.setTestId(db.rs.getInt("test_id"));
				result.setUserId(db.rs.getInt("user_id"));
				result.setTestTag(db.rs.getString("test_tag"));
				result.setMaxMarks(db.rs.getInt("max_marks"));
				result.setScore(db.rs.getInt("score"));
				result.setStatus(db.rs.getString("status"));
				result.setDate(db.rs.getDate("date"));
				arr.add(result);
			}
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	
	// ------------------------------------------------------------------------------------------------------

	public static void deleteTest(String test_id) {
		String query = "DELETE FROM test WHERE test_id = ?";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, test_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void deleteQues(String ques_id, int test_id) {
		String query = "DELETE FROM questions WHERE ques_id = ?";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, ques_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		query = "UPDATE test SET questions = questions-1 WHERE test_id = ?";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, test_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// ------------------------------------------------------------------------------------------------------
	
	public static void addNewQuestion(int test_id, String quesText, String option1, String option2, String option3,
			String option4, int correctAnswer) {

		String query = "INSERT INTO questions (test_id, ques_text, option1, option2, option3, "
				+ "option4, correct_answer) VALUES (?,?,?,?,?,?,?)";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, test_id);
			db.pstm.setString(2, quesText);
			db.pstm.setString(3, option1);
			db.pstm.setString(4, option2);
			db.pstm.setString(5, option3);
			db.pstm.setString(6, option4);
			db.pstm.setInt(7, correctAnswer);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addDummyQues(int test_id) {
		
		String query = "INSERT INTO questions (test_id, ques_text, option1, option2, option3, "
				+ "option4, correct_answer) VALUES (?,?,?,?,?,?,?)";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, test_id);
			db.pstm.setString(2, "");
			db.pstm.setString(3, "");
			db.pstm.setString(4, "");
			db.pstm.setString(5, "");
			db.pstm.setString(6, "");
			db.pstm.setInt(7, 0);
			int count = db.pstm.executeUpdate();
			
			query = "UPDATE test SET questions = questions+1 WHERE test_id = ?";
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, test_id);
			count = db.pstm.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	// ------------------------------------------------------------------------------------------------------

	public static void updateCandidates(int test_id) {
		// update the candidate no
		String query = "UPDATE test SET candidates = candidates+1 WHERE test_id = " + test_id;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ------------------------------------------------------------------------------------------------------
	

	public static int getTestId() throws Exception {

		String query = "SELECT test_id FROM test";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			int ans = -1;
			while (db.rs.next())
				ans = db.rs.getInt("test_id");
			return ans;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public static String getTestName(int test_id) throws Exception {
		
		String query = "SELECT test_tag FROM test WHERE test_id = " + test_id;
		String ans = "";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next())
				ans = db.rs.getString("test_tag");
			return ans;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ans;
	}

	public static int getPassMarks(int test_id) throws Exception {
		String query = "SELECT pass_marks FROM test WHERE test_id = " + test_id;
		int ans = 0;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next())
				ans = db.rs.getInt("pass_marks");
			return ans;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ans;
	
	}
	
	public static String getTestTopic(int test_id) throws Exception {
		
		String query = "SELECT topic FROM test WHERE test_id = " + test_id;
		String ans = "";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next())
				ans = db.rs.getString("topic");
			return ans;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ans;		
	}

	public static String getTestLang(int test_id) throws Exception {

		String query = "SELECT lang FROM test WHERE test_id = " + test_id;
		String ans = "";
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next())
				ans = db.rs.getString("lang");
			return ans;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ans;	
	}	
	// ------------------------------------------------------------------------------------------------------

	public static void updatePassMarks(int test_id, int passMarks) {
		
		String query = "UPDATE test SET pass_marks = ? WHERE test_id = ?" ;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setInt(1, passMarks);
			db.pstm.setInt(2, test_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public static void updateTestTopic(int test_id, String topic) {
		
		String query = "UPDATE test SET topic = ? WHERE test_id = ?" ;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, topic);
			db.pstm.setInt(2, test_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}

	public static void updateTestLang(int test_id, String lang) {
	
		String query = "UPDATE test SET lang = ? WHERE test_id = ?" ;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, lang);
			db.pstm.setInt(2, test_id);
			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	// ------------------------------------------------------------------------------------------------------

	public static void updateQuestion(int test_id, int ques_id, String ques_text, String option1, String option2,
			String option3, String option4, int correct_answer) {
		
		String query = "UPDATE questions SET ques_text = ?, option1 = ?, option2 = ?, option3 = ?, option4 = ?, correct_answer = ?"
				+ " WHERE ques_id = ? AND test_id = ?" ;
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.pstm.setString(1, ques_text);
			db.pstm.setString(2, option1);
			db.pstm.setString(3, option2);
			db.pstm.setString(4, option3);
			db.pstm.setString(5, option4);
			db.pstm.setInt(6, correct_answer);
			db.pstm.setInt(7, ques_id);
			db.pstm.setInt(8, test_id);

			int count = db.pstm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	
	// ------------------------------------------------------------------------------------------------------
	
	public static int[] getScore(int test_id, String[] answers, boolean nullString) throws Exception {
		
		String query = "SELECT correct_answer FROM questions WHERE test_id = " + test_id;
		int count = 0;
		int total = 0;
		int[] ans = new int[2];
		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			int i = 0;
			while(db.rs.next()) {
				if(i<answers.length && answers[i].length() != 0) {
					if(nullString == false && db.rs.getInt("correct_answer") == Integer.parseInt(answers[i])) count++;
				}
				i++;
				total++;
			}
			ans[0] = count;
			ans[1]  =total;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ans;
		
	}
	
	// ------------------------------------------------------------------------------------------------------

	public static ArrayList<String> getAllTopics() throws Exception {
		
		ArrayList<String> ans = new ArrayList<>();
		String query = "SELECT DISTINCT topic FROM test";

		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next()) ans.add(db.rs.getString("topic"));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return ans;
	}

	public static ArrayList<String> getAllLang() throws Exception {
		
		ArrayList<String> ans = new ArrayList<>();
		String query = "SELECT DISTINCT lang FROM test";

		try (DbConnection db = new DbConnection()) {
			db.pstm = db.con.prepareStatement(query);
			db.rs = db.pstm.executeQuery();
			while (db.rs.next()) ans.add(db.rs.getString("lang"));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return ans;
	}
	
}