package com.fpt.learning.controller;

import com.fpt.learning.dal.UserDAO;
import com.fpt.learning.model.User;
import com.fpt.learning.utils.BcryptUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class LoginController extends HttpServlet {

    private UserDAO userDao = new UserDAO();
    private BcryptUtil bcryptUtil = BcryptUtil.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errs = new ArrayList<>();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean flag = false;

        if (username.isBlank()) {
            errs.add("Please enter username");
            flag = true;
        }

        if (password.isBlank()) {
            errs.add("Please enter password");
            flag = true;
        }

        if (!username.trim().matches("^[a-z0-9]+$")) {
            errs.add("Username contains only lowercase letters and numbers");
            flag = true;
        }

        if (!password.trim().matches("^[a-z0-9]{8,}$")) {
            errs.add("Password contains at least 8 characters including lowercase letters and numbers");
            flag = true;
        }

        if (!flag) {
            if (userDao.login(username, password)) {
                User user = userDao.findByUsername(username);
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.setAttribute("user", user);
                    response.sendRedirect("home");
                    return;
                }
                return;
            } else {
                errs.add("Invalid username or password");
            }
        }

        request.setAttribute("errs", errs);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
