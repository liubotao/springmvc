package com.botao.entry;

import com.botao.util.StringJsonSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import java.util.List;


public class SurveyQuestion extends Survey {
    private int surveyId;

    @JsonSerialize(using = StringJsonSerializer.class)
    private String content;

    private int typeId;

    private int order;

    private int hidden;

    private int questionId;

    private String required = "Y";

    private int min;

    private int max;

    private String commit = "";

    private List<SurveyChoice> choice;

    private List<SurveyCheckbox> checkboxArrayTitle;

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

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public List<SurveyChoice> getChoice() {
        return choice;
    }

    public void setChoice(List<SurveyChoice> choice) {
        this.choice = choice;
    }

    public int getHidden() {
        return hidden;
    }

    public void setHidden(int hidden) {
        this.hidden = hidden;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }

    public int getMin() {
        return min;
    }

    public void setMin(int min) {
        this.min = min;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public List<SurveyCheckbox> getCheckboxArrayTitle() {
        return checkboxArrayTitle;
    }

    public void setCheckboxArrayTitle(List<SurveyCheckbox> checkboxArrayTitle) {
        this.checkboxArrayTitle = checkboxArrayTitle;
    }

    public String getCommit() {
        return commit;
    }

    public void setCommit(String commit) {
        this.commit = commit;
    }
}