package com.fpt.learning.dal;

import com.fpt.learning.constant.RoleUser;
import com.fpt.learning.context.DBContext;
import com.fpt.learning.model.Event;
import com.fpt.learning.model.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EventDAO extends DBContext<Event> {

    PreparedStatement stm;
    PreparedStatement stmDeleteAll;
    PreparedStatement stmOrganizer;
    PreparedStatement stmAttendees;
    PreparedStatement stmFindAllAttendees;
    PreparedStatement stmDeleteAllAttendees;
    ResultSet rs;

    public List<Event> findAllByUserIdAndRole(int id, String organizer, String attendees) {
        List<Event> events = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "FROM events e\n"
                    + "INNER JOIN event_user eu ON e.id = eu.event_id\n"
                    + "WHERE ((eu.user_id = ? AND eu.role = ?)\n"
                    + "   OR (eu.user_id = ? AND eu.role = ?)) \n"
                    + "ORDER BY e.start_datetime ASC;";
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

    public List<Event> search(int id, String organizer, String attendees, String searchKeyword) {
        List<Event> events = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "FROM events e\n"
                    + "INNER JOIN event_user eu ON e.id = eu.event_id\n"
                    + "WHERE ((eu.user_id = ? AND eu.role = ?)\n"
                    + "   OR (eu.user_id = ? AND eu.role = ?)) AND e.title LIKE ?\n"
                    + "ORDER BY e.start_datetime ASC; ";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, organizer);
            stm.setInt(3, id);
            stm.setString(4, attendees);
            stm.setString(5, "%" + searchKeyword + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt(1));
                event.setTitle(rs.getString(2));
                event.setStartDate(String.valueOf(rs.getDate(3)));
                event.setEndDate(String.valueOf(rs.getDate(4)));
                event.setLocation(rs.getString(5));
                event.setDescription(rs.getString(6));
                events.add(event);
            }
            return events;
        } catch (Exception e) {
            System.out.println("search(): " + e.getMessage());
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
                    + "INNER JOIN users u ON u.id = eu.user_id\n"
                    + "WHERE eu.user_id = ? AND eu.event_id = ? AND eu.role = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, eventId);
            stm.setString(3, role);
            rs = stm.executeQuery();
            Event event = null;
            while (rs.next()) {
                if (event == null) {
                    event = new Event();
                    event.setId(rs.getInt(1));
                    event.setTitle(rs.getString(2));
                    event.setStartDate(String.valueOf(rs.getDate(3)));
                    event.setEndDate(String.valueOf(rs.getDate(4)));
                    event.setLocation(rs.getString(5));
                    event.setDescription(rs.getString(6));
                    event.setCreatedAt(rs.getTimestamp(8));
                    event.setAttendees(new ArrayList<>());
                }

                User attendee = new User();
                attendee.setId(rs.getInt("user_id"));
                attendee.setUsername(rs.getString("username"));
                event.getAttendees().add(attendee);
            }
            return event;

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
    
    public int getCountStatusResponded(int eventId, String statusAttendees, String role) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM event_user WHERE event_id = ? AND status = ? AND role = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setString(2, statusAttendees);
            stm.setString(3, role);
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
    
    public int getCountStatusNotResponded(int eventId, String role) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM event_user WHERE event_id = ? AND status IS NULL AND role = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setString(2, role);
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
                    + "           ,[created_at])\n"
                    + "     VALUES\n"
                    + "           (?\n"
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
                    + "           ,[created_at])\n"
                    + "     VALUES\n"
                    + "           (?\n"
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

    public List<Integer> findAllAttendeensByEvenIdAndRole(int eventId, String role) {

        try {
            String sql = "SELECT * FROM event_user WHERE [role] = ? AND event_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, role);
            stm.setInt(2, eventId);
            rs = stm.executeQuery();

            List<Integer> userIds = new ArrayList<>();
            while (rs.next()) {
                userIds.add(rs.getInt("user_id"));
            }

            return userIds;
        } catch (Exception e) {
            System.out.println("findAllAttendeensByEvenIdAndRole(): " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null;
    }

    // Phương thức lấy trạng thái của một người tham dự trong sự kiện
    public String getStatusOfAttendee(int eventId, int userId) {
        try {
            String sql = "SELECT status FROM event_user WHERE event_id = ? AND user_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setInt(2, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            System.out.println("getStatusOfAttendee(): " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null; // Trả về null nếu không tìm thấy hoặc có lỗi xảy ra
    }

// Phương thức cập nhật trạng thái của một người tham dự trong sự kiện
    public void updateStatusOfAttendee(int eventId, int userId, String status) {
        try {
            String sql = "UPDATE event_user SET status = ? WHERE event_id = ? AND user_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, eventId);
            stm.setInt(3, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateStatusOfAttendee(): " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public void updateEvent(Event event, List<Integer> attendeesIds, String role) {
        try {
            if (event.getId() != -1) {

                List<Integer> existingAttendees = findAllAttendeensByEvenIdAndRole(event.getId(), role);
                Map<Integer, String> statusMap = new HashMap<>();

                // Truy vấn và lưu trữ trạng thái của tất cả người tham dự hiện có
                for (Integer attendeeId : existingAttendees) {
                    String status = getStatusOfAttendee(event.getId(), attendeeId);
                    statusMap.put(attendeeId, status);
                }

                // Xóa những người tham dự không còn được mời nữa
                String deleteAttendeesQuery = "DELETE FROM event_user WHERE event_id = ? AND user_id = ?";
                stmDeleteAllAttendees = connection.prepareStatement(deleteAttendeesQuery);
                for (Integer attendeeId : existingAttendees) {
                    if (!attendeesIds.contains(attendeeId)) {
                        stmDeleteAllAttendees.setInt(1, event.getId());
                        stmDeleteAllAttendees.setInt(2, attendeeId);
                        stmDeleteAllAttendees.addBatch();
                    }
                }
                stmDeleteAllAttendees.executeBatch();

                // Thêm các người tham dự mới vào sự kiện
                String addAttendeesQuery = "INSERT INTO event_user (event_id, user_id, role, status) VALUES (?, ?, ?, ?)";
                stmAttendees = connection.prepareStatement(addAttendeesQuery);
                for (Integer attendeeId : attendeesIds) {
                    if (!existingAttendees.contains(attendeeId)) {
                        stmAttendees.setInt(1, event.getId());
                        stmAttendees.setInt(2, attendeeId);
                        stmAttendees.setString(3, role);
                        stmAttendees.setString(4, null);
                        stmAttendees.addBatch();
                    }
                }
                stmAttendees.executeBatch();

                // Cập nhật trạng thái của những người tham dự đã tồn tại nhưng không được mời nữa
                for (Map.Entry<Integer, String> entry : statusMap.entrySet()) {
                    int attendeeId = entry.getKey();
                    if (!attendeesIds.contains(attendeeId)) {
                        String status = entry.getValue(); // Lấy trạng thái từ statusMap
                        updateStatusOfAttendee(event.getId(), attendeeId, status);
                    }
                }

                String sqlEvent = "UPDATE [events]\n"
                        + "   SET [title] = ?\n"
                        + "      ,[start_datetime] = ?\n"
                        + "      ,[end_datetime] = ?\n"
                        + "      ,[location] = ?\n"
                        + "      ,[description] = ?\n"
                        + "      ,[updated_at] = GETDATE()\n"
                        + " WHERE id = ?";
                stm = connection.prepareStatement(sqlEvent);

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
                stm.setInt(6, event.getId());
                stm.executeUpdate();
            }

        } catch (Exception e) {
            System.out.println("updateEvent(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }

                if (stmFindAllAttendees != null) {
                    stmFindAllAttendees.close();
                }
                if (stmAttendees != null) {
                    stmAttendees.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void updateEvent(Event event, String role) {
        try {
            if (event.getId() != -1) {

                List<Integer> existingAttendees = findAllAttendeensByEvenIdAndRole(event.getId(), role);

                if (!existingAttendees.isEmpty()) {
                    // Nếu có người dùng tham gia, xóa tất cả các người dùng từ bảng event_user
                    String deleteAttendeesQuery = "DELETE FROM event_user WHERE event_id = ? AND user_id IN (?)";
                    stmDeleteAllAttendees = connection.prepareStatement(deleteAttendeesQuery);
                    stmDeleteAllAttendees.setInt(1, event.getId());
                    for (int userId : existingAttendees) {
                        stmDeleteAllAttendees.setInt(2, userId);
                        stmDeleteAllAttendees.addBatch();
                    }
                    stmDeleteAllAttendees.executeBatch();
                }

                String sqlEvent = "UPDATE [events]\n"
                        + "   SET [title] = ?\n"
                        + "      ,[start_datetime] = ?\n"
                        + "      ,[end_datetime] = ?\n"
                        + "      ,[location] = ?\n"
                        + "      ,[description] = ?\n"
                        + "      ,[updated_at] = GETDATE()\n"
                        + " WHERE id = ?";
                stm = connection.prepareStatement(sqlEvent);

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
                stm.setInt(6, event.getId());
                stm.executeUpdate();
            }

        } catch (Exception e) {
            System.out.println("updateEvent(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }

                if (stmDeleteAllAttendees != null) {
                    stmDeleteAllAttendees.close();
                }

                if (stmFindAllAttendees != null) {
                    stmFindAllAttendees.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<Event> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Event findById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Event event) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(int id) {
        try {
            if (id != -1) {
                String sql = "DELETE FROM event_user WHERE event_id = ?";
                stmDeleteAll = connection.prepareStatement(sql);
                stmDeleteAll.setInt(1, id);
                stmDeleteAll.executeUpdate();

                String sqlEvent = "DELETE FROM events WHERE id = ?";
                stm = connection.prepareStatement(sqlEvent);
                stm.setInt(1, id);
                stm.executeUpdate();

            }
        } catch (Exception e) {
            System.out.println("delete(): " + e.getMessage());
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }

                if (stmDeleteAll != null) {
                    stmDeleteAll.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void insert(Event model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static void main(String[] args) {
        EventDAO edao = new EventDAO();
        List<Event> event = edao.search(1, "ORGANIZER", "ATTENDEES", "diennv");
        
        
        
        

    }

}
