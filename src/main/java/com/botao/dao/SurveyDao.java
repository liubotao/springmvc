package com.botao.dao;

import com.botao.entry.Survey;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SurveyDao {

    public Survey getSurvey(int surveyId);

    public int insertSurvey(Survey survey);

    public boolean updateSurvey(Survey survey);

    public List<Survey> getSurveyList(@Param("offset") int offset, @Param("limit") int limit);

    public int getSurveyTotal();

    public boolean deleteSurvey(int surveyId);
}
