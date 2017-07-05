package com.botao.entry;

import java.util.List;

public final class SurveyCheckbox {

    private int order;

    private String content;

    private List<String> commit;

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<String> getCommit() {
        return commit;
    }

    public void setCommit(List<String> commit) {
        this.commit = commit;
    }
}
