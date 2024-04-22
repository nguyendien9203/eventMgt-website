/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fpt.learning.controller;

import com.fpt.learning.dal.CategoryDAO;
import com.fpt.learning.dal.EventDAO;
import com.fpt.learning.dal.UserDAO;
import com.fpt.learning.model.Category;
import com.fpt.learning.model.Event;
import com.fpt.learning.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;


public class HomeController extends HttpServlet {
    private CategoryDAO cdao = new CategoryDAO();
    private UserDAO udao = new UserDAO();
    private EventDAO edao = new EventDAO();
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<User> users = null;
        if(session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            users = udao.findAllAttendeens(user.getId());
        }
        
        if(request.getParameter("eventId") != null && request.getParameter("eventDetail").equals("show")) {
            String eventId = request.getParameter("eventId");
            
        }
        
        
        List<Category> categories = cdao.findAll();
        List<Event> events = edao.findAll();
        
        
        request.setAttribute("categories", categories);
        request.setAttribute("events", events);
        request.setAttribute("users", users);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
