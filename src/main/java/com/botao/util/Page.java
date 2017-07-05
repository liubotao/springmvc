package com.botao.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

public class Page {

    private int currentPage = 1;

    private int pageSize = 20;

    private String url;

    private int totalPage;

    private int startPage;

    private int endPage;

    private int totalItem;

    private int prevNum = 3;

    private int nextNum = 3;

    private static final HashMap<String, String> config;

    private static final Logger logger = LoggerFactory.getLogger(Page.class);

    static {
        config = new HashMap<String, String>();
        config.put("prefix", "<div class=\"mtc-pagination\" style=\"float: left;width: 100%;;float: left;width: 100%;\"><ul class=\"mtc-pagination-wrap\">");
        config.put("first", "<li><a class=\"pagination-nav-btn\" href=\"%link%\">&lt;&lt;</a></li>");
        config.put("last", "<li><a class=\"pagination-nav-btn last-pagination-nav-btn\" href=\"%link%\">&gt;&gt;</a></li>");
        config.put("prev", "<li><a class=\"pagination-nav-btn\" href=\"%link%\">&lt;</a></li>");
        config.put("next", "<li><a class=\"pagination-nav-btn\" href=\"%link%\">&gt;</a></li>");
        config.put("current", "<li class=\"active\"><a href=\"javascript:\" class=\"ng-binding\">%page%</a></li>");
        config.put("page", "<li class=\" \"><a href=\"%link%\" class=\"ng-binding\" title=\"第%page%页\">%page%</a></li>");
        config.put("suffix", "</ul></div>");
    }

    public Page(int currentPage, int pageSize, int totalItem, String url) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalItem = totalItem;
        this.url = url;
        this.init();
    }

    private void config(HashMap<String, String> newConfig) {
        for (Map.Entry<String, String> entry : newConfig.entrySet()) {
            String key = entry.getKey();
            if (config.containsKey(key)) {
                config.put(key, entry.getValue());
            }
        }
        this.init();
    }

    private void init() {
        if (this.pageSize < 1) {
            this.pageSize = 20;
        }

        this.totalPage = (int) Math.ceil((double) this.totalItem / this.pageSize);

        if (this.currentPage < 1 || this.currentPage > this.totalPage) {
            this.currentPage = 1;
        }

        this.endPage = this.currentPage - this.prevNum;
        if (this.endPage < 1) {
            this.startPage = 1;
        }

        this.endPage = this.currentPage + this.nextNum;
        int less = (this.prevNum + this.nextNum) - (this.endPage - this.startPage);
        if (less > 0) {
            this.endPage += less;
        }

        if (this.endPage > this.totalPage) {
            this.endPage = this.totalPage;
        }

        less = (this.prevNum + this.nextNum) - (this.endPage - this.startPage);
        if (less > 0) {
            this.startPage -= less;
        }

        if (this.startPage < 1) {
            this.startPage = 1;
        }
    }

    private String prefix() {
        return this.page(config.get("prefix"), null);
    }

    private String suffix() {
        return this.page(config.get("suffix"), null);
    }

    private String first() {
        return this.page(config.get("first"), "1");
    }

    private String last() {
        return this.page(config.get("last"), String.valueOf(this.totalPage));
    }

    private String prev() {
        if (this.currentPage == 1) {
            return "";
        }

        String page = String.valueOf(this.currentPage - 1);
        return this.page(config.get("prev"), page);
    }

    private String next() {
        if (this.currentPage == this.totalPage) {
            return "";
        }

        String page = String.valueOf(this.currentPage + 1);
        return this.page(config.get("next"), page);
    }

    private String current() {
        return this.page(config.get("current"), String.valueOf(this.currentPage));
    }

    public String page(String format, String page) {
        if (format == null) {
            format = config.get("page");
        }

        format = format.replace("%link%", this.url);
        format = format.replace("%curPage%", String.valueOf(this.currentPage));
        format = format.replace("%pageSize%", String.valueOf(this.pageSize));
        format = format.replace("%totalItem%", String.valueOf(this.totalItem));
        format = format.replace("%totalPage%", String.valueOf(this.totalPage));
        format = format.replace("%startPage%", String.valueOf(this.startPage));
        format = format.replace("%endPage%", String.valueOf(this.endPage));
        format = format.replace("%page%", String.valueOf(page));
        return format;
    }

    private String html() {
        if (this.totalPage <= 1) {
            return "";
        }

        String html;
        html = this.prefix();

        if ((this.startPage - 1) == 1) {
            html += this.first();
        } else if ((this.startPage - 1) > 1) {
            html += this.first();
        }

        html += this.prev();
        for (int i = this.startPage; i <= this.endPage; i++) {
            html += (this.currentPage == i ? this.current() : this.page(null, String.valueOf(i)));
        }

        if ((this.totalPage - this.endPage) == 1) {
            html += this.page(null, String.valueOf(this.totalPage));
        } else if ((this.totalPage - this.endPage) > 1) {
            html += this.next();
        }

        html += this.last();
        html += this.suffix();
        return html;
    }

    @Override
    public String toString() {
        return this.html();
    }

}
