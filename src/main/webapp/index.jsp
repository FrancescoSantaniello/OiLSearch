<%@ page import="java.nio.file.Path"%>
<%@ page import="jakarta.enterprise.context.RequestScoped"%>
<%@ page import="oilsearch.models.Carburante"%>
<%@ page import="java.util.List"%>
<%@ page import="oilsearch.models.Distributore"%>
<%@ page import="java.nio.file.Files" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>OiLSearch</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<link rel="stylesheet" href="https://bootswatch.com/5/materia/bootstrap.min.css">
	</head>
	<body background="img/sfondo.jpg">
		<%
			String comune = "", radius = "5";
			
			Cookie[] cookies = request.getCookies();
			if (cookies != null){
				for(Cookie c : cookies){
					
					switch(c.getName()){
						case "comune":
							comune = c.getValue();
							break;
						case "radius":
							radius = c.getValue();
							break;
					}
				
				}
			}
		%>
		
		<div class="mx-auto">
			<div class="display-5">
				<h1>OiLSearch</h1>
			</div>
			<hr>
	
			<div class="mb-4">
				<form action="get" method="post">
					<div class="mb-3">
						<h4>Comune</h4>
						<input class="form-control" name="comune" value="<%= comune %>"required>
					</div>
	
					<div class="mb-3">
						<h4>Raggio di ricerca (km)</h4>
					    <div class="slider-container">
					        <input type="range" class="form-range" id="slider" min="1" max="10" value="<%= radius %>" name="radius" oninput="updateSliderValue(this.value)">
					        <span class="slider-value" id="slider-value"><%= radius %></span>
					    </div>
					</div>
	
					<div class="mb-3">
						<h4>Cerca carburante</h4>
						<select name="carburante_key" class="form-select">
							<option value='' selected>Nessuna selezione</option>
							<option value='Benzina' >Benzina</option>
							<option value='Gasolio' >Gasolio</option>
							<option value='HVOlution' >HVOlution</option>
							<option value='Blue Diesel' >Blue Diesel</option>
							<option value='Supreme Diesel' >Supreme Diesel</option>
							<option value='Hi-Q Diesel' >Hi-Q Diesel</option>
							<option value='HiQ Perform+' >HiQ Perform+</option>
							<option value='Blue Super' >Blue Super</option>
							<option value='GPL' >GPL</option>
							<option value='Gasolio Premium' >Gasolio Premium</option>
							<option value='Metano' >Metano</option>
							<option value='Gasolio Oro Diesel' >Gasolio Oro Diesel</option>
							<option value='Benzina Shell V Power' >Benzina Shell V Power</option>
							<option value='Diesel Shell V Power' >Diesel Shell V Power</option>
							<option value='HVO' >HVO</option>
							<option value='V-Power' >V-Power</option>
							<option value='L-GNC' >L-GNC</option>
							<option value='GNL' >GNL</option>
							<option value='Excellium Diesel' >Excellium Diesel</option>
							<option value='E-DIESEL' >E-DIESEL</option>
						</select>		
					</div>
						
					<button class="btn btn-primary btn-lg w-100">Cerca</button>
				</form>
	
				<%
				if (request.getAttribute("error_message") != null) {
					out.println("<hr>");
					out.println("<div class='alert alert-danger'>" + request.getAttribute("error_message") + "</div>");
				}
				else if (request.getAttribute("results") != null && (request.getAttribute("results") instanceof List)) {
					final List<Distributore> list = (List<Distributore>) request.getAttribute("results");
				%>
					<hr>
					
					<div>
						<h2>Risultati ricerca</h2>
						<h3>Distrubutore trovati: <b><%= list.size() %></b></h3>
						<h3>Distributori ordinati in senso crescente</h3>
					</div>
					
					<div>
						<table class="table table-secondary table-bordered">
							<thead>
								<tr class="table-primary">
									<th scope="col"><h4>#</h4></th>
									<th scope="col"><h4>Brand</h4></th>
									<th scope="col"><h4>Nome</h4></th>
									<th scope="col"><h4>Indirizzo</h4></th>
									<th scope="col"><h4>Carburanti</h4></th>
								</tr>
							</thead>
			
							<tbody>
								<%
									int i = 1;
									for (Distributore d : list) {
										
										if (i == 1)
											out.println("<tr class='table-success'>");
										else if (i == list.size())
											out.println("<tr class='table-danger'>");
										else
											out.println("<tr>");
										
										out.println("<td scope='row'>" + i + "</td>");
										
										out.println("<td scope='row'>");
											
										switch(d.getBrand().toLowerCase()){
											case "q8":
												out.println("<img src='img/brands/q8.png'");
											case "api-ip":
												out.println("<img src='img/brands/ip.png'");
											case "esso":
												out.println("<img src='img/brands/esso.png'");
											case "petrolgamma":
												out.println("<img src='img/brands/gamma.png'");
											case "7sette":
												out.println("<img src='img/brands/7sette.png'");
											case "agipeni":
												out.println("<img src='img/brands/eni.png'");
											case "tamoil":
												out.println("<img src='img/brands/tamoil.png'");
											case "smaf":
												out.println("<img src='img/brands/smaf.png'");
											case "357":
												out.println("<img src='img/brands/357.png'");
											case "italapetroli":
												out.println("<img src='img/brands/italapetroli.png'");
											case "cp":
												out.println("<img src='img/brands/cpower.png'");
											case "tiber":
												out.println("<img src='img/brands/tiber.png'");
											case "toil":
												out.println("<img src='img/brands/toil.png'");
											case "shell":
												out.println("<img src='img/brands/shell.png'");
											case "enerpetroli":
												out.println("<img src='img/brands/enerpetroli.png'");
											default:
												out.println("<img src='img/brands/sconosciuto.png'>");
										}
											
										out.println("<b>" + d.getBrand() + "</b>");
										out.println("</td>");
										
										out.println("<td scope='row'>" + d.getNome() + "</td>");
										out.println("<td scope='row'>" + d.getIndirizzo() + "</td>");
				
										if (i == 1)
											out.println("<td class='table-success' scope='row'>");
										else if (i == list.size())
											out.println("<td class='table-danger' scope='row'>");
										else
											out.println("<td class='table-warning' scope='row'>");
										
										
										for (Carburante c : d.getCarburanti()) {
											out.println("<li><span class='caret'><b>" + c.getNome() + "</b></span>");
											out.println("<ul class='nested'>");
											out.println("<li>Prezzo: <b style='font-size: 150%'>" + c.getPrezzo() + "</b> euro</li>");
											out.println("<li>Self Service: <b>" + (c.getIsSelf() ? "Si" : "No") + "</b></li>");
											out.println("</ul>");
											out.println("</li>");
										}
										out.println("</td>");
										out.println("</tr>");
										
										++i;
									}
								%>
							</tbody>
						</table>
					</div>
				<%
				}
				%>
			</div>
		</div>
		
		<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		<script>
			var toggler = document.getElementsByClassName("caret");
			for (var i = 0; i < toggler.length; ++i) {
				toggler[i].addEventListener("click", function() {
					this.parentElement.querySelector(".nested").classList
							.toggle("active");
					this.classList.toggle("caret-down");
				});
			}
	
	        function updateSliderValue(value) {
	            document.getElementById('slider-value').innerText = value;
	        }
		</script>
	</body>
</html>