package com.botao.service;


import com.botao.entry.SurveyContent;
import org.springframework.stereotype.Service;

@Service
public interface SurveyContentService {

    public SurveyContent getContent(int surveyId);

    public boolean insertContent(SurveyContent surveyContent);

    public boolean updateContent(SurveyContent surveyContent);

    public boolean deleteSurveyContent(int surveyId);
}
