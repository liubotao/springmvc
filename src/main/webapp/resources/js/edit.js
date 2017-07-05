var config = {
    page: 1,
    surveyId: 2,
    getQid: function () {
        return $('.topic-type-question').length + 1;
    },
    setQid: function () {
        $('.topic-type-question').each(function (k) {
            $(this).find('.question-id').text('Q' + (k + 1));
            $(this).find('.question-id').attr('questionId', (k + 1));
        })
    }
}
function getLogicList(logic, questionId) {
    for (var i in logic) {
        if (parseInt(logic[i].questionId) == parseInt(questionId)) {
            return logic[i];
        }
    }
    return {'questionId': '', 'areaQuestion': []};
}
function initPage(pageCount) {
    config.page = pageCount;
}
config.setQid();
var template = {}, survey_init = [];
var initdata = function () {
    $('.topic-type-content').each(function (k, v) {
        template_init();
        var _this = $(v);
        template.surveyId = parseInt(survey_id);
        template.order = parseInt(k + 1);
        template.questionId = parseInt(_this.find('.question-id').attr('questionId'));
        template.hidden = parseInt(_this.find('.question-id').attr('ng-hide'));
        template.contentWithCommit = $.trim(_this.find('.qs-content').text()) || $.trim(_this.find('.page-area').text().split(':')[1]);
        template.typeId = parseInt(_this.find('.question-title').attr('type'));
        template.hasOther = _this.find('.question-id').attr('has_other');
        template.required = _this.find('.question-id').attr('question-required');
        var contentWithCommitMatchers = template.contentWithCommit.match('(.*)\\&&(.*)\\&&');
        if (!contentWithCommitMatchers) {
            template.content = template.contentWithCommit;
        } else {
            template.content = contentWithCommitMatchers[1];
            template.commit = contentWithCommitMatchers[2];
        }
        if (template.typeId == 3) {
            template.min = parseInt(_this.find('.question-id').attr('min'));
            template.max = parseInt(_this.find('.question-id').attr('max'));
        } else {
            template.min = 0;
            template.max = 0;
        }


        _this.find('.question-choice').find(".choice").each(function (k, v) {
            var obj = {'order': '', 'choiceAbsoluteId': '', 'content': '', 'is_other': ''};
            obj.order = k + 1;
            obj.choiceAbsoluteId = k + 1;
            obj.contentWithCommit = $.trim($(this).find('.edit-child-element').text() || $(this).text());
            obj.is_other = $(this).attr('has_other');
            var contentWithCommitMatchers = obj.contentWithCommit.match('(.*)\\&&(.*)\\&&');
            if (!contentWithCommitMatchers) {
                obj.content = obj.contentWithCommit;
            } else {
                obj.content = contentWithCommitMatchers[1];
                obj.commit = contentWithCommitMatchers[2];
            }
            template.choice.push(obj);
        });
        $.each(_this.find('.checkbox_array_title'), function (k, v) {
            var obj = {"order": '', 'content': '', 'commit': []};
            obj.order = k + 1;
            obj.content = $.trim($(v).find('.edit-child-element').text() || $(this).text());
            var iptValue = [];
            $.each($(v).siblings('td'), function () {
                iptValue.push($.trim($(this).find('.edit-area').text()) == '' ? null : $.trim($(this).find('.edit-area').text()));
            });
            obj.commit = iptValue;
            template.checkboxArrayTitle.push(obj);
        });

        survey_init.push(template);
    });
}
initdata();
$(document).delegate('.edit-area', 'mouseover', function (e) {
    e = e || window.event;
    e.stopPropagation();
    if ($(e.target).attr('contenteditable') == 'true') {
        $(e.target).css({'background': '#fdf9cd'});
    }
})
$(document).delegate('.edit-area', 'mouseout', function (e) {
    if ($(this).attr('contenteditable') == 'true') {
        $(this).css({'background': '#fff'});
    }
});
var editareaContent;
$(document).delegate('.edit-area', 'click', function (e) {
    if ($(this).attr('contenteditable') == 'true') {
        e = e || window.event;
        e.stopPropagation();
        $('.edit-area').removeClass('edit-area-hov');
        $('.edit-area').removeClass('edit-title-hov');
        editareaContent = $(this).html();
        if ($(this).parent('div').hasClass('survey-title')) {
            $(this).addClass('edit-title-hov');
        } else {
            $(this).addClass('edit-area-hov');
        }
    }
})
$(document).delegate('.edit-area', 'blur', function (e) {
    if (editareaContent != $(this).html()) {
        sendsurvey();
    }
})
$(document).on('click', function (e) {
    $('.edit-area').css({'background': 'white',});
})
Qid = config.getQid();
$(document).delegate('.module', 'click', function () {
    Qid = config.getQid();
    //console.log($('#question-box').find('div').hasClass('question-box-init'));
    if ($('#question-box > div').hasClass('question-box-init')) {
        $('#question-box').html("");
    }
    switch ($(this).attr('name')) {
        case 'radio':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="1" name="radio-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" title="" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true" content-default="1">单选题</div></div></div><ul class="question-choice"><li class="choice" has_other="N" choice_absolute_id="1"><input type="radio" name="radio"><div class="position-relative"><div class="edit-area edit-child-element" contenteditable="true" content-default="1">选项1 </div></div></li><li class="choice" has_other="N" choice_absolute_id="2"><input type="radio" name="radio"><div class="position-relative"><div class="edit-area edit-child-element" contenteditable="true" content-default="1">选项2 </div><div></div></div></li></ul><div class="add-area visible-hide"><ul><li class="add-choice" title="增加" onclick="edit.addQuestion(this)"></li></ul></div><div class="operate visible-hide fl-right"><ul><li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'select':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="2" name="radio-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '"  question-required="Y" has_other="N" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true" style="border: none rgb(255, 255, 255); background: white;" data-value="选择列表">选择列表</div></div></div><select class="question-choice" style="  padding: 0;margin: 15px 0 20px 35px;"><option class="choice" has_other="N" choice_absolute_id="1">选项1</option><option class="choice" has_other="N" choice_absolute_id="2">选项2</option><option class="choice" has_other="N" choice_absolute_id="3">选项3</option></select><span class="edit-select" style="  width: 60%;display: inline-block;line-height: 30px;" onclick="edit.editSelect(this)">编辑选项</span><div class="operate visible-hide fl-right"><ul><li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'checkbox':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="3" name="checkbox-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '"  question-required="Y" has_other="N"  questionId="' + Qid + '" ng-hide="0" max min>Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" tabindex="0" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">多选题</div></div></div><ul class="question-choice"><li class="choice" has_other="N" choice_absolute_id="1"><input type="checkbox" name="checkbox"><div class="position-relative"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">选项1 </div></div></li><li class="choice" has_other="N" choice_absolute_id="2"><input type="checkbox" name="checkbox"><div class="position-relative"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">选项2 </div></div></li></ul><div class="add-area visible-hide"><ul><li class="add-choice" title="增加" onclick="edit.addQuestion(this)"></li></ul></div><div class="operate visible-hide fl-right"><ul><li class="set-logic" title="逻辑设置" onclick="setLogic(this)"></li><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'input':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="4" name="input-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">单行填空题</div></div></div><ul class="question-choice"><li><input type="text" name="input" class="input-single"></li></ul><div class="operate visible-hide fl-right"><ul><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'multi-input':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="5" name="multi-input-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">多行填空题</div></div></div><ul class="question-choice"><li class="auto-height"><textarea name="multi-input" class="multi-input"></textarea></li></ul><div class="operate visible-hide fl-right"><ul><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'desc':
            var _html = '<div class="topic-type-content decs-type-question after-clear"><div class="question-title" type="6" name="description"><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="N" has_other="N" questionId="' + Qid + '" ng-hide="0"></span><div class="position-relative"><div class="qs-content qs-high-content edit-area edit-title" contenteditable="true" content-default="1">描述说明</div></div></div><div class="operate visible-hide' +
                ' fl-right"><ul><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'page':
            config.page++;
            var _html = '<div class="topic-type-content topic-page after-clear"> <div class="question-title" type="7" order="' + survey_init.length + '" name="page" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" style="padding: 0px;height: 36px;"><span class="question-id" order="' + survey_init.length + '" style="margin: 0px;" index="0"></span><div class="page-area">页码:' + (config.page - 1) + '/' + config.page + '</div></div><div class="operate visible-hide fl-right"><ul><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            $('#page-tail').html('页码:' + config.page + '/' + config.page);
            $('.topic-page').each(function (k, v) {
                $(this).find('.page-area').html('页码:' + (k + 1) + '/' + config.page);
            });
            break;
        case 'radio-matrix':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="8" name="radio-matrix-question" page><span class="required">*</span> <span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"> <div class="qs-content edit-area edit-title" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">矩阵单选题</div></div></div> <ul class="question-choice" style="width: 700px;"><li class="auto-height"> <table style="border-collapse: collapse;"> <tbody><tr><td>&nbsp;</td> <td name="radio-matrix-choice"><div class="position-relative" style="width:100%"> <li class="choice edit-area matrix-choice" has_other="N" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">选项1</li></div></td> <td name="radio-matrix-choice"><div class="position-relative" style="width:100%"> <li class="choice edit-area matrix-choice" has_other="N" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">选项2</li></div></td> </tr> <tr> <td class="radio_array_title" name="radio-matrix"><div class="position-relative" style="width:100%"> <div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">矩阵行1</div></div></td><td><input type="radio"></td> <td><input type="radio"></td></tr> <tr><td class="radio_array_title" name="radio-matrix"><div class="position-relative" style="width:100%"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="background: rgb(255, 255, 255);">矩阵行2</div></div></td><td><input type="radio"></td><td><input type="radio"></td></tr></tbody></table></li></ul><div class="add-area abs-position" choice="Y"><ul><li class="add-choice" onclick="edit.addQuestion(this)"></li> </ul></div><div class="add-area" choice="N"><ul><li class="add-choice" onclick="edit.addQuestion(this)"></li></ul></div><div class="operate visible-hide fl-right"><ul><li class="drag-area" title="移动"></li> <li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li> <li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
        case 'checkbox-matrix':
            var _html = '<div class="topic-type-content topic-type-question after-clear"><div class="question-title" type="9" name="checkbox-matrix-question"><span class="required">*</span><span class="question-id" order="' + survey_init.length + '" page="' + config.page + '" index="' + survey_init.length + '" question-required="Y" has_other="N" questionId="' + Qid + '" ng-hide="0">Q' + Qid + '</span><div class="position-relative"><div class="qs-content edit-area edit-title" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">矩阵多选题</div></div></div><ul class="question-choice" style="width: 700px;"><li class="auto-height"><table style="border-collapse: collapse;"><tbody><tr><td>&nbsp;</td><td name="checkbox-matrix-choice"><div class="position-relative" style="width:100%"><li class="choice edit-area matrix-choice" has_other="N" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">选项1</li></div></td><td name="checkbox-matrix-choice"><div class="position-relative" style="width:100%"><li class="choice edit-area matrix-choice" has_other="N" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">选项2</li></div></td></tr><tr><td class="checkbox_array_title" name="checkbox-matrix"><div class="position-relative" style="width:100%"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">矩阵行1</div></div></td><td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td><td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td></tr><tr><td class="checkbox_array_title" name="checkbox-matrix"><div class="position-relative" style="width:100%"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">矩阵行2</div></div></td><td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td><td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td></tr></tbody></table></li></ul><div class="add-area visible-show abs-position"  choice="Y"><ul><li class="add-choice" onclick="edit.addQuestion(this)"></li></ul></div><div class="add-area visible-show" choice="N"><ul><li class="add-choice" onclick="edit.addQuestion(this)"></li></ul></div><div class="operate visible-show fl-right"><ul><li class="drag-area" title="移动"></li><li class="question-handle" title="操作" onclick="edit.questionHandle(this)"></li><li class="question-delete" title="删除" onclick="edit.questionDelete(this)"></li></ul></div></div>';
            $('#question-box').append(_html);
            break;
    }
    $('html,body').animate({scrollTop: $('#question-box>div:last-child').offset().top}, 300);
    sendsurvey();
    Qid = config.getQid();
    // console.log(JSON.stringify(survey_init));
})
var col1OffsetH = $('.col1').offset().top;
$(window).scroll(function () {
    if ($(window).scrollTop() > col1OffsetH) {
        $('.col1').css({
            'position': 'fixed',
            'top': 0,
            'left': $('.center-content').offset().left
        });
    } else {
        $('.col1').css({
            'position': 'absolute',
            'top': 0,
            'left': 0
        })
    }
})
/*$(document).delegate('.topic-type-content', 'mouseover', function (e) {
 $(this).find('.visible-hide').removeClass('visible-hide').addClass('visible-show');
 }).delegate('.topic-type-content', 'mouseout', function () {
 $(this).find('.visible-show').removeClass('visible-show').addClass('visible-hide');
 })*/
