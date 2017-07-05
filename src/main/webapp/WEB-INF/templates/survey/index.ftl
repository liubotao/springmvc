<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <link href="/css/dialog.css" rel="stylesheet" type="text/css"/>
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
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
                    <!--<div class="common-questions">
                        <div class="classify-title common-questions-title" style="border-bottom-style: none;">常规问题</div>
                        <ul style="display: none;">
                            <li class="ui-draggable common_question" index="0">您的性别</li>
                            <li class="ui-draggable common_question" index="1">您的年龄</li>
                            <li class="ui-draggable common_question" index="2">您的职业</li>
                            <li class="ui-draggable common_question" index="3">工作年限</li>
                            <li class="ui-draggable common_question" index="4">教育程度</li>
                            <li class="ui-draggable common_question" index="5">个人月收入</li>
                            <li class="ui-draggable common_question" index="6">婚姻状况</li>
                        </ul>
                    </div>-->
                </div>
            </div>
            <div class="col2">
                <div class="survey-title">
                    <div class="title-content edit-area" contenteditable="true" tabindex="1">
                    </div>
                    <div class="error-tips error"></div>
                </div>
                <div class="survey-desc">
                    <div class="position-relative" style="width:100%">
                        <div class="desc-content edit-area" contenteditable="true"
                             style="border: none; background: rgb(255, 255, 255);">
                        </div>
                        <div class="error-tips"></div>
                    </div>
                </div>
                <div id="question-box" class="ui-sortable">
                </div>
                <div id="survey-tail">
                    <ul>
                        <li>
                            <div id="page-tail"></div>
                        </li>
                        <li>
                            <div id="survey-op" class="after-clear">
                                <div class="preview-survey dib">
                                    <input type="button" class="common-button survey-button preview-survey" value="预览问卷"
                                           onclick="previewSurvey()" style="width:108px;height:38px">
                                </div>
                                <div class="larger-outstanding-button op-next dib">下一步</div>
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
        <div class="survey-confirm-content"><img src="images/warning_icon.png" style="vertical-align: middle;">
            <div class="survey-content-text">您确认删除此题卡吗？</div>
        </div>
    </div>
</div>
</body>
<script type="application/javascript" src="/js/edit.js"></script>
</html>