package com.ese.common.serializer;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class YYYYMMDDDataSerializer extends JsonSerializer<Date> {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh");
	
	@Override
	public void serialize(Date value, JsonGenerator gen, SerializerProvider serializer) throws IOException {
		String strDate = sdf.format(value);
		gen.writeString(strDate);
	}
}
