package com.botao.request;

import com.botao.entry.Survey;
import com.botao.entry.SurveyLogic;
import com.botao.entry.SurveyQuestion;

import java.util.List;


public class SurveyQuestionRequest extends Survey {
    private List<SurveyLogic> logic;

    private List<SurveyQuestion> content;

    public List<SurveyQuestion> getContent() {
        return content;
    }

    public void setContent(List<SurveyQuestion> content) {
        this.content = content;
    }

    public List<SurveyLogic> getLogic() {
        return logic;
    }

    public void setLogic(List<SurveyLogic> logic) {
        this.logic = logic;
    }
}