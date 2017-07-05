package com.botao.entry;

import com.botao.util.StringJsonSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public final class SurveyChoice {

    private int order;

    private int choiceAbsoluteId;

    private String content;

    private String commit = "";

    private String isOther;

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getChoiceAbsoluteId() {
        return choiceAbsoluteId;
    }

    public void setChoiceAbsoluteId(int choiceAbsoluteId) {
        this.choiceAbsoluteId = choiceAbsoluteId;
    }

    @JsonSerialize(using = StringJsonSerializer.class)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getIsOther() {
        return isOther;
    }

    public void setIsOther(String isOther) {
        this.isOther = isOther;
    }

    public String getCommit() {
        return commit;
    }

    public void setCommit(String commit) {
        this.commit = commit;
    }
}
