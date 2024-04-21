package com.fpt.learning.controller;

import com.fpt.learning.dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import com.fpt.learning.model.User;
import com.fpt.learning.utils.BcryptUtil;

public class RegisterController extends HttpServlet {

    private UserDAO userDao = new UserDAO();
    private BcryptUtil bcryptUtil = BcryptUtil.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errs = new ArrayList<>();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");

        boolean flag = false;

        if (username.isBlank()) {
            errs.add("Please enter username");
            flag = true;
        }

        if (password.isBlank()) {
            errs.add("Please enter password");
            flag = true;
        }

        if (rePassword.isBlank()) {
            errs.add("Please confirm password");
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

        if (!password.equals(rePassword)) {
            errs.add("Password does not match");
            flag = true;
        }

        if (userDao.findByUsername(username) != null) {
            errs.add("Username is existed");
            flag = true;
        }

        String hashPassword = bcryptUtil.hashPassword(password);

        if (!flag) {
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashPassword);

            User insertedUser = userDao.insert(user);

            if (insertedUser != null) {
                request.getSession().setAttribute("registerSuccess", "Register successfully");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

        }

        request.setAttribute("errs", errs);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("rePassword", rePassword);
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
