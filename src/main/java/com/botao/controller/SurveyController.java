package com.botao.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.botao.entry.Survey;
import com.botao.entry.SurveyAnswer;
import com.botao.entry.SurveyContent;
import com.botao.entry.SurveyQuestion;
import com.botao.request.SurveyAnswerArrayRequest;
import com.botao.request.SurveyAnswerBodyRequest;
import com.botao.request.SurveyAnswerRequest;
import com.botao.request.SurveyQuestionRequest;
import com.botao.response.Response;
import com.botao.response.ResponseType;
import com.botao.service.SurveyAnswerService;
import com.botao.service.SurveyContentService;
import com.botao.service.SurveyService;
import com.botao.util.Page;
import com.botao.util.QuestionType;
import com.google.common.base.Strings;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.*;


@Controller
public class SurveyController {

    private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);

    @Autowired
    private SurveyService surveyService;

    @Autowired
    private SurveyContentService surveyContentService;

    @Autowired
    private SurveyAnswerService surveyAnswerService;

    @Autowired
    private ServletContext servletContext;

    @RequestMapping(value = "/survey/create",
            method = RequestMethod.POST,
            produces = "application/json")
    @ResponseBody
    public String create(@RequestParam(value = "surveyName", required = true) String surveyName) {
        Date addTime = new Date();
        Survey survey = new Survey();
        survey.setAddTime(addTime);
        survey.setSurveyName(surveyName);
        survey.setSurveyTitle("欢迎参加调查！答卷数据仅用于统计分析，请放心填写。题目选项无对错之分，按照实际情况选择即可。感谢您的帮助");
        surveyService.insertSurvey(survey);

        SurveyContent surveyContent = new SurveyContent();
        surveyContent.setSurveyId(survey.getSurveyId());
        surveyContentService.insertContent(surveyContent);

        HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
        hashMap.put("surveyId", survey.getSurveyId());

        return new Response(ResponseType.SUCCESS, "创建成功", hashMap).toString();
    }

    @RequestMapping(value = "/survey/createSurveyQuestion",
            method = RequestMethod.POST,
            headers = {"Content-type=application/json"},
            produces = "application/json")
    @ResponseBody
    public String createSurveyQuestion(@RequestBody SurveyQuestionRequest surveyQuestionRequest) {

        if (Strings.isNullOrEmpty(surveyQuestionRequest.getSurveyName())) {
            throw new IllegalArgumentException("问卷名不能为空");
        }

        if (surveyQuestionRequest.getSurveyId() < 1) {
            throw new IllegalArgumentException("问卷号错误");
        }

        Survey survey = new Survey();
        survey.setSurveyId(surveyQuestionRequest.getSurveyId());
        survey.setSurveyName(surveyQuestionRequest.getSurveyName());
        survey.setSurveyStatus(surveyQuestionRequest.getSurveyStatus());
        survey.setSurveyTitle(surveyQuestionRequest.getSurveyTitle());
        surveyService.updateSurvey(survey);

        String content = JSON.toJSONString(surveyQuestionRequest.getContent());
        String logic = JSON.toJSONString(surveyQuestionRequest.getLogic());
        SurveyContent surveyContent = new SurveyContent();
        surveyContent.setSurveyId(surveyQuestionRequest.getSurveyId());
        surveyContent.setContent(content);
        surveyContent.setLogic(logic);
        surveyContentService.updateContent(surveyContent);

        return new Response(ResponseType.SUCCESS, "创建成功").toString();
    }

    @RequestMapping(value = "/survey")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("test", "test");
        modelAndView.setViewName("survey/index");
        return modelAndView;
    }

    @RequestMapping(value = "/")
    public ModelAndView manage(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        page = page < 1 ? 1 : page;
        int pageSize = 5;
        int offset = (page - 1) * pageSize;
        List<Survey> surveyList = surveyService.getSurveyList(offset, pageSize);
        int total = surveyService.getSurveyTotal();
        Page pager = new Page(page, pageSize, total, "?page=%page%");
        String pagerStr = pager.toString();

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("surveyList", surveyList);
        modelAndView.addObject("pagerStr", pagerStr);
        modelAndView.setViewName("survey/manage");
        return modelAndView;
    }

    @RequestMapping(value = "/survey/createSurvey")
    public ModelAndView createSurvey() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("survey/createSurvey");
        return modelAndView;
    }

    @RequestMapping(value = "/survey/previewSurvey", method = RequestMethod.GET)
    public ModelAndView preview(@RequestParam(value = "surveyId", required = true) int surveyId) {
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        Survey survey = surveyService.getSurvey(surveyId);
        SurveyContent surveyContent = surveyContentService.getContent(surveyId);
        List<SurveyQuestion> surveyQuestionList = JSON.parseObject(surveyContent.getContent(), new TypeReference<List<SurveyQuestion>>() {
        });
        HashMap<String, List<SurveyQuestion>> surveyPageQuestionList = new HashMap<String, List<SurveyQuestion>>();
        int page = 1;

        if (surveyQuestionList != null) {
            List<SurveyQuestion> newSurveyQuestionList = new ArrayList<SurveyQuestion>();
            int currentSize = 0;
            int surveyQuestionListSize = surveyQuestionList.size();

            for (SurveyQuestion surveyQuestion : surveyQuestionList) {
                newSurveyQuestionList.add(surveyQuestion);
                currentSize++;
                if (surveyQuestion.getTypeId() == QuestionType.PAGE) {
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                    page++;
                }

                if (currentSize == surveyQuestionListSize) {
                    SurveyQuestion question = new SurveyQuestion();
                    question.setSurveyId(surveyQuestion.getSurveyId());
                    question.setTypeId(QuestionType.PAGE);
                    question.setContent(page + "/" + page);
                    newSurveyQuestionList.add(question);
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                }
            }
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("survey", survey);
        modelAndView.addObject("page", page);
        modelAndView.addObject("surveyPageQuestionList", surveyPageQuestionList);
        modelAndView.setViewName("survey/preview");

        return modelAndView;
    }

    @RequestMapping(value = "/survey/{surveyId}.html")
    @ResponseBody
    public ModelAndView view(@PathVariable int surveyId) {
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        Survey survey = surveyService.getSurvey(surveyId);
        SurveyContent surveyContent = surveyContentService.getContent(surveyId);
        List<SurveyQuestion> surveyQuestionList = JSON.parseObject(surveyContent.getContent(), new TypeReference<List<SurveyQuestion>>() {
        });

        int page = 1;
        HashMap<String, List<SurveyQuestion>> surveyPageQuestionList = new HashMap<String, List<SurveyQuestion>>();
        List<SurveyQuestion> newSurveyQuestionList = new ArrayList<SurveyQuestion>();
        int currentSize = 0;

        if (surveyQuestionList != null) {
            int surveyQuestionListSize = surveyQuestionList.size();

            for (SurveyQuestion surveyQuestion : surveyQuestionList) {
                newSurveyQuestionList.add(surveyQuestion);
                currentSize++;
                if (surveyQuestion.getTypeId() == QuestionType.PAGE) {
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                    page++;
                }

                if (currentSize == surveyQuestionListSize) {
                    SurveyQuestion question = new SurveyQuestion();
                    question.setSurveyId(surveyQuestion.getSurveyId());
                    question.setTypeId(QuestionType.PAGE);
                    question.setContent(page + "/" + page);
                    newSurveyQuestionList.add(question);
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                }
            }
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("survey", survey);
        modelAndView.addObject("page", page);
        modelAndView.addObject("surveyId", surveyId);
        modelAndView.addObject("surveyPageQuestionList", surveyPageQuestionList);
        modelAndView.setViewName("survey/view");

        return modelAndView;
    }

    @RequestMapping(value = "/survey/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "surveyId", required = true) int surveyId) {
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        Survey survey = surveyService.getSurvey(surveyId);
        SurveyContent surveyContent = surveyContentService.getContent(surveyId);
        List<SurveyQuestion> surveyQuestionList = JSON.parseObject(surveyContent.getContent(), new TypeReference<List<SurveyQuestion>>() {
        });

        int page = 1;
        if (surveyQuestionList != null) {
            for (SurveyQuestion surveyQuestion : surveyQuestionList) {
                if (surveyQuestion.getTypeId() == QuestionType.PAGE) {
                    page++;
                }
            }
        }

        String logic = Strings.isNullOrEmpty(surveyContent.getLogic()) ? "[]" : surveyContent.getLogic();

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("survey", survey);
        modelAndView.addObject("page", page);
        modelAndView.addObject("logic", logic);
        modelAndView.addObject("surveyQuestionList", surveyQuestionList);
        modelAndView.setViewName("survey/edit");

        return modelAndView;
    }

    @RequestMapping(value = "/survey/answer",
            method = RequestMethod.POST,
            headers = {"Content-type=application/json"},
            produces = "application/json")
    @ResponseBody
    public String answer(@RequestBody SurveyAnswerRequest surveyAnswerRequest) {
        int surveyId = surveyAnswerRequest.getSurveyId();
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        List<SurveyAnswer> surveyAnswerList = new ArrayList<SurveyAnswer>();
        List<SurveyAnswerBodyRequest> surveyAnswerBodyRequestList = surveyAnswerRequest.getAnswerList();
        Date addTime = new Date();
        for (SurveyAnswerBodyRequest surveyAnswerBodyRequest : surveyAnswerBodyRequestList) {
            int questionType = surveyAnswerBodyRequest.getQuestionType();
            int questionId = surveyAnswerBodyRequest.getQuestionId();

            if (questionType == QuestionType.RADIO || questionType == QuestionType.SELECT) {
                SurveyAnswer surveyAnswer = new SurveyAnswer();
                surveyAnswer.setSurveyId(surveyId);
                surveyAnswer.setAddTime(addTime);
                surveyAnswer.setQuestionId(questionId);
                surveyAnswer.setQuestionType(questionType);
                surveyAnswer.setChoice(surveyAnswerBodyRequest.getChoice().get(0));
                surveyAnswerList.add(surveyAnswer);
            } else if (questionType == QuestionType.CHECKOUT) {
                List<Integer> choiceList = surveyAnswerBodyRequest.getChoice();
                for (Integer choice : choiceList) {
                    SurveyAnswer surveyAnswer = new SurveyAnswer();
                    surveyAnswer.setSurveyId(surveyId);
                    surveyAnswer.setAddTime(addTime);
                    surveyAnswer.setQuestionId(questionId);
                    surveyAnswer.setQuestionType(questionType);
                    surveyAnswer.setChoice(choice);
                    surveyAnswerList.add(surveyAnswer);
                }
            } else if (questionType == QuestionType.TEXT || questionType == QuestionType.TEXTAREA) {
                SurveyAnswer surveyAnswer = new SurveyAnswer();
                surveyAnswer.setSurveyId(surveyId);
                surveyAnswer.setAddTime(addTime);
                surveyAnswer.setQuestionId(questionId);
                surveyAnswer.setQuestionType(questionType);
                surveyAnswer.setContent(surveyAnswerBodyRequest.getContent());
                surveyAnswerList.add(surveyAnswer);
            } else if (questionType == QuestionType.MULTICHECKBOX) {
                //logger.info(surveyAnswerBodyRequest.toString());
                for (SurveyAnswerArrayRequest surveyAnswerArrayRequest : surveyAnswerBodyRequest.getArrayContent()) {
                    logger.info(surveyAnswerArrayRequest.toString());
                    SurveyAnswer surveyAnswer = new SurveyAnswer();
                    surveyAnswer.setSurveyId(surveyId);
                    surveyAnswer.setAddTime(addTime);
                    surveyAnswer.setQuestionId(questionId);
                    surveyAnswer.setQuestionType(questionType);
                    surveyAnswer.setRows(surveyAnswerArrayRequest.getRows());
                    surveyAnswer.setCols(surveyAnswerArrayRequest.getCols());
                    surveyAnswerList.add(surveyAnswer);
                }
            }
        }

        surveyAnswerService.insertAnswerList(surveyAnswerList);

        return new Response(ResponseType.SUCCESS, "创建成功").toString();
    }

    @RequestMapping(value = "/survey/success.html", method = RequestMethod.GET)
    public ModelAndView success() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("survey/success");
        return modelAndView;
    }

    @RequestMapping(value = "/survey/copy",
            method = RequestMethod.GET,
            produces = "application/json")
    @ResponseBody
    public String copy(@RequestParam(value = "surveyId", required = true) int surveyId) {
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        Date addTime = new Date();
        Survey survey = surveyService.getSurvey(surveyId);
        Survey copySurvey = new Survey();
        String copySurveyName = survey.getSurveyName() + "-副本";
        copySurvey.setSurveyName(copySurveyName);
        copySurvey.setSurveyTitle(survey.getSurveyTitle());
        copySurvey.setAddTime(addTime);
        surveyService.insertSurvey(copySurvey);
        int copySurveyId = copySurvey.getSurveyId();

        SurveyContent surveyContent = surveyContentService.getContent(surveyId);
        SurveyContent copySurveyContent = new SurveyContent();
        copySurveyContent.setSurveyId(copySurveyId);
        copySurveyContent.setLogic(surveyContent.getLogic());
        copySurveyContent.setContent(surveyContent.getContent());
        surveyContentService.insertContent(copySurveyContent);

        HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
        hashMap.put("surveyId", copySurveyId);

        return new Response(ResponseType.SUCCESS, "复制成功", hashMap).toString();
    }

    @RequestMapping(value = "/survey/delete",
            method = RequestMethod.GET,
            produces = "application/json")
    @ResponseBody
    public String delete(@RequestParam(value = "surveyId", required = true) int surveyId) {
        if (surveyId < 1) {
            throw new IllegalArgumentException("问卷ID错误");
        }

        surveyService.deleteSurvey(surveyId);
        surveyContentService.deleteSurveyContent(surveyId);
        surveyAnswerService.deleteSurveyAnswerList(surveyId);

        return new Response(ResponseType.SUCCESS, "删除成功").toString();
    }

    @RequestMapping(value = "/survey/pub",
            method = RequestMethod.GET,
            produces = "application/json")
    @ResponseBody
    public String pub(@RequestParam(value = "surveyId", required = true) int surveyId) throws Exception {
        Survey updateSurvey = new Survey();
        updateSurvey.setSurveyId(surveyId);
        updateSurvey.setSurveyStatus(1);
        surveyService.updateSurvey(updateSurvey);

        Configuration freemarkerConfig = new Configuration();
        freemarkerConfig.setEncoding(Locale.getDefault(), "utf-8");
        freemarkerConfig.setServletContextForTemplateLoading(servletContext, "WEB-INF/templates/survey/");
        Template template = freemarkerConfig.getTemplate("view.ftl");
        template.setEncoding("utf-8");

        String fileName = surveyId + ".html";
        File file = new File(servletContext.getRealPath("/resources/v/"), fileName);
        file.createNewFile();

        Survey survey = surveyService.getSurvey(surveyId);
        SurveyContent surveyContent = surveyContentService.getContent(surveyId);
        List<SurveyQuestion> surveyQuestionList = JSON.parseObject(surveyContent.getContent(), new TypeReference<List<SurveyQuestion>>() {
        });

        int page = 1;
        HashMap<String, List<SurveyQuestion>> surveyPageQuestionList = new HashMap<String, List<SurveyQuestion>>();
        List<SurveyQuestion> newSurveyQuestionList = new ArrayList<SurveyQuestion>();
        int currentSize = 0;

        if (surveyQuestionList != null) {
            int surveyQuestionListSize = surveyQuestionList.size();
            for (SurveyQuestion surveyQuestion : surveyQuestionList) {
                newSurveyQuestionList.add(surveyQuestion);
                currentSize++;
                if (surveyQuestion.getTypeId() == QuestionType.PAGE) {
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                    page++;
                }
                if (currentSize == surveyQuestionListSize) {
                    SurveyQuestion question = new SurveyQuestion();
                    question.setSurveyId(surveyQuestion.getSurveyId());
                    question.setTypeId(QuestionType.PAGE);
                    question.setContent(page + "/" + page);
                    newSurveyQuestionList.add(question);
                    surveyPageQuestionList.put(String.valueOf(page), newSurveyQuestionList);
                    newSurveyQuestionList = new ArrayList<SurveyQuestion>();
                }
            }
        }

        Map model = new HashMap();
        model.put("survey", survey);
        model.put("page", page);
        model.put("surveyId", surveyId);
        model.put("surveyPageQuestionList", surveyPageQuestionList);

        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "utf-8"));
        template.process(model, out);
        out.flush();
        out.close();

        return new Response(ResponseType.SUCCESS, "发布成功").toString();
    }

}
