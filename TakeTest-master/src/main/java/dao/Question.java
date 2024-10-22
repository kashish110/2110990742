package dao;

public class Question {
	
	private int ques_id;
    private int test_id;
    private String ques_text;
    private String option1;
    private String option2;
    private String option3;
    private String option4;
    private int correct_answer;
    
    // getters and setters
    
	public int getTestId() { return test_id; }
    public void setTestId(int id) {this.test_id = id;}
    
    public int getQuesId() { return ques_id; }
    public void setQuesId(int id) {this.ques_id = id;}
    
    public int getCorrectAnswer() { return correct_answer; }
    public void setCorrectAnswer(int val) {this.correct_answer = val;}
    
    public String getQuesText() {return ques_text;}
    public void setQuesText(String text) {this.ques_text = text;}
    
    public String getOption1() { return option1; }
    public void setOption1(String option) {this.option1 = option;}
    
    public String getOption2() { return option2; }
    public void setOption2(String option) {this.option2 = option;}
    
    public String getOption3() { return option3; }
    public void setOption3(String option) {this.option3 = option;}
    
    public String getOption4() { return option4; }
    public void setOption4(String option) {this.option4 = option;}

}
