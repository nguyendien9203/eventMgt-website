/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fpt.learning.controller;

import com.fpt.learning.constant.RoleUser;
import com.fpt.learning.constant.StatusAttendees;
import com.fpt.learning.dal.EventDAO;
import com.fpt.learning.dal.UserDAO;
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

    private UserDAO udao = new UserDAO();
    private EventDAO edao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String keywordSearch = request.getParameter("keywordSearch");
        List<User> attendees = null;
        List<Event> eventsOfUser = null;

        if (session != null && session.getAttribute("user") != null) {
            User userSession = (User) session.getAttribute("user");
            attendees = udao.findAllAttendeens(userSession.getId());
            
            if(keywordSearch != null) {
                eventsOfUser = edao.search(userSession.getId(), RoleUser.ORGANIZER.toString(), RoleUser.ATTENDEES.toString(), keywordSearch);              
                
            }else {
                eventsOfUser = edao.findAllByUserIdAndRole(userSession.getId(), RoleUser.ORGANIZER.toString(), RoleUser.ATTENDEES.toString());
            }
            
            if (request.getParameter("eventId") != null && request.getParameter("eventDetail").equals("show")) {
                String eventId = request.getParameter("eventId");

                Event eventOfOrganizer = edao.findByEventIdAndRole(userSession.getId(), Integer.parseInt(eventId), RoleUser.ORGANIZER.toString());
                Event eventOfAttendees = edao.findByEventIdAndRole(userSession.getId(), Integer.parseInt(eventId), RoleUser.ATTENDEES.toString());

                int acceptCount = edao.getCountOfAttendees(Integer.parseInt(eventId), StatusAttendees.ACCEPT.toString());
                int acceptableCount = edao.getCountOfAttendees(Integer.parseInt(eventId), StatusAttendees.ACCEPTABLE.toString());
                int rejectCount = edao.getCountOfAttendees(Integer.parseInt(eventId), StatusAttendees.REJECT.toString());

                User organizer = udao.findOrganizerByRoleAndEventId(Integer.parseInt(eventId), RoleUser.ORGANIZER.toString());
                User attendee = udao.findAttendeesByUserIdAndEventIdAndRole(userSession.getId(), Integer.parseInt(eventId), RoleUser.ATTENDEES.toString());

                List<User> usersAccept = udao.findAllAttendeesByStatusAttendeesAndEventId(Integer.parseInt(eventId), StatusAttendees.ACCEPT.toString());
                List<User> usersAcceptable = udao.findAllAttendeesByStatusAttendeesAndEventId(Integer.parseInt(eventId), StatusAttendees.ACCEPTABLE.toString());
                List<User> usersReject = udao.findAllAttendeesByStatusAttendeesAndEventId(Integer.parseInt(eventId), StatusAttendees.REJECT.toString());

                request.setAttribute("eventOfOrganizer", eventOfOrganizer);
                request.setAttribute("eventOfAttendees", eventOfAttendees);
                request.setAttribute("acceptCount", acceptCount);
                request.setAttribute("acceptableCount", acceptableCount);
                request.setAttribute("rejectCount", rejectCount);
                request.setAttribute("usersAccept", usersAccept);
                request.setAttribute("usersAcceptable", usersAcceptable);
                request.setAttribute("usersReject", usersReject);  
                request.setAttribute("organizer", organizer); 
                request.setAttribute("attendee", attendee); 
            }
        }

        

        request.setAttribute("eventsOfUser", eventsOfUser);
        request.setAttribute("attendees", attendees);
        request.setAttribute("keywordSearch", keywordSearch);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(request.getParameter("eventId") != null && request.getParameter("userId") != null) {
            String eventId = request.getParameter("eventId");
            String userId =  request.getParameter("userId");
            
            
            if(request.getParameter("confirmStatusAttendees").equals("Accept") && request.getParameter("confirmStatusAttendees") != null) {
                edao.updateStatusOfAttendee(Integer.parseInt(eventId), Integer.parseInt(userId), StatusAttendees.ACCEPT.toString());
            }else if(request.getParameter("confirmStatusAttendees").equals("Acceptable") && request.getParameter("confirmStatusAttendees") != null) {
                edao.updateStatusOfAttendee(Integer.parseInt(eventId), Integer.parseInt(userId), StatusAttendees.ACCEPTABLE.toString());
            }else {
                edao.updateStatusOfAttendee(Integer.parseInt(eventId), Integer.parseInt(userId), StatusAttendees.REJECT.toString());
            }
            
//            if(request.getParameter("edit") != null && request.getParameter("edit").equals("Edit")) {
//                Event eventOfOrganizerUpdate = edao.findByEventIdAndRole(Integer.parseInt(userId), Integer.parseInt(eventId), RoleUser.ORGANIZER.toString());
//                request.setAttribute("eventOfOrganizerUpdate", eventOfOrganizerUpdate);
//                doGet(request, response);
//            }
            
            response.sendRedirect("home?eventId=" + eventId + "&eventDetail=show");
        }
        
        
           
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
