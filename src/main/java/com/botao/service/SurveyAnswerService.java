package com.botao.service;

import com.botao.entry.SurveyAnswer;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SurveyAnswerService {

    public boolean insertAnswerList(List<SurveyAnswer> surveyAnswerList);

    public boolean deleteSurveyAnswerList(int surveyId);
}
