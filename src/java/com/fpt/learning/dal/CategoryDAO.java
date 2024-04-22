package com.fpt.learning.dal;

import com.fpt.learning.context.DBContext;
import com.fpt.learning.model.Category;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoryDAO extends DBContext<Category> {

    PreparedStatement stm;
    ResultSet rs;
    List<Category> categories = null;

    @Override
    public List<Category> findAll() {
        categories = new ArrayList<>();
        try {
            String sql = "SELECT * FROM categories";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setCategoryName(rs.getString("category_name"));
                categories.add(category);           
            }
            return categories;
        } catch (Exception e) {
            System.out.println("findAll(): " + e.getMessage());
        } finally {
            if (stm != null) {               
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }                
            }
        }
        return null;
    }

    @Override
    public Category findById(int id) {
        try {
            String sql = "SELECT * FROM categories WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setCategoryName(rs.getString("category_name"));
                return category;
            }
        } catch (Exception e) {
            System.out.println("findById(): " + e.getMessage());
        } finally {
            if (stm != null) {               
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }                
            }
        }
        return null;
    }

    @Override
    public void insert(Category category) {
        try {
            String sql = "INSERT INTO [dbo].[categories]\n"
                    + "           ([category_name]\n"
                    + "           ,[created_at])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,GETDATE())";
            stm = connection.prepareStatement(sql);
            stm.setString(1, category.getCategoryName());
            stm.executeUpdate();

 
        } catch (Exception e) {
            System.out.println("insert(): " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        
    }

    @Override
    public void update(Category model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public static void main(String[] args) {
        CategoryDAO cdao = new CategoryDAO();
        Category c = new Category();
        c.setCategoryName("Learing");
        cdao.insert(c);
    }

}
