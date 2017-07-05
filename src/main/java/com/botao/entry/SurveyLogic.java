package com.botao.entry;

import java.util.List;

public class SurveyLogic {

    private int questionId;

    private List<SurveyLogicAreaQuestion> areaQuestion;

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public List<SurveyLogicAreaQuestion> getAreaQuestion() {
        return areaQuestion;
    }

    public void setAreaQuestion(List<SurveyLogicAreaQuestion> areaQuestion) {
        this.areaQuestion = areaQuestion;
    }
}
