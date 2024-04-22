package com.fpt.learning.dal;

import com.fpt.learning.constant.RoleUser;
import com.fpt.learning.context.DBContext;
import com.fpt.learning.model.Event;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO extends DBContext<Event> {

    PreparedStatement stm;
    PreparedStatement stmOrganizer;
    PreparedStatement stmAttendees;
    ResultSet rs;
    

    @Override
    public List<Event> findAll() {
        List<Event> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM events e JOIN categories c ON e.category_id = c.id";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setCategoryId(rs.getInt(2));
                event.setTitle(rs.getString(3));
                event.setLocation(rs.getString(4));
                event.setStartDate(String.valueOf(rs.getDate(5)));
                event.setEndDate(String.valueOf(rs.getDate(6)));
                event.setDescription(rs.getString(7));
                event.setStatus(rs.getString(8));
                event.setCategoryName(rs.getString(12));
                events.add(event);
            }
            return events;
        }catch (Exception e) {
            System.out.println("findAll(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }                
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    @Override
    public Event findById(int id) {
        try {
            String sql = "SELECT * FROM events WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while(rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setCategoryId(rs.getInt(2));
                event.setTitle(rs.getString(3));
                event.setLocation(rs.getString(4));
                event.setStartDate(String.valueOf(rs.getDate(5)));
                event.setEndDate(String.valueOf(rs.getDate(6)));
                event.setDescription(rs.getString(7));
                event.setStatus(rs.getString(8));
                event.setCategoryName(rs.getString(12));
                return event;
            }
            
        }catch (Exception e) {
            System.out.println("findAll(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }                
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
    
    

    public void insertEvent(Event event, List<Integer> attendeesIds, int organizerId) {
        try {
            String sqlEvent = "INSERT INTO [events]\n"
                    + "           ([category_id]\n"
                    + "           ,[title]\n"
                    + "           ,[location]\n"
                    + "           ,[start_datetime]\n"
                    + "           ,[end_datetime]\n"
                    + "           ,[description]\n"
                    + "           ,[status]\n"
                    + "           ,[created_at])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,GETDATE())";
            stm = connection.prepareStatement(sqlEvent, stm.RETURN_GENERATED_KEYS);
            stm.setInt(1, event.getCategoryId());
            stm.setString(2, event.getTitle());
            stm.setString(3, event.getLocation());
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = null;
            Date endDate = null;
            try {
                startDate = sdf.parse(event.getStartDate());
                endDate = sdf.parse(event.getEndDate());
            } catch (ParseException ex) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Convert java.util.Date to java.sql.Date
            java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(endDate.getTime());
            stm.setDate(4, sqlStartDate);
            stm.setDate(5, sqlEndDate);
            
            stm.setString(6, event.getDescription());
            stm.setString(7, event.getStatus());
            stm.executeUpdate();

            ResultSet rs = stm.getGeneratedKeys();
            int eventId = -1;
            if (rs.next()) {
                eventId = rs.getInt(1);
                event.setId(eventId);
            }

            if (eventId != -1 && !attendeesIds.isEmpty()) {
                String sqlOrganizer = "INSERT INTO [event_user]\n"
                        + "           ([event_id]\n"
                        + "           ,[user_id]\n"
                        + "           ,[role]\n"
                        + "           ,[status])\n"
                        + "     VALUES\n"
                        + "           (?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?)";
                stmOrganizer = connection.prepareStatement(sqlOrganizer);
                stmOrganizer.setInt(1, eventId);
                stmOrganizer.setInt(2, organizerId);
                stmOrganizer.setString(3, RoleUser.ORGANIZER.toString());
                stmOrganizer.setString(4, null);
                stmOrganizer.executeUpdate();

                String sqlAttendees = "INSERT INTO [event_user]\n"
                        + "           ([event_id]\n"
                        + "           ,[user_id]\n"
                        + "           ,[role]\n"
                        + "           ,[status])\n"
                        + "     VALUES\n"
                        + "           (?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?)";
                stmAttendees = connection.prepareStatement(sqlAttendees);

                for (Integer attendeesId : attendeesIds) {
                    stmAttendees.setInt(1, eventId);
                    stmAttendees.setInt(2, attendeesId);
                    stmAttendees.setString(3, RoleUser.ATTENDEES.toString());
                    stmAttendees.setString(4, null);
                    stmAttendees.addBatch();
                }
                stmAttendees.executeBatch();
            }

        } catch (Exception e) {
            System.out.println("insertEvent(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (stmOrganizer != null) {
                    stmOrganizer.close();
                }
                if (stmAttendees != null) {
                    stmAttendees.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void update(Event event) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Event model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public static void main(String[] args) {
        EventDAO edao = new EventDAO();
        List<Event> list = edao.findAll();
        for(Event e : list) {
            System.out.println(e);
        }
    }

}
