<%@ page isErrorPage="true" %>
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
			if (exception != null)
			{
				%>
					<div class="mx-auto">
						<div class="alert alert-danger">
							<h1>Errore</h1>
							<h3><%= exception.getMessage() %></h3>
						</div>
						
						<a href="index.jsp" class="btn btn-secondary">Torna all pagina principale</a>	
					</div>
				<%
			}
			else
				response.sendRedirect("index.jsp");
		%>
		
		<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>