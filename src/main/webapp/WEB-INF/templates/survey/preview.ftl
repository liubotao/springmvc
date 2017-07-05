<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
    <title>问卷调查</title>
</head>
<body style="background:#E3E8F7">
<div class="survey-self-wrap">
    <div class="survey-theme-blue">
        <a class="survey-paper-clip"></a>
        <div class="survey-wrap">
            <div class="survey-title ng-binding" style="border-width:0">${survey.surveyName}</div>
            <div class="survey-desciption mt20">
                <div ng-bind-html="trustAsHtml(project.test_content)" class="ng-binding">
                ${survey.surveyTitle}
                </div>
            </div>
        </div>

        <div class="survey-question-wrap">
        <#if surveyPageQuestionList??>
            <#list surveyPageQuestionList?keys as key>
                <#assign surveyQuestionList = surveyPageQuestionList[key]>
                <div class="survey-page <#if key!="1">hidden</#if>" id="page-${key}">
                    <#list surveyQuestionList as question>
                        <#if (question.typeId == 1)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html ng-binding">${question.questionId}.
                                    ${question.content}
                                    </div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">
                                    <div class="survey-question-radio ng-scope">
                                        <#list question.choice as choice>
                                            <div class="survey-question-radio-choice ng-scope">
                                                <div class="radio-image"></div>
                                                <label class="survey-show-as-html ng-binding">${choice.content}</label>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 2)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html ng-binding">${question.questionId}.
                                    ${question.content}
                                    </div>
                                    <span class="must-do ng-binding" ng-bind="question.tip"></span>
                                </div>
                                <div class="must-do ng-hide" ng-show="question.passed==false">请按要求作答</div>
                                <div class="survey-question-content ng-scope">
                                    <div class="survey-question-select ng-scope">
                                        <select style="width: 200px"
                                                class="ng-valid ng-dirty ng-valid-parse ng-touched">
                                            <#list question.choice as choice>
                                                <option value="${choice.order}"
                                                        label="${choice.content}">${choice.content}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId ==3)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html">${question.questionId}. ${question.content}</div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">

                                    <div class="survey-question-checkbox ng-scope">
                                        <#list question.choice as choice>
                                            <div class="survey-question-checkbox-choice ng-scope">
                                                <div class="checkbox-image"></div>
                                                <label class="survey-show-as-html ng-binding">${choice.content}</label>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 4)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html ng-binding">${question.questionId}
                                        . ${question.content}</div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">
                                    <div class="survey-question-text ng-scope">
                                        <input type="text">
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 5)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html ng-binding">${question.questionId}
                                        . ${question.content}</div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">
                                    <div class="survey-question-textarea ng-scope">
                                        <textarea class="ng-pristine ng-untouched ng-valid"></textarea>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 6)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title survey-question-paragraph-title">
                                    <div class="survey-show-as-html ng-binding">${question.content}</div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                            </div>
                        <#elseif (question.typeId == 7)>
                            <div class="survey-page-bottom">
                                <div class="ng-scope">
                                    <div class="survey-last-page preBtn ng-hide">上一页</div>
                                    <div class="survey-timer ng-hide"><span class="ng-binding">0</span>s</div>
                                    <div class="survey-next-page nextBtn">下一页</div>
                                    <div class="survey-submit-page ng-hide">提交</div>
                                    <div class="survey-page-index">${question.content}页
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 9)>
                            <div class="survey-question" id=" ">
                                <div class="survey-question-title">
                                    <div class="survey-show-as-html">${question.questionId}. ${question.content}</div>
                                    <span class="must-do"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content">
                                    <div class="survey-question-matrix">
                                        <table style="font-size: 14px; width: 100%;">
                                            <tbody>
                                            <tr>
                                                <td></td>
                                                <#list question.choice as choice>
                                                    <td>${choice.content}</td>
                                                </#list>
                                            </tr>
                                                <#list question.checkboxArrayTitle as checkbox>
                                                <tr class="survey-question-matrix-choice">
                                                    <td>
                                                        <span class="survey-question-matrix-title">${checkbox.content}</span>
                                                        <div class="must-do ng-hide" style="padding-left: 40px">请按要求作答
                                                        </div>
                                                    </td>
                                                    <#list question.choice as choice>
                                                        <td>
                                                            <div class="checkbox-image"></div>
                                                            <div class="checkTitle"></div>
                                                        </td>
                                                    </#list>
                                                </tr>
                                                </#list>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </#list>
                </div>
            </#list>
        </#if>
        </div>
    </div>
</div>
<script>
    $(function () {
        $(".survey-question-radio-choice").click(function () {
            $(this).siblings('.survey-question-radio-choice').find('.radio-image').removeClass('radio-image-check');
            $(this).find('.radio-image').addClass('radio-image-check');
        });

        $('.survey-question-checkbox-choice,.survey-question-matrix td').click(function () {
            $(this).find('.checkbox-image').toggleClass('checkbox-image-check');
        });
        var currentPage = 1, totalPage = ${page};

        function prePage() {
            currentPage--;
            if (currentPage < 2) {
                $('.preBtn').addClass('ng-hide');
                currentPage = 1;
            } else {
                $('.preBtn').removeClass('ng-hide');
            }
            $('.nextBtn').removeClass('ng-hide');
            return currentPage;

        }

        function nextPage() {
            currentPage++;
            if (currentPage > totalPage || currentPage == totalPage) {
                currentPage = totalPage;
                $('.nextBtn').addClass('ng-hide');
            }
            $('.preBtn').removeClass('ng-hide');
            return currentPage;
        }

        $(".preBtn").click(function () {
            currentPage = prePage();
            $('.survey-page').hide();
            $('#page-' + currentPage).show();
        })
        $(".nextBtn").click(function () {
            currentPage = nextPage();
            $('.survey-page').hide();
            $('#page-' + currentPage).show();
        })

    })
</script>
</body>
</html>