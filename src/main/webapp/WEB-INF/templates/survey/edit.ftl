<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css?111" rel="stylesheet" type="text/css"/>
    <link href="/css/dialog.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery.min.js"></script>
    <script type="application/javascript" src="/js/jquery-ui.min.js"></script>
    <script type="application/javascript" src="/js/layer/layer.js"></script>
    <title>问卷调查</title>
</head>
<body>
<div class="container-wrap">
    <div class="container-content">
        <div class="navigation after-clear">
            <input type="button" class="common-button fl-right" value="预览问卷" onclick="previewSurvey()">
        </div>
        <div class="center-content">
            <div class="col1">
                <div class="sur-sidebar">
                    <div class="select-question">
                        <div class="classify-title select-question-title">题型选择</div>
                        <ul>
                            <li class="module ui-draggable" name="radio" style="background-position: 0px -4px;">单选题</li>
                            <li class="module ui-draggable" name="select" style="background-position: 0px -40px;">
                                下拉选择题
                            </li>
                            <li class="module ui-draggable" name="checkbox" style="background-position: 0px -76px;">
                                多选题
                            </li>
                            <li class="module ui-draggable" name="input" style="background-position: 0px -112px;">
                                单行填空题
                            </li>
                            <li class="module ui-draggable" name="multi-input" style="background-position: 0px -148px;">
                                多行填空题
                            </li>
                            <!--<li class="module ui-draggable" name="radio-matrix" style="background-position: 0px -184px;">矩阵单选题</li>-->
                            <li class="module ui-draggable" name="checkbox-matrix"
                                style="background-position: 0px -368px;">矩阵多选题
                            </li>
                            <li class="module ui-draggable" name="desc" style="background-position: 0px -222px;">描述说明
                            </li>
                            <li class="module ui-draggable" name="page" style="background-position: 0px -329px;">分页符
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        <div class="col2">
            <div class="survey-title">
                <div class="title-content edit-area" contenteditable="true" tabindex="1">
                ${survey.surveyName}
                </div>
                <div class="error-tips error"></div>
            </div>
            <div class="survey-desc">
                <div class="position-relative" style="width:100%">
                    <div class="desc-content edit-area" contenteditable="true"
                         style="border: none; background: rgb(255, 255, 255);">
                    ${survey.surveyTitle}
                    </div>
                    <div class="error-tips"></div>
                </div>
            </div>
        <#if surveyQuestionList?has_content>
        <div id="question-box" class="ui-sortable" style="position: relative">
            <#list surveyQuestionList as question>
                <#if (question.typeId == 1)>
                    <div class="topic-type-content topic-type-question after-clear">
                        <div class="question-title" type="1" name="radio-question">
                            <#if  (question.required == "Y") >
                                <span class="required">*</span>
                            </#if><span
                                class="question-id" order="38" page="1" index="38" absolute_id="41"
                                question-required="${question.required}" has_other="N"
                                questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                            <div class="position-relative">
                                <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                     content-default="1">${question.content}<#if (question.commit?length gt 0)>
                                    &&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <ul class="question-choice">
                            <#list question.choice as choice>
                                <li class="choice" has_other="N" choice_absolute_id="${choice.choiceAbsoluteId}"><input
                                        type="radio"
                                        name="radio">
                                    <div class="position-relative">
                                        <div class="edit-area edit-child-element" contenteditable="true"
                                             content-default="1">${choice.content}<#if (choice.commit?length gt 0)>
                                            &&${choice.commit}&&</#if>
                                        </div>
                                    </div>
                                </li>
                            </#list>
                        </ul>
                        <div class="add-area visible-hide">
                            <ul>
                                <li class="add-choice" title="增加" onclick="edit.addQuestion(this)"></li>
                            </ul>
                        </div>
                        <div class="operate visible-hide fl-right">
                            <ul>
                                <li class="drag-area" title="移动"></li>
                                <li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li>
                                <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 2)>
                    <div class="topic-type-content topic-type-question after-clear">
                        <div class="question-title" type="2" name="radio-question">
                            <#if  (question.required == "Y") >
                                <span class="required">*</span>
                            </#if>
                            <span class="question-id" order="1" page="1" index="1" absolute_id="1"
                                  question-required="${question.required}"
                                  has_other="N" questionId="${question.questionId}"
                                  ng-hide="${question.hidden}">{{Qid}}</span>
                            <div class="position-relative">
                                <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                     style="border: none rgb(255, 255, 255); background: white;" data-value="选择列表">
                                ${question.content}<#if (question.commit?length gt 0)>&&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <select class="question-choice" style="  padding: 0;margin: 15px 0 20px 35px;">
                            <#list question.choice as choice>
                                <option class="choice" has_other="N"
                                        choice_absolute_id="${choice.choiceAbsoluteId}">${choice.content}<#if (choice.commit?length gt 0)>
                                    &&${choice.commit}&&</#if></option>
                            </#list>
                        </select><span class="edit-select"
                                       style="  width: 60%;display: inline-block;line-height: 30px;"
                                       onclick="edit.editSelect(this)">编辑选项</span>
                        <div class="operate visible-hide fl-right">
                            <ul>
                                <li class="drag-area" title="移动"></li>
                                <li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li>
                                <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 3)>
                    <div class="topic-type-content topic-type-question after-clear">
                        <div class="question-title" type="3" name="checkbox-question">
                            <#if  (question.required == "Y") >
                                <span class="required">*</span>
                            </#if>
                            <span class="question-id" order="2" page="1" index="2"
                                  question-required="${question.required}" has_other="N" min="${question.min}"
                                  max="${question.max}" questionId="${question.questionId}"
                                  ng-hide="${question.hidden}">{{Qid}}</span>
                            <div class="position-relative">
                                <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                     content-default="1"
                                     style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}<#if (question.commit?length gt 0)>
                                    &&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <ul class="question-choice">
                            <#list question.choice as choice>
                                <li class="choice" has_other="N" choice_absolute_id="${choice.choiceAbsoluteId}"><input
                                        type="checkbox"
                                        name="checkbox">
                                    <div class="position-relative">
                                        <div class="edit-area edit-child-element" contenteditable="true"
                                             content-default="1"
                                             style="border-color: rgb(255, 255, 255); background: white;">${choice.content}<#if (choice.commit?length gt 0)>
                                            &&${choice.commit}&&</#if>
                                        </div>
                                    </div>
                                </li>
                            </#list>
                        </ul>
                        <div class="add-area visible-hide">
                            <ul>
                                <li class="add-choice" title="增加" onclick="edit.addQuestion(this)"></li>
                            </ul>
                        </div>
                        <div class="operate fl-right visible-hide">
                            <ul>
                                <li class="drag-area" title="移动"></li>
                                <li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li>
                                <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 4)>
                    <div class="topic-type-content topic-type-question after-clear">
                        <div class="question-title" type="4" name="input-question">
                            <#if  (question.required == "Y") >
                                <span class="required">*</span>
                            </#if>
                            <span
                                    class="question-id" order="3" page="1" index="3"
                                    question-required="${question.required}"
                                    has_other="N" questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                            <div class="position-relative">
                                <div class="qs-content edit-area edit-title" contenteditable="true" content-default="1"
                                     style="border-color: rgb(255, 255, 255); background: white;">${question.content}<#if (question.commit?length gt 0)>
                                    &&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <ul class="question-choice">
                            <li><input type="text" name="input" class="input-single"></li>
                        </ul>
                        <div class="operate fl-right visible-hide">
                            <ul>
                                <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                                <li class="drag-area" title="移动"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 5)>
                    <div class="topic-type-content topic-type-question after-clear">
                        <div class="question-title" type="5" name="multi-input-question">
                            <#if  (question.required == "Y") >
                                <span class="required">*</span>
                            </#if>
                            <span
                                    class="question-id" order="5" page="1" index="5"
                                    question-required="${question.required}"
                                    has_other="N" questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                            <div class="position-relative">
                                <div class="qs-content edit-area edit-title" contenteditable="true" content-default="1"
                                     style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}<#if (question.commit?length gt 0)>
                                    &&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <ul class="question-choice">
                            <li class="auto-height"><textarea name="multi-input" class="multi-input"></textarea></li>
                        </ul>
                        <div class="operate fl-right visible-hide">
                            <ul>
                                <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                                <li class="drag-area" title="移动"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 6)>
                    <div class="topic-type-content decs-type-content after-clear">
                        <div class="question-title" type="6" name="description"><span class="question-id" order="6"
                                                                                      page="1" index="6"
                                                                                      question-required="${question.required}"
                                                                                      has_other="N"></span>
                            <div class="position-relative">
                                <div class="qs-content qs-high-content edit-area edit-title" contenteditable="true"
                                     content-default="1"
                                     style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}<#if (question.commit?length gt 0)>
                                    &&${question.commit}&&</#if>
                                </div>
                            </div>
                        </div>
                        <div class="operate visible-hide fl-right">
                            <ul>
                                <li class="drag-area" title="移动"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 7)>
                    <div class="topic-type-content topic-page after-clear">
                        <div class="question-title" type="7" order="7" name="page" index="7"
                             question-required="${question.required}"
                             has_other="N" style="padding: 0px;height: 36px;"><span class="question-id" order="50"
                                                                                    page="6" style="margin: 0px;"
                                                                                    index="0"></span>
                            <div class="page-area">页码:${question.content}</div>
                        </div>
                        <div class="operate visible-hide fl-right">
                            <ul>
                                <li class="drag-area" title="移动"></li>
                                <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                            </ul>
                        </div>
                    </div>
                <#elseif (question.typeId == 9)>
                <div class="topic-type-content topic-type-question after-clear">
                    <div class="question-title" type="9" name="checkbox-matrix-question"><span
                            class="required">*</span><span class="question-id" order="14" page="2" index="14"
                                                           question-required="Y" has_other="N" questionid="12"
                                                           ng-hide="0">{{Qid}}</span>
                        <div class="position-relative">
                            <div class="qs-content edit-area edit-title" contenteditable="true" content-default="1"
                                 style="border: none rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}<#if (question.commit?length gt 0)>
                                &&${question.commit}&&</#if>
                            </div>
                        </div>
                    </div>
                <ul class="question-choice" style="width: 700px;">
                <li class="auto-height">
                <table style="border-collapse: collapse;">
                <tbody>
                <tr>
                    <td>&nbsp;</td>
                    <#list question.choice as choice>
                        <td name="checkbox-matrix-choice">
                            <div class="position-relative" style="width:100%">
                        <li class="choice edit-area matrix-choice" has_other="N" contenteditable="true"
                            content-default="1"
                            style="border: none rgb(255, 255, 255); background: white;">${choice.content}<#if (choice.commit?length gt 0)>
                            &&${choice.commit}&&</#if>
                        </li>
                    </div>
                        </td>
                    </#list>
                    </tr>
                    <#list question.checkboxArrayTitle as checkbox>
                        <tr>
                            <td class="checkbox_array_title" name="checkbox-matrix">
                                <div class="position-relative" style="width:100%">
                                    <div class="edit-area edit-child-element" contenteditable="true" content-default="1"
                                         style="border: none rgb(255, 255, 255); background: white;">${checkbox.content}
                                    </div>
                                </div>
                            </td>
                            <#list question.choice as choice>
                                <td><input type="checkbox">
                                    <#if checkbox.commit?has_content>
                                        <#assign index = choice.order-1 >
                                        <div class="edit-area edit-child-element tdArea" contenteditable="true"
                                             content-default="1"
                                             style="background: rgb(255, 255, 255);"> <#if checkbox.commit[index]??>${checkbox.commit[index]}</#if></div>
                                    </#if>
                                </td>
                            </#list>
                        </tr>
                    </#list>
                    </tbody></table></li></ul>
                    <div class="add-area abs-position visible-hide" choice="Y">
                        <ul>
                            <li class="add-choice" onclick="edit.addQuestion(this)"></li>
                        </ul>
                    </div>
                    <div class="add-area visible-hide" choice="N">
                        <ul>
                            <li class="add-choice" onclick="edit.addQuestion(this)"></li>
                        </ul>
                    </div>
                    <div class="operate fl-right visible-hide">
                        <ul>
                            <li class="drag-area" title="移动"></li>
                            <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>
                            <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                        </ul>
                    </div></div>
                </#if>
            </#list>
        </div>
        <#else>
            <div id="question-box" class="ui-sortable">
                <div class="question-box-init">点击左侧题型，以添加题目到此空白区域</div>
            </div>
        </#if>

            <div id="survey-tail">
                <ul>
                    <li>
                        <div id="page-tail">页码:${page} / ${page}</div>
                    </li>
                    <li>
                        <div id="survey-op" class="after-clear">
                            <div class="preview-survey dib">
                                <input type="button" class="common-button survey-button preview-survey" value="预览问卷"
                                       onclick="previewSurvey()" style="width:108px;height:38px">
                            </div>
                            <div class="larger-outstanding-button op-next dib">发布</div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>

