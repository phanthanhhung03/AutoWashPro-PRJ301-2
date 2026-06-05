
package dao;

import dto.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
    public Admin getAdmin(String email, String password) {
        Admin result = null;
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet table = null;

        try {
            // Step 1: Connect DB
            cn = dbutils.DBUtils.getConnection();

            if (cn == null) {
                System.out.println("not connect");
            }

            if (cn != null) {

                // Step 2: SQL (Truy vấn trực tiếp bảng Admins, cực kỳ đơn giản)
                String sql = "SELECT AdminID, FullName, Email, Password, Status, CreatedAt "
                           + "FROM Admins "
                           + "WHERE Email = ? AND Password = ?";

                // Step 3
                st = cn.prepareStatement(sql);

                st.setString(1, email);
                st.setString(2, password);

                // Step 4
                table = st.executeQuery();

                if (table.next()) {

                    // Create Admin Object
                    result = new Admin();
                    result.setAdminID(table.getInt("AdminID"));
                    result.setFullName(table.getString("FullName"));
                    result.setEmail(table.getString("Email"));
                    result.setPassword(table.getString("Password"));
                    result.setStatus(table.getBoolean("Status"));
                    result.setCreatedAt(table.getDate("CreatedAt"));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {

                if (table != null) {
                    table.close();
                }

                if (st != null) {
                    st.close();
                }

                if (cn != null) {
                    cn.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
