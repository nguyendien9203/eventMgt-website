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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Event> findAllByUserIdAndRole(int id, String organizer, String attendees) {
        List<Event> events = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "FROM events e\n"
                    + "INNER JOIN event_user eu ON e.id = eu.event_id\n"
                    + "WHERE (eu.user_id = ? AND eu.role = ?)\n"
                    + "   OR (eu.user_id = ? AND eu.role = ?);";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, organizer);
            stm.setInt(3, id);
            stm.setString(4, attendees);
            rs = stm.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setTitle(rs.getString(2));
                event.setStartDate(String.valueOf(rs.getDate(3)));
                event.setEndDate(String.valueOf(rs.getDate(4)));
                event.setLocation(rs.getString(5));
                event.setDescription(rs.getString(6));
                event.setStatus(rs.getString(7));
                events.add(event);
            }
            return events;
        } catch (Exception e) {
            System.out.println("findAllByUserId(): " + e.getMessage());
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
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setTitle(rs.getString(3));
                event.setLocation(rs.getString(4));
                event.setStartDate(String.valueOf(rs.getDate(5)));
                event.setEndDate(String.valueOf(rs.getDate(6)));
                event.setDescription(rs.getString(7));
                event.setStatus(rs.getString(8));
                return event;
            }

        } catch (Exception e) {
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

    public Event findByEventIdAndRole(int userId, int eventId, String role) {
        try {
            String sql = "SELECT *\n"
                    + "FROM events e\n"
                    + "INNER JOIN event_user eu ON e.id = eu.event_id\n"
                    + "WHERE eu.user_id = ? AND eu.event_id = ? AND eu.role = ?";
            stm = connection.prepareStatement(sql);         
            stm.setInt(1, userId);
            stm.setInt(2, eventId);
            stm.setString(3, role);
            rs = stm.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setTitle(rs.getString(2));
                event.setStartDate(String.valueOf(rs.getDate(3)));
                event.setEndDate(String.valueOf(rs.getDate(4)));
                event.setLocation(rs.getString(5));
                event.setDescription(rs.getString(6));
                event.setStatus(rs.getString(7));
                event.setCreatedAt(rs.getTimestamp(8));
                return event;
            }

        } catch (Exception e) {
            System.out.println("findByUserIdAndRole(): " + e.getMessage());
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

    public int getCountOfAttendees(int eventId, String statusAttendees) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM event_user WHERE event_id = ? AND status = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setString(2, statusAttendees);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return count;
    }
    
   

    public void insertEvent(Event event, List<Integer> attendeesIds, int organizerId) {
        try {
            String sqlEvent = "INSERT INTO [events]\n"
                    + "           ([title]\n"
                    + "           ,[start_datetime]\n"
                    + "           ,[end_datetime]\n"
                    + "           ,[location]\n"
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
                    + "           ,GETDATE())";
            stm = connection.prepareStatement(sqlEvent, stm.RETURN_GENERATED_KEYS);

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

            stm.setString(1, event.getTitle());
            stm.setDate(2, sqlStartDate);
            stm.setDate(3, sqlEndDate);

            stm.setString(4, event.getLocation());
            stm.setString(5, event.getDescription());
            stm.setString(6, event.getStatus());
            stm.executeUpdate();

            ResultSet rs = stm.getGeneratedKeys();
            int eventId = -1;
            if (rs.next()) {
                eventId = rs.getInt(1);
                event.setId(eventId);
            }

            if (eventId != -1) {
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

    public void insertEvent(Event event, int organizerId) {
        try {
            String sqlEvent = "INSERT INTO [events]\n"
                    + "           ([title]\n"
                    + "           ,[start_datetime]\n"
                    + "           ,[end_datetime]\n"
                    + "           ,[location]\n"
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
                    + "           ,GETDATE())";
            stm = connection.prepareStatement(sqlEvent, stm.RETURN_GENERATED_KEYS);

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

            stm.setString(1, event.getTitle());
            stm.setDate(2, sqlStartDate);
            stm.setDate(3, sqlEndDate);

            stm.setString(4, event.getLocation());
            stm.setString(5, event.getDescription());
            stm.setString(6, event.getStatus());
            stm.executeUpdate();

            ResultSet rs = stm.getGeneratedKeys();
            int eventId = -1;
            if (rs.next()) {
                eventId = rs.getInt(1);
                event.setId(eventId);
            }

            if (eventId != -1) {
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
        Event eventOfOrganizer = edao.findByEventIdAndRole(1,1, RoleUser.ORGANIZER.toString());
        System.out.println(eventOfOrganizer);
    }

}
