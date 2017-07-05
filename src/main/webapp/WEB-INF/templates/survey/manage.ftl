<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="/css/content.css" rel="stylesheet" type="text/css"/>
    <link href="/css/dialog.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
    <title>问卷列表</title>
</head>
<body style="zoom:1">
<div id="bce-main" ng-app="survey" class="ng-scope">
    <div class="main">
        <ul class="bce-sidebar" id="bce-sidebar">
            <li class="bce-menu-header">问卷调研</li>
            <li class="bce-menu-item bce-sidebar-qss-list-instance active">
                <a class="bce-menu-list-item" href="#/">问卷列表</a>
            </li>
        </ul>
        <div class="survey-manage-wrap content ng-scope">
            <div class="survey-manage-content main-content-wrap" ng-hide="emptyList">
                <h2>问卷列表</h2>
                <div class="bce-task-list-head">
                    <a class="bce-create-task-btn" style="text-decoration: none" href="/survey/createSurvey"
                       target="_blank">
                        <div class="bce-common-normal-btn">
                            <span class="bce-normal-btn-plus-tag">+</span>
                            免费创建
                        </div>
                    </a>
                </div>
                <div class="survey-manage-list clearfix">
                    <div class="survey-manage-table-warp">
                        <table class="survey-manage-table">
                            <tbody>
                            <tr class="survey-manage-table-head" style="font-size: 14px;height: 50px;text-align: left">
                                <th style="width: 25%">问卷名称/问卷ID</th>
                                <th style="width: 15%">创建时间</th>
                                <th style="width: 17%">项目状态</th>
                                <th id="list-header-operate">操作</th>
                            </tr>

                            <#list surveyList as survey>
                            <tr>
                                <td nowrap="" title="${survey.surveyName}" survery-id="${survey.surveyId}">
                                ${survey.surveyName}
                                </td>
                                <td ng-bind="survey.create_time"
                                    class="ng-binding">${survey.addTime?datetime?string('yyyy-MM-dd HH:mm:ss')}</td>

                                <#if (survey.surveyStatus == 0)>
                                    <td ng-bind="survey.statusName"
                                        ng-class="{'survey-status-reject':survey.status==1,'survey-status-warning':survey.status==0||survey.status==10||survey.status==3,'survey-status-finish':survey.status==5}"
                                        ng-click="showRejectInfo(survey)" class="ng-binding survey-status-warning">
                                        创建中
                                    </td>
                                <#else>
                                    <td ng-bind="survey.statusName"
                                        class="survey-status-publish"
                                        ng-class="survey-status-publish"
                                        ng-click="showRejectInfo(survey)" class="ng-binding survey-status-warning">
                                        发布中
                                    </td>
                                </#if>

                                <td class="survey-operation">
                                    <#if (survey.surveyStatus == 1)><a href="/v/${survey.surveyId}.html"
                                                                       target="_blank">查看&nbsp;</a>  <#else> <a
                                            href="/survey/edit?surveyId=${survey.surveyId}"
                                            target="_blank">编辑&nbsp;</a> </#if>
                                    <a href="javascript:void(0)" onclick="edit.copySurvey(this)">复制&nbsp;</a>
                                    <a href="javascript:void(0)" onclick="edit.deleteSurvey(this)">删除&nbsp;</a>
                                </td>
                            </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                ${pagerStr}
                </div>
            </div>
        </div>
    </div>
</div>
<!--操作提示-->
<div class="operate-popup" style="display:none" id="operate-popup">
</div>
</body>
<script type="application/javascript" src="/js/layer/layer.js"></script>
<script>
    var edit = {
        copySurvey: function (obj) {
            var surveyId = $(obj).closest('tr').children('td').first().attr('survery-id');
            var surveyTitle = $(obj).closest('tr').children('td').first().attr('title');
            var _html = '<div class="survey-confirm"><div class="survey-confirm-content"><img src="images/warning_icon.png" style="vertical-align: middle;"><div class="survey-content-text">';
            _html += '您确认复制当前问卷【' + surveyTitle + '】吗？';
            _html += '</div></div></div>';
            $('#operate-popup').html('');
            $('#operate-popup').append(_html);
            layer.open({
                type: 1,
                title: '操作提示',
                maxmin: false,
                shadeClose: true,
                area: ['500px', '200px'],
                content: $('#operate-popup'),
                btn: ['确认', '取消'],
                yes: function (index) {
                    $.ajax(
                            {
                                type: 'get',
                                dataType: 'json',
                                url: '/survey/copy',
                                data: {"surveyId": surveyId},
                                success: function (data) {
                                    window.location.reload();
                                }

                            })

                    layer.close(index);
                }
            });
        }
        , deleteSurvey: function (obj) {
            var surveyId = $(obj).closest('tr').children('td').first().attr('survery-id');
            var surveyTitle = $(obj).closest('tr').children('td').first().attr('title');
            var _html = '<div class="survey-confirm"><div class="survey-confirm-content"><img src="images/warning_icon.png" style="vertical-align: middle;"><div class="survey-content-text">';
            _html += '您确认删除当前问卷【' + surveyTitle + '】吗？<p class="font-red">问卷内容与答卷都会被删除,请谨慎操作!!!</p>';
            _html += '</div></div></div>';
            $('#operate-popup').html('');
            $('#operate-popup').append(_html);
            layer.open({
                type: 1,
                title: '删除',
                maxmin: false,
                shadeClose: true,
                area: ['500px', '200px'],
                content: $('#operate-popup'),
                btn: ['确认', '取消'],
                yes: function (index) {
                    $.ajax(
                            {
                                type: 'get',
                                url: '/survey/delete',
                                data: {"surveyId": surveyId},
                                success: function (data) {
                                    window.location.reload();
                                }
                            })

                    layer.close(index);
                }
            });
        }
    }
</script>

</html>