var edit = {
    sortQuestions: function (obj) {
        $(".topic-type-content").each(function () {
            var e = $(this).index();
            e += 1, $(this).find(".question-id").attr("order", e);
            var i = $(this).prevAll(".topic-page").length;
            i += 1, $(this).find(".question-id").attr("page", i);
            var t = $(this).find(".question-title").attr("name"), s = $("#question-box").find(".topic-page").length;
            s += 1;
            var a;
            if ("page" === t)$(this).find(".page-area").html("页码:" + i + "/" + s), a = 0; else if ("description" === t)a = 0; else {
                var o = 0;
                $(this).prevAll(".topic-type-question").each(function () {
                    var e = parseInt($(this).find(".question-title").attr("type"), 10);
                    10 != e && o++
                }), a = o + 1, $(this).find(".question-id").html("Q" + a), $(this).find(".question-id").attr("questionid", a), "Y" == $(this).find(".question-id").attr("question-required") && 0 == $(this).find(".required").length && $(this).find(".question-id").before('<span class="required">*</span>')
            }
            $(this).find(".question-id").attr("index", a), $("#page-tail").html("页码:" + s + "/" + s)
        })
    },
    addQuestion: function (obj) {
        var choice_absolute_id, nodeLength, iptNode;
        var container = $(obj).closest('.add-area').siblings('.question-choice')
            , choice_absolute_id = container.find('li').length + 1,
            rows;
        nodeLength = container.find('li').length;
        if (container.siblings('.question-title').attr('type') == '9' && $(obj).closest('.add-area').hasClass('abs-position')) {
            var tdNode = '<td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td>';
            $.each(container.find('table').find('tr'), function (k, v) {
                nodeLength = $(v).children('td').length;
                if (k == 0) {
                    var thNode = '<td name="checkbox-matrix-choice"><div class="position-relative" style="width:100%"><li class="choice edit-area matrix-choice" has_other="N" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">';
                    thNode += '选项' + nodeLength + '</li></div></td>';
                    $(v).append(thNode);
                } else {
                    $(v).append(tdNode);
                }

            });
        } else if (container.siblings('.question-title').attr('type') == '9' && !$(obj).parent('ul').parent('.add-area').hasClass('abs-position')) {
            nodeLength = container.find('table').find('tr').length;
            $('<tr></tr>').insertAfter(container.find('table').find('tr:last-child'));
            var tdNode = '<td><input type="checkbox"><div class="edit-area edit-child-element tdArea" contenteditable="true" content-default="1"></div></td>';
            $.each(container.find('tr:first-child').find('td'), function (k, v) {
                if (k == 0) {
                    var thNode = '<td class="checkbox_array_title" name="checkbox-matrix"><div class="position-relative" style="width:100%"><div class="edit-area edit-child-element" contenteditable="true" content-default="1" style="border: none; background: rgb(255, 255, 255);">矩阵行' + nodeLength + '</div></div></td>';
                    container.find('tr:last-child').append(thNode);
                } else {
                    container.find('tr:last-child').append(tdNode);
                }

            });
        } else {
            if (container.find('li:last-child').find('input').attr('type') == 'radio') {
                iptNode = '<input type="radio" name="radio">';
            } else if (container.find('li:last-child').find('input').attr('type') == 'checkbox') {
                iptNode = '<input type="checkbox" name="checkbox">';
            }
            rows = '<li class="choice" has_other="N" choice_absolute_id="' + choice_absolute_id + '">' + iptNode + '<div class="position-relative">' +
                '<div class="edit-area edit-child-element" contenteditable="true" style="border-color: rgb(255, 255, 255); background: rgb(255, 255, 255);">选项' + choice_absolute_id + '</div></div></li>';
            container.append(rows);
        }
        sendsurvey();
    },
    questionDelete: function (obj) {
        var container = $(obj).closest('.topic-type-content');
        var questionId = parseInt(container.find('.question-id').attr('questionId'));
        var type = parseInt(container.find('.question-title').attr("type"));
        //survey_init.splice(index, 1);
        layer.open({
                type: 1,
                title: '操作提示',
                shadeClose: true,
                maxmin: false,
                area: ['500px'],
                btn: ['确认', '取消'],
                content: $('#operate-popup'),
                yes: function (index) {
                    var tplLogic = getLogicList(logic, questionId);
                    if (tplLogic.questionId == questionId) {
                        logic.splice($.inArray(tplLogic, logic), 1);
                    }
                    for (var i in logic) {
                        for (var j in  logic[i].areaQuestion) {
                            for (var k = 0; k < logic[i].areaQuestion[j].content.length; k++) {
                                var value = logic[i].areaQuestion[j].content[k];
                                if (value == questionId) {
                                    logic[i].areaQuestion[j].content.splice($.inArray(questionId, logic[i].areaQuestion[j].content), 1);
                                    k--;
                                } else if (value > questionId) {
                                    value--;
                                    logic[i].areaQuestion[j].content[k] = value;
                                }
                            }
                        }
                    }

                    console.log(JSON.stringify(logic));

                    if ($(obj).closest('.topic-type-content').hasClass('topic-page')) {
                        config.page--;
                        $('#page-tail').html('页码:' + config.page + '/' + config.page);
                        $('.topic-page').each(function (k, v) {
                            $(this).find('.page-area').html('页码:' + (k + 1) + '/' + config.page);
                        });
                    }
                    if (!$('#question-box>div').hasClass('topic-type-content')) {
                        $('#question-box').append('<div class="question-box-init">点击左侧题型，以添加题目到此空白区域</div>');
                    }
                    container.remove();
                    config.setQid();
                    initdata();
                    $('.topic-type-content').each(function (k, v) {
                        var questionId = parseInt($(this).find('.question-id').attr('questionId'));
                        var tplLogic = getLogicList(logic, questionId);
                        $(this).find('.question-choice').find('li.choice').each(function (k, v) {
                            var choiceAbsoluteId = $(v).attr('choice_absolute_id');
                            initCheckQsList(v, choiceAbsoluteId, tplLogic);
                        });
                    })
                    sendsurvey();
                    layer.close(index);
                }
            }
        )
        ;

    },
    questionHandle: function (obj) {
        var container = $(obj).parents(".operate").siblings(".question-title");
        var t = container.attr("type");
        var n = container.find(".question-id").attr("question-required");
        var i = container.find(".question-id").attr("order");
        var min = container.find(".question-id").attr("min");
        var max = container.find(".question-id").attr("max");
        question_handle(n, i, t, min, max);
        var required = $(obj).parents(".operate").siblings(".question-title").find(".question-id").attr("question-required");
        if (required == 'N') {
            $('.handle-area li input[type="checkbox"]').prop('checked', true);
        }

        layer.open({
            type: 1,
            title: '题目设置',
            shadeClose: true,
            maxmin: false,
            area: ['500px'],
            btn: ['确认', '取消'],
            content: $('#handle-dialog'),
            yes: function (index) {

                if ($('.handle-area li input[type="checkbox"]').prop('checked') == true) {
                    container.find(".question-id").attr("question-required", "N");
                    container.find(".required").remove();
                } else {
                    container.find(".question-id").attr("question-required", "Y");
                    if (required == 'N') {
                        $('<span class="required">*</span>').insertBefore($(obj).parents(".operate").siblings(".question-title").find(".question-id"));
                    }

                }
                container.find(".question-id").attr("min", $('.handle-area li input[name="min-checkbox"]').val());
                container.find(".question-id").attr("max", $('.handle-area li input[name="max-checkbox"]').val());
                sendsurvey();
                layer.close(index);
            }
        });
    }
    ,
    editSelect: function () {
        survey_init = [];
        initdata();
    }
    ,
    removeChildElement: function (obj) {
        if ($(obj).closest('td').hasClass('checkbox_array_title')) {
            $(obj).closest('td').parent('tr').remove();
        } else {
            var ceil = $(obj).closest("td");
            var ceilIndex = ceil[0].cellIndex;
            $.each($(obj).closest('tr').siblings('tr'), function () {
                $(this).children('td').eq(ceilIndex).remove();
            })
            $(obj).closest('td').remove();
            sendsurvey();
        }
    }
    ,
    finishEditSelect: function (obj) {
        var radioArray = [], selectList, parentNode = $(obj).closest('.topic-type-question');
        selectList = '<select class="question-choice" style="padding: 0;margin: 15px 0 20px 35px;"></select>';
        $(selectList).insertAfter(parentNode.find('.question-title'));
        $(obj).closest('.add-area').siblings('.select-ul').find('li').each(function (k, v) {
            var optionTemplate = {};
            optionTemplate.has_other = $(this).attr('has_other');
            optionTemplate.choice_absolute_id = $(this).attr('choice_absolute_id');
            optionTemplate.txt = $(this).find('.edit-child-element').text();
            radioArray.push(optionTemplate);
            var _html = '<option class="choice" has_other="' + optionTemplate.has_other + '" choice_absolute_id="' + optionTemplate.choice_absolute_id + '">' + optionTemplate.txt + '</option>';
            parentNode.find('.question-choice').append(_html);

        });
        parentNode.find('.add-area,.select-ul').remove();
        $('<span class="edit-select" onclick="edit.editSelect(this)" style="width:60%;display:inline-block;line-height: 30px;">编辑选项</span>').insertAfter(parentNode.find('.question-choice'));
        sendsurvey();
    }

}
$(document).delegate('.edit-select', 'click', function () {
    var parentNode = $(this).parent('.topic-type-content');
    var questionId = parentNode.find('.question-id').attr('questionid');
    var optionArray = [];
    var _this = $(this);
    var radioList = '<ul class="question-choice select-ul"></ul>';
    var questionTitle = _this.siblings(".question-title");
    $(radioList).insertAfter(questionTitle);
    var _html = '';
    _this.siblings("select.question-choice").find('option.choice').each(function (k, v) {
        var optionTemplate = {};
        optionTemplate.has_other = $(v).attr('has_other');
        optionTemplate.choice_absolute_id = parseInt($(v).attr('choice_absolute_id'));
        optionTemplate.txt = $(v).text();
        optionArray.push(optionTemplate);
        _html += '<li class="choice select_choice" has_other="' + optionTemplate.has_other + '" choice_absolute_id="' + optionTemplate.choice_absolute_id + '"><input type="radio" name="radio"><div class="position-relative"><div class="edit-area edit-child-element" contenteditable="true" style="border-color: rgb(255, 255, 255); background: white;">' + optionTemplate.txt + '</div></div></li>';

    });
    if (_html.length > -1) {
        _this.siblings('.select-ul').append(_html);
    }
    var opertorDiv = '<div class="add-area visible-show"><ul><li class="add-choice" title="增加" onclick="edit.addQuestion(this)"></li><li class="finish_edit_select" onclick="edit.finishEditSelect(this)" style="width: 60px;cursor: pointer;line-height:14px">完成编辑</li></ul></div>';
    $(opertorDiv).insertAfter(_this.siblings('.select-ul'));
    _this.siblings("select.question-choice").remove();
    _this.remove();
    var tplLogic = getLogicList(logic, questionId);
    parentNode.find('.question-choice').find('li.choice').each(function (k, v) {
        var choiceAbsoluteId = $(v).attr('choice_absolute_id');
        initCheckQsList(v, choiceAbsoluteId, tplLogic);
    });
});
$(document).delegate('.classify-title', 'click', function () {
    $(this).toggleClass('side_bar_show');
    $(this).next('ul').toggle();

})
$(document).delegate('.question-choice table .edit-area:not(".tdArea")', 'click', function () {
    var _html = '<div class="survey-hide edit-img" contenteditable="false" style="width:30px;display: block;"><ul><li class="handle-element remove-child-element" title="删除" onclick="edit.removeChildElement(this)"></li> </ul></div>';
    $('.survey-hide').remove();
    if (!$(this).next('.survey-hide')[0]) {
        $(_html).insertAfter($(this));
    }
})
function setLogic(obj) {
    var container = $(obj).closest('.topic-type-content');
    var questionId = parseInt(container.find('.question-id').attr('questionId'));
    var tplLogic = getLogicList(logic, questionId);
    $('.condition-area ul').html('');
    $('.logic-questions ul').html('');
    tplLogic.questionId = questionId;
    var curOrder = questionId;
    //生成右侧logic-questions ul
    var _html = '';
    for (var i in survey_init) {
        if (survey_init[i].questionId > curOrder && survey_init[i].questionId != 'undefined') {
            var logicId;
            var logicContent = survey_init[i].content;
            logicId = 'Q' + survey_init[i].questionId;

            if (survey_init[i].typeId == "7" || survey_init[i].typeId == "6") {
                _html += '';
            }
            else {
                _html += '<li class="logic-show-question"  title="' + logicId + logicContent + '" questionId="' + survey_init[i].questionId + '"><label><input type="checkbox" class="logic-show-checkbox logic-show-checkbox-2"><span class="logic_show_question_index">' + logicId + '</span>' + logicContent + '</label></li>';
            }
        }
    }
    $('.logic-questions ul').append(_html);
    var tempQsArea = [];//存储areaQuestion初始化数据
    //生成左侧condition-area ul
    var _html = '';
    container.find('.choice').each(function (k, v) {
        var arr = [], obj = {choiceId: '', content: ''};
        arr[k] = $.trim($(v).find('.edit-child-element').text() || $(v).text());
        _html += '<li class="condition_element" absolute_id="' + (k + 1) + '" choice_absolute_id="' + (k + 1) + '" title="' + arr[k] + '">' + arr[k] + '</li>';
        obj.choiceId = k + 1;
        obj.content = [];
        for (var i in tplLogic.areaQuestion) {
            if (tplLogic.areaQuestion[i].choiceId == parseInt(obj.choiceId)) {
                obj.content = tplLogic.areaQuestion[i].content;
            }
        }
        tempQsArea.push(obj);
    });
    $('.condition-area ul').append(_html);
    $('.condition_element:first-child').addClass('condition-active');
    //初始化tplLogic
    tplLogic.areaQuestion = tempQsArea;
    tplLogic.questionId = questionId;
    console.log(JSON.stringify(tplLogic));

    var choiceId = parseInt($('.condition-active').attr('choice_absolute_id'));
    var questionCheckList = [];
    for (var i in tplLogic.areaQuestion) {
        if (tplLogic.areaQuestion[i].choiceId == choiceId) {
            questionCheckList = tplLogic.areaQuestion[i].content;
        }
    }
    $.each($('.logic-questions ul li'), function () {
            $(this).bind('click', function () {
                var _this = $(this);
                var checkListObj = {
                    "choiceId": choiceId,
                    content: []
                };
                checkListObj.choiceId = choiceId;
                questionId = parseInt(_this.attr('questionId'));

                if (_this.find(".logic-show-checkbox").prop('checked')) {
                    if ($.inArray(questionId, questionCheckList) == -1) {
                        questionCheckList.push(questionId);
                    }
                }
                else {
                    if ($.inArray(questionId, questionCheckList) > -1) {
                        questionCheckList.splice($.inArray(questionId, questionCheckList), 1);
                    }

                }
                checkListObj.content = questionCheckList;
                for (var i in tplLogic.areaQuestion) {
                    if (choiceId == parseInt(tplLogic.areaQuestion[i].choiceId)) {
                        tplLogic.areaQuestion[i].content = questionCheckList;
                    }
                }
                console.log('逻辑设置后');
                console.log(JSON.stringify(tplLogic));
            });

        }
    )
    var initLogicCheckbox = function () {
        for (var i = 0; i < tplLogic.areaQuestion.length; i++) {
            //console.log('初始化');
            //console.log(JSON.stringify(tplLogic));
            if (choiceId == tplLogic.areaQuestion[i].choiceId) {
                $.each($('.logic-questions ul li'), function (k, v) {
                    //console.log($.inArray(parseInt($(this).attr('questionId')), tplLogic.areaQuestion[i].content));
                    if ($.inArray(parseInt($(this).attr('questionId')), tplLogic.areaQuestion[i].content) > -1) {
                        $(v).find('.logic-show-checkbox').prop("checked", true);
                    } else {
                        $(v).find('.logic-show-checkbox').prop("checked", false);
                    }

                })
            }
        }
    }
    initLogicCheckbox();
    $(document).delegate('.condition_element', 'click', function () {
        var _this = $(this);
        choiceId = _this.attr('choice_absolute_id');
        for (var i in tplLogic.areaQuestion) {
            if (parseInt(choiceId) == parseInt(tplLogic.areaQuestion[i].choiceId)) {
                questionCheckList = tplLogic.areaQuestion[i].content;
            }
        }
        //console.log('左击后');
        //console.log(JSON.stringify(tplLogic));
        $(this).addClass('condition-active').siblings('li').removeClass('condition-active');
        initLogicCheckbox();
    });
    layer.open({
        type: 1,
        title: '逻辑设置',
        maxmin: false,
        shadeClose: true,
        area: ['500px', '400px'],
        content: $('.logic-popup'),
        btn: ['确认', '取消'],
        yes: function (index) {
            console.log(JSON.stringify(logic));
            if (logic.length == 0) {
                logic.push(tplLogic);
            } else {
                var flag = false;
                for (var i = 0; i < logic.length; i++) {
                    if (parseInt(logic[i].questionId) == parseInt(tplLogic.questionId)) {
                        logic[i] = tplLogic;
                        flag = true;
                    }
                }
                if (!flag) {
                    logic.push(tplLogic);
                }
            }
            var logicCheckListJson = JSON.stringify(logic);
            console.log(logicCheckListJson);
            for (var i in tplLogic.areaQuestion) {
                $.each($('.topic-type-content'), function (k, v) {
                    var tempQsId = parseInt($(this).find('.question-id').attr('questionid'));
                    if ($.inArray(tempQsId, tplLogic.areaQuestion[i].content) > -1) {
                        $(this).find('.question-id').attr('ng-hide', 1);
                    }

                })
            }
            $.each(container.find('li.choice'), function (k, v) {


                //MVC Model AND View (data and view)
                var choiceAbsoluteId = parseInt($(v).attr('choice_absolute_id'));
                initCheckQsList(v, choiceAbsoluteId, tplLogic)


            })
            sendsurvey();
            layer.close(index);
        },
        btn2: function () {
            getLogicList(logic);
        }
    });
}
$('.topic-type-content').each(function (k, v) {
    var questionId = parseInt($(this).find('.question-id').attr('questionId'));
    var tplLogic = getLogicList(logic, questionId);
    $(this).find('.question-choice').find('li.choice').each(function (k, v) {
        var choiceAbsoluteId = $(v).attr('choice_absolute_id');
        initCheckQsList(v, choiceAbsoluteId, tplLogic);
    });
})
function initCheckQsList(obj, choiceAbsoluteId, tplLogic) {
    var selectChoiceList = [];
    for (var i in tplLogic.areaQuestion) {
        if (tplLogic.areaQuestion[i].choiceId == choiceAbsoluteId) {
            selectChoiceList = tplLogic.areaQuestion[i].content;
        }
    }

    var selectChoiceListWithQ = [];
    for (var j in selectChoiceList) {
        selectChoiceListWithQ[j] = "Q" + selectChoiceList[j];
    }

    var _html = "";
    if (selectChoiceListWithQ.length > 0) {
        _html = '<div class="option-tips"><span class="choice_show_logic_show_questions">显示';
        _html += selectChoiceListWithQ.join(",");
        _html += '</span></div>';
    }
    $(obj).find('.option-tips').remove();
    $(obj).append(_html);

}
function template_init() {
    template = {
        "surveyId": "",
        "order": "",
        "contentWithCommit": "",
        "commit": "",
        "content": "",
        "typeId": "",
        "hasOther": "",
        "required": "",
        "absoluteId": "",
        "questionId": "",
        "hidden": " ",
        "min": "",
        "max": "",
        "choice": [],
        "checkboxArrayTitle": []
    }
}
var surveryData, survey_name, survey_title, survey_id = getUrlParameter('surveyId');
function creatSurveyQuestion() {
    survey_name = $.trim($('.survey-title').find('.title-content').text());
    survey_title = $.trim($('.survey-desc').find('.desc-content').text());
    surveryData = {
        "surveyId": survey_id,
        "surveyName": survey_name,
        "surveyTitle": survey_title,
        "surveyStatus": 0,
        "content": survey_init,
        "logic": logic
    }
    surveyDataJson = JSON.stringify(surveryData);
    console.log(surveyDataJson);
    return surveyDataJson;
}
function sendsurvey() {
    survey_init = [];
    initdata();
    var surveyDataJson = creatSurveyQuestion();
    $.ajax(
        {
            type: 'post',
            dataType: 'json',
            url: '/survey/createSurveyQuestion/',
            contentType: 'application/json',
            data: surveyDataJson,
            success: function (data) {
                setTimeout(function () {
                    var _html = '<div class="time-save">已实时保存</div>';
                    $('body').append(_html);
                    $('.time-save').animate({'opacity': 1}, 500);
                    setTimeout(function () {
                        $('.time-save').animate({'opacity': 0}, 500);
                    }, 2000)
                }, 2000);
                $('.time-save').remove();
            }

        })
}
$(document, window).click(function (e) {
    $('.edit-area').removeClass('edit-area-hov');
    $('.edit-area').removeClass('edit-title-hov');
});
function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;
    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
}
