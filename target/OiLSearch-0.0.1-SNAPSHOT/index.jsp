<!DOCTYPE html>
<%@page import="oilsearch.models.Carburante"%>
<%@ page import="java.util.List" %>
<%@page import="oilsearch.models.Distributore"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>OiLSearch</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<div class="mx-auto" style="width: 80%;">
			<div class="display-5">
				OiLSearch
			</div>
		
			<div>
				<form action="get" method="post">
					<div class="mb-3">
						<label for="comune">Comune</label>
						<input class="form form-control" name="comune" required>
					</div>
	
					<div class="mb-3">
						<label for="comune">Raggio di ricerca (km)</label>
						<input class="form form-control" type="number" min="1" name="radius" required>
					</div>
					
					<button class="btn btn-primary">Cerca</button>
				</form>
			</div>
			
			<%
				
				if (request.getAttribute("error_message") != null){
					out.println("<hr>");
					out.println("<div class='alert alert-danger'>" + request.getAttribute("error_message") + "</div>");
				}
				else if (request.getAttribute("results") != null){
					out.println("<hr>");
					out.println("<div class='alert alert-success'>");
					for (Distributore d : (List<Distributore>)request.getAttribute("results")){
						%>
								<ul id="myUL">
								  <li><span class="caret"><%= d.getNome() %></span>
								    
								    <ul class="nested">
								      
									  <li>Nome <b><%= d.getNome() %></b></li>
									  <li>Brand <b><%= d.getBrand() %></b></li>
								      
								      <li><span class="caret">Posizione</span>
								          <ul class="nested">
									          <li>Indirizzo <b><%= d.getPosizione().getIndirizzo() %></b></li>
									          <li>Latitudine <b><%= d.getPosizione().getLatitudine() %></b></li>
									          <li>Longitudine <b><%= d.getPosizione().getLongitudine() %></b></li>
								          </ul>
								      </li> 
								      	<li><span class="caret">Carburanti</span> 
									      <%
										      for (Carburante c : d.getCarburanti()){
										  %>
										          <ul class="nested">
												      <li><span class="caret"><%= c.getNome() %></span>
												          <ul class="nested">
													          <li>Prezzo <b><%= c.getPrezzo() %></b> euro</li>
												          </ul>
												      </li>  
										          </ul>
									      <%
									      	}
									      %>
									  </li>  
								    </ul>
								  </li>
								</ul>
						<%
					}
					
					out.println("</div>");
				}
			%>
		</div>
		
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		<script>
			var toggler = document.getElementsByClassName("caret");
			for (var i = 0; i < toggler.length; i++) {
			  toggler[i].addEventListener("click", function() {
			    this.parentElement.querySelector(".nested").classList.toggle("active");
			    this.classList.toggle("caret-down");
			  });
			}
		</script>
	</body>
</html>