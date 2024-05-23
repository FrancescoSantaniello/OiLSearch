package oilsearch.services;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import oilsearch.models.Carburante;
import oilsearch.models.Distributore;

public abstract class CarburantiService {
	private static final String API_URL = "https://carburanti.mise.gov.it/ospzApi/search/zone";
	
	private static final JSONObject request(double[] loc, int radius) throws Exception {
		HttpURLConnection connection = (HttpURLConnection) new URL(API_URL).openConnection();
		connection.setRequestMethod("POST");
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setDoOutput(true);
		
		try(OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream())){
			writer.write("{ \"points\": [{ \"lat\" : " + loc[0] + ", \"lng\": " + loc[1] + " }], \"radius\" : " + radius + " }");
			writer.flush();
		}
		
		if (connection.getResponseCode() != HttpURLConnection.HTTP_OK) 
			return null;
	
		StringBuilder response = new StringBuilder();
		try(BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))){
			String line;
			while ((line = reader.readLine()) != null) 
				response.append(line);
		}
	
		return (JSONObject) new JSONParser().parse(response.toString());
	}
	
	public static final List<Distributore> getDistributori(String comune, int radius, String carburante) throws Exception{
		if (comune == null || comune.isBlank())
			throw new IllegalArgumentException("Comune non valido");
		if (radius <= 0 || radius > 10)
			throw new IllegalArgumentException("Raggio non valido");
		
		final double[] coord = GeolocalizzazioneService.getCoordinate(comune);	
		if (coord == null)
			throw new IllegalArgumentException("Comune non valido");
		
		JSONObject jsonResult = request(coord, radius);
	
		if (jsonResult == null || jsonResult.get("success").toString().equalsIgnoreCase("False"))
			return null;
		
		final List<Distributore> list = new ArrayList<>();
		final JSONParser parser = new JSONParser();
		
		JSONArray results = (JSONArray) parser.parse(jsonResult.get("results").toString());
		
		if (results == null)
			return list;
		
		for(Object result : results) {
			if (result != null) {
				JSONObject resultJson = (JSONObject)parser.parse(result.toString());
				Distributore distributore = new Distributore();
				
				distributore.setNome(resultJson.get("name").toString());
				distributore.setBrand(resultJson.get("brand").toString());
				distributore.setIndirizzo(resultJson.get("address").toString());

				JSONArray fuels = (JSONArray) parser.parse(resultJson.get("fuels").toString());
				
				if (fuels != null) {
					for(Object fuel : fuels) {
						if (fuel != null) {
							final JSONObject fuelJson = (JSONObject)parser.parse(fuel.toString());
							
							if ((carburante != null && !carburante.isBlank() && fuelJson.get("name").toString().equalsIgnoreCase(carburante)) || (carburante == null || carburante.isBlank())) {
								Carburante c = new Carburante();
								c.setIsSelf(fuelJson.get("isSelf").toString() == "true");
								c.setNome(fuelJson.get("name").toString());
								c.setPrezzo(Float.parseFloat(fuelJson.get("price").toString()));
								distributore.addCarburante(c);
							}
							
						}
					}
				}
				
				if (!distributore.getCarburanti().isEmpty())
					list.add(distributore);
			}
		}

		list.sort((a,b) -> a.compareTo(b, carburante));
		return list;
	}
}
