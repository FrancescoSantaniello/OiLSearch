package oilsearch.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import oilsearch.services.CarburantiService;

@WebServlet("/get")
public class CarburantiServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {		
			req.setAttribute("results", CarburantiService.getDistributori(
					req.getParameter("comune").toLowerCase(),
					Integer.parseInt(req.getParameter("radius")),
					req.getParameter("carburante_key")		
					));
		
			Cookie cookie = new Cookie("comune", req.getParameter("comune"));
			cookie.setMaxAge(900);
			cookie.setPath("/");
			resp.addCookie(cookie);
			
			cookie = new Cookie("radius", req.getParameter("radius"));
			cookie.setMaxAge(900);
			cookie.setPath("/");
			resp.addCookie(cookie);
			
			cookie = new Cookie("carburante", req.getParameter("carburante_key"));
			cookie.setMaxAge(900);
			cookie.setPath("/");
			resp.addCookie(cookie);
			
		}
		catch(Exception ex) {
			req.setAttribute("error_message", ex.getMessage());
		}
		
		req.getRequestDispatcher("index.jsp").forward(req, resp);
	}
}
