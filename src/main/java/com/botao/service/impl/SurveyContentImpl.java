package com.botao.service.impl;

import com.botao.dao.SurveyContentDao;
import com.botao.entry.SurveyContent;
import com.botao.service.SurveyContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SurveyContentImpl implements SurveyContentService {

    @Autowired
    private SurveyContentDao surveyContentDao;

    public SurveyContent getContent(int surveyId) {
        return surveyContentDao.getContent(surveyId);
    }

    public boolean insertContent(SurveyContent surveyContent) {
        return surveyContentDao.insertContent(surveyContent);
    }

    public boolean updateContent(SurveyContent surveyContent) {
        return surveyContentDao.updateContent(surveyContent);
    }

    public boolean deleteSurveyContent(int deleteSurveyContent) {
        return surveyContentDao.deleteSurveyContent(deleteSurveyContent);
    }
}
