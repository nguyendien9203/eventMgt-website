
package com.fpt.learning.controller;

import com.fpt.learning.dal.CategoryDAO;
import com.fpt.learning.model.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CategoryController extends HttpServlet {
    private CategoryDAO cdao = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        
        if(request.getParameter("categoryName") != null) {
            Category category = new Category();
            category.setCategoryName(categoryName);
            
            cdao.insert(category);
            
            request.getSession().setAttribute("addSuccess", "Add successfully");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
            
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
