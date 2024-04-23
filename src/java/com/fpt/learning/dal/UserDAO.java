package com.fpt.learning.dal;

import com.fpt.learning.context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.fpt.learning.model.User;
import com.fpt.learning.utils.BcryptUtil;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO extends DBContext<User> {

    PreparedStatement stm;
    ResultSet rs;
    
    private BcryptUtil bcryptUtil = BcryptUtil.getInstance();

    @Override
    public List<User> findAll() {
        return null;  
    }
    
    public List<User> findAllAttendeens(int id) {
        List<User> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM users WHERE id != ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                users.add(user);
            }
            return users;
        } catch (Exception e) {
            System.out.println("findAllAttendeens(): " + e.getMessage());
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
    
    public List<User> findAllAttendeesByStatusAttendeesAndEventId(int eventId, String statusAttendees) {
        List<User> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM event_user eu INNER JOIN users u ON eu.user_id = u.id "
                    + "WHERE eu.event_id = ? AND eu.status = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setString(2, statusAttendees);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                users.add(user);
            }
            return users;
        } catch (Exception e) {
            System.out.println("findAllAttendeesByStatusAttendeesAndEventId(): " + e.getMessage());
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
    
    public User findOrganizerByRoleAndEventId(int eventId, String role) {
        try {
            String sql = "SELECT * FROM event_user eu INNER JOIN users u ON eu.user_id = u.id "
                    + "WHERE eu.event_id = ? AND eu.role = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventId);
            stm.setString(2, role);
            rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                return user;
            }
            
        } catch (Exception e) {
            System.out.println("findOrganizerByRoleAndEventId(): " + e.getMessage());
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

    @Override
    public User findById(int id) {
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "  FROM [dbo].[users]\n"
                    + "  WHERE [id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (Exception e) {
            System.out.println("findById(): " + e.getMessage());
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
    
    public User findAttendeesByUserIdAndEventIdAndRole(int userId, int eventId, String role) {
        try {
            String sql = "SELECT * FROM event_user eu JOIN users u ON eu.user_id = u.id "
                    + "WHERE u.id = ? AND eu.event_id = ? AND eu.role = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.setInt(2, eventId);
            stm.setString(3, role);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (Exception e) {
            System.out.println("findAttendeesByUserIdAndEventIdAndRole(): " + e.getMessage());
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

    @Override
    public void insert(User user) {
        try {
            String sql = "INSERT INTO [dbo].[users]\n"
                    + "           ([username]\n"
                    + "           ,[password]\n"
                    + "           ,[created_at])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,GETDATE())";
            stm = connection.prepareStatement(sql, stm.RETURN_GENERATED_KEYS);
            stm.setString(1, user.getUsername());
            stm.setString(2, user.getPassword());
            stm.executeUpdate();          

        } catch (Exception e) {
            System.out.println("insert(): " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    @Override
    public void update(User model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public User findByUsername(String value) {
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "  FROM [dbo].[users]\n"
                    + "  WHERE [username] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, value);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (Exception e) {
            System.out.println("findByUsername(): " + e.getMessage());
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

    public boolean login(String username, String password) {
        User user = findByUsername(username);
        if (user != null) {
            return bcryptUtil.checkPassword(password, user.getPassword());
        }
        return false;
    }

    public static void main(String[] args) {
        UserDAO udao = new UserDAO();
        User user = new User();
        user.setUsername("nguyendien920");
        user.setPassword("abcd12345");
        if (udao.login("diennvhe171038", "abcd12345")) {

            System.out.println("success");
        } else {
            System.out.println("failed");
        }
    }

}
