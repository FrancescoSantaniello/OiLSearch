package oilsearch.models;

public class Carburante {
	private String _nome;
	private double _prezzo;
	private boolean _isSelf;
	
	public String getNome() {
		return _nome;
	}
	
	public void setNome(String _nome) {
		if (_nome == null || _nome.isBlank())
			throw new IllegalArgumentException("Nome non valido");
		this._nome = _nome;
	}
	
	public double getPrezzo() {
		return _prezzo;
	}
	
	public void setPrezzo(double _prezzo) {
		if (_prezzo <= 0)
			throw new IllegalArgumentException("Prezzo non valido");
		
		this._prezzo = Math.round(_prezzo * 1e3) / 1e3;
	}
	
	public boolean getIsSelf() {
		return _isSelf;
	}
	
	public void setIsSelf(boolean _isSelf) {	
		this._isSelf = _isSelf;
	}
	
	public Carburante(String nome, double prezzo, boolean isSelf) {
		setNome(nome);
		setPrezzo(prezzo);
		setIsSelf(isSelf);
	}
	
	public Carburante() {}
}
