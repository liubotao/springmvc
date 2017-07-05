package com.botao.dao;

import com.botao.entry.SurveyAnswer;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SurveyAnswerDao {

    public boolean insertAnswerList(List<SurveyAnswer> surveyAnswerList);

    public boolean deleteSurveyAnswerList(int surveyId);

}
