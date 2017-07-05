package com.botao.util;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.HtmlUtils;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class StringJsonSerializer extends JsonSerializer<String> {

    private static final Logger logger = LoggerFactory.getLogger(StringJsonSerializer.class);

    @Override
    public void serialize(String str, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException, JsonProcessingException {
        if (str != null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            String string = m.replaceAll("");
            logger.info("StringJsonSerializer:" + string);
            jsonGenerator.writeString(HtmlUtils.htmlEscape(str.toString()));
        }
    }
}
