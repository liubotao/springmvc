package com.botao.entry;


import com.botao.util.StringJsonSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class SurveyContent {

    private int surveyId;

    @JsonSerialize(using = StringJsonSerializer.class)
    private String content;

    private String logic;

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLogic() {
        return logic;
    }

    public void setLogic(String logic) {
        this.logic = logic;
    }
}
