package com.botao.request;

import java.util.List;


public class SurveyAnswerBodyRequest {

    private int questionId;

    private int questionType;

    public String content;

    public List<Integer> choice;

    private List<SurveyAnswerArrayRequest> arrayContent;

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getQuestionType() {
        return questionType;
    }

    public void setQuestionType(int questionType) {
        this.questionType = questionType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Integer> getChoice() {
        return choice;
    }

    public void setChoice(List<Integer> choice) {
        this.choice = choice;
    }

    public List<SurveyAnswerArrayRequest> getArrayContent() {
        return arrayContent;
    }

    public void setArrayContent(List<SurveyAnswerArrayRequest> arrayContent) {
        this.arrayContent = arrayContent;
    }

    @Override
    public String toString() {
        return "SurveyAnswerBodyRequest{" +
                "questionId=" + questionId +
                ", questionType=" + questionType +
                ", content='" + content + '\'' +
                ", choice=" + choice +
                ", arrayContent=" + arrayContent +
                '}';
    }
}