function question_handle(n, i, t, min, max) {
    "use strict";
    var e;
    var tempTxt = '该题可跳过不答';
    switch (t) {
        case "1":
            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li>';
            break;
        case "2":
            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li>';
            break;
        case "3":
            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li><li style="margin-top: 15px"><label>最少选<input type="text" name="min-checkbox" class="min-checkbox" value="' + min + '">项&nbsp;&nbsp;最多选<input type="text" name="max-checkbox" class="max-checkbox" value="' + max + '">项</label></li>';
            break;
        case "4":

            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li>';
            break;
        case "5":

            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li>';
            break;
        case "9":
            e = '<li><label><input type="checkbox" name="question-required" class="question-required no-required">' + tempTxt + '</label></li>';
            break;
    }
    var _html = '<ul class="handle-area" question-order="' + i + '">' + e + '</ul>';
    $('.handle-dialog').html(_html);
};
