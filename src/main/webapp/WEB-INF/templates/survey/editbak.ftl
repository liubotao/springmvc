<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="/css/dialog.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
    <!--<script type="application/javascript" src="/js/jquery-ui.min.js"></script>-->
    <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
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
                            <li class="module ui-draggable" name="radio" style="background-position: 0px 0px;">单选题</li>
                            <li class="module ui-draggable" name="select" style="background-position: 0px -36px;">
                                下拉选择题
                            </li>
                            <li class="module ui-draggable" name="checkbox" style="background-position: 0px -72px;">
                                多选题
                            </li>
                            <li class="module ui-draggable" name="input" style="background-position: 0px -108px;">
                                单行填空题
                            </li>
                            <li class="module ui-draggable" name="multi-input" style="background-position: 0px -144px;">
                                多行填空题
                            </li>
                            <li class="module ui-draggable" name="desc" style="background-position: 0px -218px;">描述说明
                            </li>
                            <li class="module ui-draggable" name="page" style="background-position: 0px -325px;">分页符
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
                <div id="question-box" class="ui-sortable">
                    <#list surveyQuestionList as question>
                        <#if (question.typeId == 1)>
                            <div class="topic-type-content topic-type-question after-clear">
                                <div class="question-title" type="1" name="radio-question"><span
                                        class="required">*</span><span
                                        class="question-id" order="38" page="1" index="38" absolute_id="41"
                                        question-required="Y" has_other="N" questionId="${question.questionId}"
                                        ng-hide="${question.hidden}">{{Qid}}</span>
                                    <div class="position-relative">
                                        <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                             content-default="1">${question.content}
                                        </div>
                                    </div>
                                </div>
                                <ul class="question-choice">
                                    <#list question.choice as choice>
                                        <li class="choice" has_other="N" choice_absolute_id="1"><input type="radio"
                                                                                                       name="radio">
                                            <div class="position-relative">
                                                <div class="edit-area edit-child-element" contenteditable="true"
                                                     content-default="1">${choice.content}
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
                                        <!--<li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>-->
                                        <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                                    </ul>
                                </div>
                            </div>
                        <#elseif (question.typeId == 2)>
                            <div class="topic-type-content topic-type-question after-clear">
                                <div class="question-title" type="2" name="radio-question"><span
                                        class="required">*</span><span
                                        class="question-id" order="1" page="1" index="1" absolute_id="1"
                                        question-required="Y"
                                        has_other="N" questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                                    <div class="position-relative">
                                        <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                             style="border: none rgb(255, 255, 255); background: white;"
                                             data-value="选择列表">
                                        ${question.content}
                                        </div>
                                    </div>
                                </div>
                                <select class="question-choice" style="  padding: 0;margin: 15px 0 20px 35px;">
                                    <#list question.choice as choice>
                                        <option class="choice" has_other="N"
                                                choice_absolute_id="1">${choice.content}</option>
                                    </#list>
                                </select><span class="edit-select"
                                               style="  width: 60%;display: inline-block;line-height: 30px;"
                                               onclick="edit.editSelect(this)">编辑选项</span>
                                <div class="operate visible-hide fl-right">
                                    <ul>
                                        <li class="drag-area" title="移动"></li>
                                        <li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li>
                                        <!--<li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>-->
                                        <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                                    </ul>
                                </div>
                            </div>
                        <#elseif (question.typeId == 3)>
                            <div class="topic-type-content topic-type-question after-clear">
                                <div class="question-title" type="3" name="checkbox-question"><span
                                        class="required">*</span><span class="question-id" order="2" page="1" index="2"
                                                                       question-required="Y" has_other="N" min=""
                                                                       max="" questionId="${question.questionId}"
                                                                       ng-hide="${question.hidden}">{{Qid}}</span>
                                    <div class="position-relative">
                                        <div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true"
                                             content-default="1"
                                             style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}
                                        </div>
                                    </div>
                                </div>
                                <ul class="question-choice">
                                    <#list question.choice as choice>
                                        <li class="choice" has_other="N" choice_absolute_id="1"><input type="checkbox"
                                                                                                       name="checkbox">
                                            <div class="position-relative">
                                                <div class="edit-area edit-child-element" contenteditable="true"
                                                     content-default="1"
                                                     style="border-color: rgb(255, 255, 255); background: white;">${choice.content}
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
                                        <!--<li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>-->
                                        <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                                    </ul>
                                </div>
                            </div>
                        <#elseif (question.typeId == 4)>
                            <div class="topic-type-content topic-type-question after-clear">
                                <div class="question-title" type="4" name="input-question"><span
                                        class="required">*</span><span
                                        class="question-id" order="3" page="1" index="3" question-required="Y"
                                        has_other="N" questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                                    <div class="position-relative">
                                        <div class="qs-content edit-area edit-title" contenteditable="true"
                                             content-default="1"
                                             style="border-color: rgb(255, 255, 255); background: white;">${question.content}
                                        </div>
                                    </div>
                                </div>
                                <ul class="question-choice">
                                    <li><input type="text" name="input" class="input-single"></li>
                                </ul>
                                <div class="operate fl-right visible-hide">
                                    <ul>
                                        <!--<li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>-->
                                        <li class="drag-area" title="移动"></li>
                                        <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                                    </ul>
                                </div>
                            </div>
                        <#elseif (question.typeId == 5)>
                            <div class="topic-type-content topic-type-question after-clear">
                                <div class="question-title" type="5" name="multi-input-question"><span class="required">*</span><span
                                        class="question-id" order="5" page="1" index="5" question-required="Y"
                                        has_other="N" questionId="${question.questionId}" ng-hide="${question.hidden}">{{Qid}}</span>
                                    <div class="position-relative">
                                        <div class="qs-content edit-area edit-title" contenteditable="true"
                                             content-default="1"
                                             style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}
                                        </div>
                                    </div>
                                </div>
                                <ul class="question-choice">
                                    <li class="auto-height"><textarea name="multi-input" class="multi-input"></textarea>
                                    </li>
                                </ul>
                                <div class="operate fl-right visible-hide">
                                    <ul>
                                        <!--<li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li>-->
                                        <li class="drag-area" title="移动"></li>
                                        <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li>
                                    </ul>
                                </div>
                            </div>
                        <#elseif (question.typeId == 6)>
                            <div class="topic-type-content decs-type-content after-clear">
                                <div class="question-title" type="6" name="description"><span class="question-id"
                                                                                              order="6"
                                                                                              page="1" index="6"
                                                                                              question-required="N"
                                                                                              has_other="N"></span>
                                    <div class="position-relative">
                                        <div class="qs-content qs-high-content edit-area edit-title"
                                             contenteditable="true"
                                             content-default="1"
                                             style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">${question.content}
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
                                     question-required="Y"
                                     has_other="N" style="padding: 0px;height: 36px;"><span class="question-id"
                                                                                            order="50"
                                                                                            page="6"
                                                                                            style="margin: 0px;"
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
        <div class="survey-confirm-content"><img src="/images/warning_icon.png"
                                                 style="vertical-align: middle;">
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
                            <li class="condition_element condition-active" absolute_id="53" choice_absolute_id="1"
                                title="选项1 ">选项1
                            </li>
                            <li class="condition_element" absolute_id="53" choice_absolute_id="2" title="选项2 ">选项2</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div style="float:left;width:230px;padding-left:20px"><span
                    class="logic-area-condition-title">则显示以下题目</span>
                <div class="logic-area-question">
                    <div class="logic-questions">
                        <ul>
                            <li class="logic-show-question" absolute_id="58" title="Q2单选题 "><label><input
                                    type="checkbox" class="logic-show-checkbox logic-show-checkbox-58"><span
                                    class="logic_show_question_index">Q2</span>单选题 </label></li>
                            <li class="logic-show-question" absolute_id="57" title="Q3单选题"><label><input type="checkbox"
                                                                                                         class="logic-show-checkbox logic-show-checkbox-57"><span
                                    class="logic_show_question_index">Q3</span>单选题</label></li>
                            <li class="logic-show-question" absolute_id="54" title="Q4选择列表"><label><input
                                    type="checkbox" class="logic-show-checkbox logic-show-checkbox-54"><span
                                    class="logic_show_question_index">Q4</span>选择列表</label></li>
                            <li class="logic-show-question" absolute_id="55" title="Q5多选题 "><label><input
                                    type="checkbox" class="logic-show-checkbox logic-show-checkbox-55"><span
                                    class="logic_show_question_index">Q5</span>多选题 </label></li>
                            <li class="logic-show-question" absolute_id="56" title="Q6您的性别"><label><input
                                    type="checkbox" class="logic-show-checkbox logic-show-checkbox-56"><span
                                    class="logic_show_question_index">Q6</span>您的性别</label></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    var logic = ${logic};
</script>
<script type="application/javascript" src="/js/edit.js?xxxx"></script>
<script>

    var pageCount = ${page};
    initPage(pageCount);
    function previewSurvey() {
        var surveyId = getUrlParameter("surveyId");
        window.open("/survey/previewSurvey?surveyId=" + surveyId);
    }

    var isFirefox = /firefox/.test(navigator.userAgent.toLowerCase());
    $(function () {
        /*$(".drag-area").mousedown(function() {
            $( ".ui-sortable" ).sortable();
            $( ".ui-sortable" ).disableSelection();
        })*/

        //$(".ui-sortable").sortable();
        //$(".ui-sortable" ).disableSelection();

        $("#question-box").sortable({
            connectWith: "#question-box",
            handle: ".drag-area",
            start: function (e, t) {
                $("#question-box").sortable({
                    stop: function () {
                        // edit.sortQuestions(), edit.updateChoiceShowLogic(), edit.updateByChoiceQuote(), edit.saveSurvey()
                    }
                })
            }
        })

        $(".topic-type-content").disableSelection();
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