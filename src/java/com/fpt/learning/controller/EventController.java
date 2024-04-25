/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fpt.learning.controller;

import com.fpt.learning.constant.RoleUser;
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
import java.time.LocalDate;
import java.util.ArrayList;

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
        String[] attendeesIds = request.getParameterValues("attendeesId");
        String description = request.getParameter("description");
        String eventId = request.getParameter("eventId");

//        response.getWriter().println(title);
//        response.getWriter().println(startDateStr);
//        response.getWriter().println(endDateStr);
//        response.getWriter().println(location);
//        response.getWriter().println(attendeesIds);
//        response.getWriter().println(description);
//        response.getWriter().println(eventId);
//        
        HttpSession session = request.getSession(false);

        User organizer = null;
        if (session != null && session.getAttribute("user") != null && organizer == null) {
            organizer = (User) session.getAttribute("user");
        }

        //response.getWriter().println(startDateTimeString);
        List<Integer> attendeesList = new ArrayList<>();

        Event event = new Event();

        if (eventId != null) {
            event.setId(Integer.parseInt(eventId));
        }

        if (title != null && !title.isBlank()) {
            event.setTitle(title);
        } else {
            event.setTitle(null);
        }

        event.setStartDate(startDateStr);
        event.setEndDate(endDateStr);

        if (location != null && !location.isBlank()) {
            event.setLocation(location);
        } else {
            event.setLocation(null);
        }

        if (description != null && !description.isBlank()) {
            event.setDescription(description);
        } else {
            event.setDescription(null);
        }

        if (startDateStr != null && endDateStr != null) {
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
        }

        try {

            if (request.getParameter("addEvent") != null && request.getParameter("addEvent").equals("Save")) {

                if (attendeesIds != null && attendeesIds.length != 0) {
                    for (String attendeeId : attendeesIds) {
                        attendeesList.add(Integer.parseInt(attendeeId));
                    }

                    edao.insertEvent(event, attendeesList, organizer.getId());
                } else {
                    edao.insertEvent(event, organizer.getId());
                }

                request.getSession().setAttribute("addSuccess", "Add successfully");
                response.sendRedirect(request.getContextPath() + "/home");
                return;

            }

            if (request.getParameter("editEvent") != null && request.getParameter("editEvent").equals("Save")) {
                if (attendeesIds != null && attendeesIds.length != 0) {
                    for (String attendeeId : attendeesIds) {
                        attendeesList.add(Integer.parseInt(attendeeId));
                    }

                    edao.updateEvent(event, attendeesList, RoleUser.ATTENDEES.toString());
                } else {
                    edao.updateEvent(event, RoleUser.ATTENDEES.toString());
                }

                request.getSession().setAttribute("editSuccess", "Edit successfully");
                response.sendRedirect(request.getContextPath() + "/home?eventId=" + event.getId() + "&eventDetail=show");
                return;
            }

            if (request.getParameter("deleteEvent") != null && request.getParameter("deleteEvent").equals("Delete")) {
                edao.delete(event.getId());

                request.getSession().setAttribute("deleteSuccess", "Delete successfully");
                response.sendRedirect(request.getContextPath() + "/home");
                return;

                //response.getWriter().println(event.getId());
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
