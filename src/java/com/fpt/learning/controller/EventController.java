/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fpt.learning.controller;

import com.fpt.learning.constant.StatusEvent;
import com.fpt.learning.dal.EventDAO;
import com.fpt.learning.model.Event;
import com.fpt.learning.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;

public class EventController extends HttpServlet {

    private EventDAO edao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String location = request.getParameter("location");
        String categoryId = request.getParameter("categoryId");
        String[] attendeesIds = request.getParameterValues("attendeesId");
        String description = request.getParameter("description");

        HttpSession session = request.getSession(false);

        User organizer = null;
        if (session != null && session.getAttribute("user") != null) {
            organizer = (User) session.getAttribute("user");

        }

        //response.getWriter().println(startDateTimeString);
        List<Integer> attendeesList = new ArrayList<>();

        if (attendeesIds != null && attendeesIds.length != 0) {
            for (String attendeeId : attendeesIds) {
                attendeesList.add(Integer.parseInt(attendeeId));
            }
        }

        try {

            if (request.getParameter("addEvent") != null && request.getParameter("addEvent").equals("Save")) {
                Event event = new Event();
                event.setTitle(title);
                event.setStartDate(startDateStr);
                event.setEndDate(endDateStr);
                event.setLocation(location);
                event.setCategoryId(Integer.parseInt(categoryId));
                event.setDescription(description);

                LocalDate startDate = LocalDate.parse(startDateStr);
                LocalDate endDate = LocalDate.parse(endDateStr);

                // LocalDateTime hiện tại
                LocalDate currentDate = LocalDate.now();

                if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate.plusDays(1))) {
                    event.setStatus(StatusEvent.ONGOING.toString());
                } else if (currentDate.isAfter(endDate)) {
                    event.setStatus(StatusEvent.FINISHED.toString());
                } else {
                    event.setStatus(StatusEvent.WAITING.toString());
                }

                edao.insertEvent(event, attendeesList, organizer.getId());

                request.getSession().setAttribute("addSuccess", "Add successfully");
                response.sendRedirect(request.getContextPath() + "/home");
                return;

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
