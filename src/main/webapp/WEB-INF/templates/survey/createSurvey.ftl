<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="/css/content.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
    <title>创建空白问卷</title>
</head>
<body>
<div id="bce-main" ng-app="survey" class="ng-scope">
    <div class="main">
        <div ng-app="surveyTemplate" class="content common-task-content ng-scope">
            <div class="survey-template-wrap">
                <div class="survey-template-nav">
                    <a style="color: #333;" href="#/create" id="create_survey" class="survey-active">创建空白问卷</a>
                </div>
                <div ng-view="" class="ng-scope">
                    <div class="survey-create ng-scope">
                        <div class="survey-create-title">问卷标题</div>
                        <div class="survey-create-content">
                            <input class="create-survey-name" value="" placeholder="标题最多输入17个字">
                            <p class="error-tip"></p>
                        </div>
                        <div class="survey-create-button">
                            <input type="button" class="tpl-button" id="survey-confirm-y" value="创建问卷"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        $("#survey-confirm-y").click(function () {
            var createSurveyName = $(".create-survey-name").val();
            $.ajax({
                type: 'post',
                url: '/survey/create',
                data: {"surveyName": createSurveyName},
                success: function (data) {
                    window.location = "/survey/edit?surveyId=" + data.data.surveyId;
                }
            })
        })
    });
</script>
</html>