<div class="operate-popup" style="display:none" id="operate-popup">
    <div class="survey-confirm">
        <div class="survey-confirm-content"><img src="/images/warning_icon.png" style="vertical-align: middle;">
            <div class="survey-content-text">您确认删除此题卡吗？</div>
        </div>
    </div>
</div>

<!--逻辑弹窗内容-->
<div class="logic-popup" style="display:none">
    <div class="logic-area">
        <div class="logic-area-content">
            <div style="width:165px;margin-right:5px;float:left;"><span
                    class="logic-area-condition-title">当前用户选择本题选项</span>
                <div class="logic-area-condition">
                    <div class="condition-area">
                        <ul>
                        </ul>
                    </div>
                </div>
            </div>
            <div style="float:left;width:230px;padding-left:20px"><span
                    class="logic-area-condition-title">则显示以下题目</span>
                <div class="logic-area-question">
                    <div class="logic-questions">
                        <ul>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--题目设置-->
<div class="handle-dialog" style="display:none" id="handle-dialog"></div>


</body>

<script>
    var logic = ${logic};
</script>
<script type="application/javascript" src="/js/edit.js?1234533"></script>
<script type="application/javascript" src="/js/question_handle.js"></script>
<script>

    var pageCount = ${page};
    initPage(pageCount);
    function previewSurvey() {
        var surveyId = getUrlParameter("surveyId");
        window.open("/survey/previewSurvey?surveyId=" + surveyId);
    }

    $(function () {
        $("#question-box").sortable({
            connectWith: "#question-box",
            handle: ".drag-area",
            stop: function (e, t) {
                edit.sortQuestions()
                sendsurvey();
            }
        })

        $(".op-next").click(function () {
            $.ajax(
                    {
                        type: 'get',
                        url: '/survey/pub',
                        data: {surveyId: ${survey.surveyId}},
                        success: function (data) {
                            window.location.href = "/";
                        }
                    })
        })
    });
</script>


</html>