package com.botao.util;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

    private static String hexString = "0123456789ABCDEF";

    public static String replaceBlank(String str) {
        String dest = "";
        if (str != null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }

    public static String removeCommit(String str) {
        if (str != null) {
            Pattern p = Pattern.compile("(.*)\\&&.*\\&&");
            Matcher m = p.matcher(str);
            while (m.find()) {
                return m.group(1);
            }
        }
        return str;
    }

    public static void main(String[] args) {
        System.out.println(new Date());
    }

}
