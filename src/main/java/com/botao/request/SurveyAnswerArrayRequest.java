package com.botao.request;

public class SurveyAnswerArrayRequest {
    private int rows;

    private int cols;

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public int getCols() {
        return cols;
    }

    public void setCols(int cols) {
        this.cols = cols;
    }

    @Override
    public String toString() {
        return "SurveyAnswerArrayRequest{" +
                "rows=" + rows +
                ", cols=" + cols +
                '}';
    }
}