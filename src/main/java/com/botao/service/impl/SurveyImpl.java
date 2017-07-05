package com.botao.service.impl;

import com.botao.dao.SurveyDao;
import com.botao.entry.Survey;
import com.botao.service.SurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SurveyImpl implements SurveyService {

    @Autowired
    private SurveyDao surveyDao;

    public Survey getSurvey(int surveyId) {
        return surveyDao.getSurvey(surveyId);
    }

    public int insertSurvey(Survey survey) {
        return surveyDao.insertSurvey(survey);
    }

    public boolean updateSurvey(Survey survey) {
        return surveyDao.updateSurvey(survey);
    }

    public List<Survey> getSurveyList(int offset, int limit) {
        return surveyDao.getSurveyList(offset, limit);
    }

    public int getSurveyTotal() {
        return surveyDao.getSurveyTotal();
    }

    public boolean deleteSurvey(int surveyId) {
        return surveyDao.deleteSurvey(surveyId);
    }

}
