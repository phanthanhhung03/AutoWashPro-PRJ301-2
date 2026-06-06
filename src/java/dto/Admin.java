
package dto;
import java.sql.Date;
public class Admin {
    // 1. Khai báo các thuộc tính (khớp với các cột trong Database)
    private int adminID;
    private String fullName;
    private String email;
    private String password;
    private boolean status;
    private Date createdAt;

    // 2. Hàm khởi tạo rỗng (Bắt buộc phải có để Java có thể tạo Object trống)
    public Admin() {
    }

    // 3. Hàm khởi tạo đầy đủ tham số (Dùng khi cần tạo nhanh Object)
    public Admin(int adminID, String fullName, String email, String password, boolean status, Date createdAt) {
        this.adminID = adminID;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.status = status;
        this.createdAt = createdAt;
    }

    // 4. Các hàm Getters và Setters (Dùng để lấy và gán giá trị)
    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isStatus() {
        return status; // Lưu ý: Kiểu boolean thì hàm get thường được viết là is...
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // 5. Hàm toString (Hỗ trợ in ra console để debug tìm lỗi cho nhanh)
    @Override
    public String toString() {
        return "Admin{" + "adminID=" + adminID + ", fullName=" + fullName + ", email=" + email + ", status=" + status + '}';
    }
}
