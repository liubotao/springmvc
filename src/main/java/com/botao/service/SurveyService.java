package com.botao.service;

import com.botao.entry.Survey;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SurveyService {

    public Survey getSurvey(int surveyId);

    public int insertSurvey(Survey survey);

    public boolean updateSurvey(Survey survey);

    public boolean deleteSurvey(int surveyId);

    public List<Survey> getSurveyList(int offset, int limit);

    public int getSurveyTotal();

}
