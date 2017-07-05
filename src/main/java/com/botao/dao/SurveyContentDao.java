package com.botao.dao;

import com.botao.entry.SurveyContent;
import org.springframework.stereotype.Repository;

@Repository
public interface SurveyContentDao {

    public boolean insertContent(SurveyContent surveyContent);

    public boolean updateContent(SurveyContent surveyContent);

    public SurveyContent getContent(int surveyId);

    public boolean deleteSurveyContent(int surveyId);
}
