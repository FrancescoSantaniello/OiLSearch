package oilsearch.models;

import java.util.List;

import java.util.ArrayList;

public class Distributore {
	private String _nome;
	private String _brand;
	private String _indirizzo;
	private final List<Carburante> _carburanti = new ArrayList<>();
	
	public String getNome() {
		return _nome;
	}

	public void setNome(String _nome) {
		if (_nome == null || _nome.isBlank())
			throw new IllegalArgumentException("Nome non valido");

		this._nome = _nome;
	}

	public String getBrand() {
		return _brand;
	}

	public void setBrand(String _brand) {
		this._brand = _brand;
	}

	public String getIndirizzo() {
		return _indirizzo;
	}
	
	public void setIndirizzo(String indirizzo) {
		if (indirizzo == null || indirizzo.isBlank())
			throw new IllegalArgumentException("Indirizzo non valido");
		_indirizzo = indirizzo;
	}
	
	public List<Carburante> getCarburanti() {
		return _carburanti;
	}

	public void addCarburante(Carburante _carburante) {
		if (_carburante == null)
			throw new IllegalArgumentException("Carburante non valido");
		_carburanti.add(_carburante);
	}
	
    public int compareTo(Distributore b, String key) {
    	if (key == null || key.isBlank()) {
    		return Double.compare(_carburanti.stream().mapToDouble(Carburante::getPrezzo).average().getAsDouble(),
    				b.getCarburanti().stream().mapToDouble(Carburante::getPrezzo).average().getAsDouble()
    				);
    	}
    	else {
    		_carburanti.sort((a,b2) -> Double.compare(a.getPrezzo(), b2.getPrezzo()));
    		b.getCarburanti().sort((a,b2) -> Double.compare(a.getPrezzo(), b2.getPrezzo()));
    		return Double.compare(_carburanti.get(_carburanti.size() - 1).getPrezzo(), b.getCarburanti().get(b.getCarburanti().size() - 1).getPrezzo());
    	}
    }
}






