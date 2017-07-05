package com.botao.request;

import java.util.List;


public class SurveyAnswerRequest {

    private int surveyId;

    private List<SurveyAnswerBodyRequest> answerList;

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public List<SurveyAnswerBodyRequest> getAnswerList() {
        return answerList;
    }

    public void setAnswerList(List<SurveyAnswerBodyRequest> answerList) {
        this.answerList = answerList;
    }
}