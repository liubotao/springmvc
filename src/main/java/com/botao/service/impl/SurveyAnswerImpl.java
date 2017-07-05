package com.botao.service.impl;

import com.botao.dao.SurveyAnswerDao;
import com.botao.entry.SurveyAnswer;
import com.botao.service.SurveyAnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SurveyAnswerImpl implements SurveyAnswerService {

    @Autowired
    private SurveyAnswerDao surveyAnswerDao;

    public boolean insertAnswerList(List<SurveyAnswer> surveyAnswerList) {
        return surveyAnswerDao.insertAnswerList(surveyAnswerList);
    }

    public boolean deleteSurveyAnswerList(int surveyId) {
        return surveyAnswerDao.deleteSurveyAnswerList(surveyId);
    }
}
