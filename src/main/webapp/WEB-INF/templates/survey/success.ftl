<!doctype html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <link href="/css/css.css" rel="stylesheet" type="text/css"/>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <script type="application/javascript" src="/js/jquery-1.10.2.js"></script>
    <title>问卷调查</title>
    <style>
        .survey-wrap {
            margin: 20px auto auto;
            line-height: 22px;
            text-align: center;
            background: #fff;
            padding: 20px;
            width: 780px;
        }

        .survey-finish-icon {
            background: url(/images/finish_icon.png) center center no-repeat;
            width: 100%;
            height: 48px;
            margin-top: 75px;
        }

        .survey-finish-tip {
            font-size: 24px;
            margin-top: 20px;
            margin-bottom: 40px;
        }

        @media screen and (min-width: 319px) and (max-width: 1025px) {
            .survey-wrap {
                margin: 3% auto 0;
                width: 94%;
            }

            .survey-finish-icon {
                background: url(/images/finish_icon.png) center center no-repeat;
                width: 100%;
                height: 48px;
                margin-top: 5%;
                background-size: 11% auto;
            }

            .survey-finish-tip {
                font-size: 1.5rem;
                line-height: 2rem;
                margin-top: 2%;
                margin-bottom: 2%;
            }

        }

        @media screen and (min-width: 768px) and (max-width: 1025px) {
            .survey-finish-icon {
                background-size: 6% auto;
            }
        }
    </style>

</head>
<body style="background:#E3E8F7">
<div class="survey-wrap">
    <div class="survey-finish-icon"></div>
    <div class="survey-finish-tip">您已完成本次答卷，感谢您的帮助与支持</div>
</div>
</body>
</html>