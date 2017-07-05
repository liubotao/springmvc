<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/css/cssh5.css"
          media="screen and (min-width: 319px) and (max-width: 1025px)">
    <script type="application/javascript" src="/js/jquery.min.js"></script>
    <script>
        $(document).bind('mobileinit', function () {
            $.mobile.pushStateEnabled = false;
        });
    </script>
    <script type="application/javascript" src="/js/jquery.mobile.min.js"></script>
    <title>问卷调查</title>
</head>
<body style="background:#E3E8F7">
<article class="m-nav-stickytabs nav-fixed" data-block="">
    <div class="navbox js-navbox m-tbl  scroll-navbox" id="navbox">
    </div>
</article>

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
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="1"
                                     questionRequired="${question.required}">
                                    <div class="survey-show-as-html ng-binding">${question.questionId}.
                                    ${question.content}
                                    </div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">
                                    <div class="survey-question-radio ng-scope">
                                        <#list question.choice as choice>
                                            <div class="survey-question-radio-choice ng-scope"
                                                 choiceId="${choice.order}">
                                                <div class="radio-image"></div>
                                                <label class="survey-show-as-html ng-binding">${choice.content}</label>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 2)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="2"
                                     questionRequired="${question.required}">
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
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="3"
                                     questionRequired="${question.required}"
                                    <#if question.min??> min="${question.min}" </#if>
                                    <#if question.max??>  max="${question.max}"> </#if>
                                    <div class="survey-show-as-html">${question.questionId}. ${question.content}</div>
                                    <span class="must-do ng-binding"></span>
                                </div>
                                <div class="must-do ng-hide">请按要求作答</div>
                                <div class="survey-question-content ng-scope">

                                    <div class="survey-question-checkbox ng-scope">
                                        <#list question.choice as choice>
                                            <div class="survey-question-checkbox-choice ng-scope"
                                                 choiceId="${choice.order}">
                                                <div class="checkbox-image"></div>
                                                <label class="survey-show-as-html ng-binding">${choice.content}</label>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        <#elseif (question.typeId == 4)>
                            <div class="survey-question ng-scope">
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="4"
                                     questionRequired="${question.required}">
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
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="5"
                                     questionRequired="${question.required}">
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
                            <div class="survey-question ng-scope" questionId="${question.questionId}" questionType="6">
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
                                <div class="survey-question-title" questionId="${question.questionId}" questionType="9"
                                     questionRequired="${question.required}">
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
                                                <tr class="survey-question-matrix-choice" choiceId="${checkbox.order}">
                                                    <td>
                                                        <span class="survey-question-matrix-title">${checkbox.content}</span>
                                                        <div class="must-do ng-hide" style="padding-left: 40px">请按要求作答
                                                        </div>
                                                    </td>
                                                    <#list question.choice as choice>
                                                        <td>
                                                            <div class="checkbox-image"
                                                                 choiceId="${choice.order}"></div>
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
        /*判断终端*/

        function isPhone() {

            matchedREG = /iphone|android|symbianos|windows\sphone/g;

            return matchedREG.test(window.navigator.userAgent.toLocaleLowerCase());
        }

        var isPhone = isPhone();
        var e;
        if (isPhone) {
            e = 'tap';
        } else {
            e = 'click';
        }
        $('.ui-loader,.ui-btn-inner').remove();

        var setPage = {
            currentPage: 1,
            totalPage: ${page},
            prePage: function () {
                this.currentPage--;
                if (this.currentPage < 2) {
                    $('.preBtn').addClass('ng-hide');
                    this.currentPage = 1;
                } else {
                    $('.preBtn').removeClass('ng-hide');
                }
                $('.nextBtn').removeClass('ng-hide');
                $('.survey-submit-page').addClass('ng-hide');
                return this.currentPage;
            },
            nextPage: function () {
                this.currentPage++;
                if (this.currentPage > this.totalPage || this.currentPage == this.totalPage) {
                    this.currentPage = this.totalPage;
                    $('.nextBtn').addClass('ng-hide');
                    $('.survey-submit-page').removeClass('ng-hide');
                }
                $('.preBtn').removeClass('ng-hide');
                return this.currentPage;
            },
            initPage: function () {
                if (this.currentPage == this.totalPage) {
                    $('.survey-submit-page').removeClass('ng-hide');
                    $('.nextBtn').addClass('ng-hide');
                }

            }
        }
        var _html = '';
        for (var i = 0; i < setPage.totalPage; i++) {
            var tabID = i + 1;
            var tabWidth = 100 / setPage.totalPage;
            if (setPage.currentPage == tabID) {
                _html += '<span class="tab curr" data-blocks="' + tabID + '" id="tab-' + tabID + '" style="width:' + tabWidth + '%"></span>';
            } else {
                _html += '<span class="tab" data-blocks="' + tabID + '" id="tab-' + tabID + '" style="width:' + tabWidth + '%"></span>';
            }
        }
        $('#navbox').append(_html);
        $(window).scroll(function () {
            if ($(window).scrollTop() > 5) {
                $('#navbox').css({
                    'position': 'fixed',
                    'top': 0,
                    'left': 0
                })
            } else {
                $('#navbox').css({
                    'position': 'relative',
                })
            }
        })
        $(".survey-question-radio-choice").on(e, function () {
            $(this).siblings('.survey-question-radio-choice').find('.radio-image').removeClass('radio-image-check');
            $(this).find('.radio-image').addClass('radio-image-check');
            //console.log(e);
        });
        $('.survey-question-checkbox-choice,.survey-question-matrix-choice td').on(e, function () {
            $(this).find('.checkbox-image').toggleClass('checkbox-image-check');
        });
        setPage.initPage();
        $(".preBtn").on(e, function () {
            setPage.currentPage = setPage.prePage();
            $('.survey-page').hide();
            $('#page-' + setPage.currentPage).show();
            $('.tab').removeClass('curr');
            $('#tab-' + setPage.currentPage).addClass('curr');
        })
        $(".nextBtn").on(e, function () {
            loopanswer([], 0, 0);
            if (tempTotal == tempSuccess) {
                setPage.currentPage = setPage.nextPage();
                $('.survey-page').hide();
                $('#page-' + setPage.currentPage).show();
                $('.tab').removeClass('curr');
                $('#tab-' + setPage.currentPage).addClass('curr');
                //  console.log(template.answerList);
            }
        })
        var template = {
            surveyId: ${survey.surveyId},
            answerList: []
        }
        var sendSurvyAnswer = function () {
            template.surveyId = '';
        }
        $('.survey-submit-page').on(e, function () {
            /*最后一页校验并提交*/
            loopanswer([], 0, 0);
            template.answerList = [];
            if (tempTotal == tempSuccess) {
                //template.answerList = tempAnswerList;
                for (var i = 0; i < tempAnswerList.length; i++) {
                    for (var j = 0; j < tempAnswerList[i].length; j++) {
                        template.answerList.push(tempAnswerList[i][j]);
                    }
                }
                var anserDataJson = JSON.stringify(template);
                console.log(anserDataJson);
                $.ajax(
                        {
                            type: 'post',
                            dataType: 'json',
                            url: '/survey/answer',
                            contentType: 'application/json',
                            data: anserDataJson,
                            success: function (data) {
                                window.location.href = "/survey/success.html";
                            }
                        })
            }
        });
        var tempAnswerList = [], tempAnswer = [], tempSuccess, tempTotal, arrayContent = [];
        ;

        function loopanswer(piPageContent, success, total) {
            $.each($('#page-' + setPage.currentPage).children('.survey-question'), function (k, v) {
                var parentNode = $(v).children('.survey-question-content').children('div'), questionContent = '';
                var obj = {}, choice, tempChoiceArray = [];
                var isRequired = $(v).children('.survey-question-title').attr('questionrequired');
                if (parentNode.hasClass('survey-question-radio')) {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    if (isRequired == 'Y') {
                        if (parentNode.children('.survey-question-radio-choice').children('div').hasClass('radio-image-check')) {
                            $(v).children('.must-do').addClass('ng-hide');
                            success++;
                        } else {

                            $(v).children('.must-do').removeClass('ng-hide');

                        }
                        total++;
                    }
                    questionContent = $.trim(parentNode.children('.survey-question-radio-choice').children('.radio-image-check').next('label').text());
                    choice = parseInt(parentNode.children('.survey-question-radio-choice').attr('choiceId'));
                    tempChoiceArray.push(choice);
                    obj.choice = tempChoiceArray;
                    obj.content = questionContent;
                    if (questionContent != '') {
                        piPageContent.push(obj);
                    }

                } else if ($(v).children('.survey-question-title').attr('questionType') == '2') {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    if (isRequired == 'Y') {
                        if ($(v).find('select').val() != '') {
                            choice = parseInt($.trim($(v).find('select').val()));
                            $(v).children('.must-do').addClass('ng-hide');
                            success++;
                        }
                        else {
                            $(v).children('.must-do').removeClass('ng-hide');
                        }
                        total++;
                    }
                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    tempChoiceArray.push(choice);
                    obj.choice = tempChoiceArray;
                    piPageContent.push(obj);
                } else if ($(v).children('.survey-question-title').attr('questionType') == '3') {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    var min = parseInt($(v).children('.survey-question-title').attr('min'));
                    var max = parseInt($(v).children('.survey-question-title').attr('max'));
                    var len = parentNode.children('.survey-question-checkbox-choice').children('.checkbox-image-check').length;
                    if (isRequired == 'Y') {
                        if (len > 0) { //判断有没有选择
                            if (min > 0 && max > 0) {
                                if (len >= min && len <= max) {
                                    $(v).children('.must-do').addClass('ng-hide');
                                    success++;
                                }
                            } else if (min > 0) {
                                if (len >= min) {
                                    $(v).children('.must-do').addClass('ng-hide');
                                    success++;
                                }
                            } else if (max > 0) {
                                if (len <= max) {
                                    $(v).children('.must-do').addClass('ng-hide');
                                    success++;
                                }
                            } else {
                                $(v).children('.must-do').addClass('ng-hide');
                                success++;
                            }
                        } else {
                            $(v).children('.must-do').removeClass('ng-hide');
                        }
                        total++;
                    }
                    if (parentNode.children('.survey-question-checkbox-choice').children('div').hasClass('checkbox-image-check')) {
                        parentNode.children('.survey-question-checkbox-choice').children('.checkbox-image-check').each(function (k, v) {
                            choice = parseInt($(this).parent('.survey-question-checkbox-choice').attr('choiceId'));
                            if (choice != 'undefine') {
                                tempChoiceArray.push(choice);
                            }
                            obj.choice = tempChoiceArray;
                            if (k == (len - 1)) {
                                questionContent = questionContent + $.trim($(v).next('label').text());
                            } else {
                                questionContent = questionContent + $.trim($(v).next('label').text()) + ',';
                            }

                        });
                    }
                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    obj.content = questionContent;
                    piPageContent.push(obj);

                } else if ($(v).children('.survey-question-title').attr('questionType') == '4') {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    if (isRequired == 'Y') {
                        if ($(v).find('input').val() != '') {
                            questionContent = $.trim($(v).find('input').val());

                            $(v).children('.must-do').addClass('ng-hide');
                            success++;
                        } else {

                            $(v).children('.must-do').removeClass('ng-hide');

                        }
                        total++;
                    }
                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    obj.content = questionContent;
                    piPageContent.push(obj);
                } else if (parentNode.hasClass('survey-question-textarea')) {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    if (isRequired == 'Y') {
                        if (parentNode.children('textarea').val() != '') {
                            questionContent = $.trim(parentNode.children('textarea').val());

                            $(v).children('.must-do').addClass('ng-hide');
                            success++;
                        }
                        else {
                            $(v).children('.must-do').removeClass('ng-hide');
                        }
                        total++;
                    }


                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    obj.content = questionContent;
                    piPageContent.push(obj);
                } else if ($(v).children('.survey-question-title').attr('questionType') == '9') {
                    obj.questionId = parseInt($(v).children('.survey-question-title').attr('questionId'));
                    var tempChoiceList = [];
                    $(v).find('.survey-question-matrix-choice').each(function (k, o) {
                        var tempChoice = {}, row, col,
                                row = parseInt($(this).attr('choiceId'));
                        $(this).find('.checkbox-image').each(function () {
                            if ($(this).hasClass('checkbox-image-check')) {
                                col = parseInt($(this).attr('choiceId'));
                                tempChoice = {rows: row, cols: col}
                                tempChoiceList.push(tempChoice);
                            }
                            arrayContent = tempChoiceList;
                        })
                        if (isRequired == 'Y') {
                            if (tempChoiceList.length > 0) {
                                $(o).find('.must-do').addClass('ng-hide');
                                success++;
                            }
                            else {

                                $(o).find('.must-do').removeClass('ng-hide');

                            }
                            total++;
                        }


                    });
                    obj.content = questionContent;
                    obj.questionType = parseInt($(v).children('.survey-question-title').attr('questionType'));
                    obj.arrayContent = [];
                    obj.arrayContent = arrayContent;
                    piPageContent.push(obj);
                }

            })
            tempSuccess = success;
            tempTotal = total;
            if (success == total) {
                tempAnswer = piPageContent;
                var j = setPage.currentPage - 1;
                tempAnswerList[j] = tempAnswer;
                console.log(tempAnswerList);
            }
        }
    })
</script>
</body>
</html>