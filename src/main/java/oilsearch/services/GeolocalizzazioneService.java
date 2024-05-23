package oilsearch.services;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
 
public abstract class GeolocalizzazioneService {
    private static final String API_URL = "https://geocode.xyz";

    public static final double[] getCoordinate(String citta) throws Exception{
        if (citta == null || citta.isBlank())
            throw new IllegalArgumentException("Comune non valido");
        
            HttpURLConnection conn = (HttpURLConnection) new URL(String.format("%s?locate=%s&json=1", API_URL, citta)).openConnection();
            conn.setRequestMethod("GET");

            if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {

            	StringBuilder response = new StringBuilder();
            	try(BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))){
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) 
                    	response.append(inputLine);
            	}
                
                JSONObject jsonObject = (JSONObject) new JSONParser().parse(response.toString());
                Object latt = jsonObject.get("latt");
                Object lng = jsonObject.get("longt");
                
                if (jsonObject != null && latt != null && lng != null) {
                	try {
	                    return new double[] {
	                    		Double.parseDouble(latt.toString()),
	                    		Double.parseDouble(lng.toString())
	    	            };
                	}
                	catch(Exception ex) {
                		throw new Exception("Errore durante la geolocalizzazione del comune, riprovare");
                	}
                }
            }

        return null;
    }
}	