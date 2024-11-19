# Shoppingapp

**Ứng dụng kinh doanh đồ dùng công nghệ**

Đồ án là một ứng dụng thương mại điện tử  trên di động với mặt hàng sản phẩm là thức ăn, đồ uống, với giao diện hiện đại, bắt mắt nhưng vẫn đảm bảo tính thân thiện và dễ sử dụng.  Vì không gian hạn chế trên các thiết bị di động nên để mang lại trải nghiệm tốt nhất cho người dùng, ứng dụng hạn chế thể hiện quá nhiều thông tin trên một màn hình mà thay vào đó là chia ra nhiều loại màn hình chuyên dụng khác nhau kết nối với nhau một cách đơn giản và hợp lý.

---

## **Tính năng chính**

### 1. Dành cho người dùng
- **Tìm kiếm sản phẩm:** Hỗ trợ tìm kiếm sản phẩm theo tên.
- **Xem thông tin sản phẩm:** Hiển thị chi tiết sản phẩm, bao gồm giá, mô tả và hình ảnh.
- **Thêm vào giỏ hàng:** Dễ dàng thêm sản phẩm vào giỏ hàng để mua sắm.
- **Thanh toán:** Hỗ trợ hiển thị giá cả sản phẩm rõ ràng và nút "Mua ngay".
- **Chatbot** hỏi các vấn đề liên quan  về giá ...
-**xem trạng thái đơn hàng** Xem trạng thái đơn hàng đã xác  nhận được hay chưa


### 2. Quản lý
- **Phân loại sản phẩm:** Danh mục rõ ràng giúp người dùng tìm kiếm và lựa chọn sản phẩm dễ dàng.
- **Hỗ trợ Firebase:** Lấy dữ liệu từ Firestore để hiển thị sản phẩm.
-**Thống kê doanh thu** Thống kê doanh thu đơn hàng thành công
-**Thống kê đơn hàng** Thống kê các loại đơn hàng
-**Duyệt đơn hàng** Duyệt đơn hàng hoặc hủy đơn hàng
-**Thêm sửa xóa** Thêm sửa xóa các loại sản phẩm

---

## **Công nghệ sử dụng**

- **Frontend:** Flutter, Dart.
- **Backend:** Firebase Firestore.
- **Thư viện hỗ trợ:**
   - `.env`: Lưu trữ thông tin người dùng.
   - `cloud_firestore`: Tích hợp cơ sở dữ liệu Firebase Firestore.
   - `ngrok`: Domain để chạy chatbot 

---

## **Cài đặt và chạy ứng dụng**

### 1. Cài đặt môi trường
- **Flutter SDK:** Cài đặt Flutter trên máy theo hướng dẫn tại [Flutter.dev](https://docs.flutter.dev/get-started/install).
- **Firebase:**
   - Tạo một dự án Firebase.
   - Cấu hình Firestore Database.
   - Tải file cấu hình Firebase (`google-services.json` cho Android, `GoogleService-Info.plist` cho iOS) và thêm vào dự án Flutter.

### 2. Cài đặt các gói
Trong thư mục dự án, chạy lệnh sau:

```pash
flutter pub get
```
### 3. Khởi chạy ứng dụng
a. **Khởi chạy Frontend**
   - Truy cập vào thư mục dự án `food`.
   - Cài đặt tất cả các gói cần thiết:
   ```bash
   flutter pub get
   ```
   - Chạy ứng dụng trên thiết bị mô phỏng hoặc thiết bị thật:
   ```bash
   flutter run
   ```
   - Lưu ý:
      - Đảm bảo thiết bị được kết nối với máy tính và chế độ **USB Debugging** được bật.
      - Nếu dùng thiết bị mô phỏng, hãy khởi chạy trình giả lập trước khi chạy lệnh.

b. **Cấu hình Backend**
- Đảm bảo đã cài đặt Firebase trên dự án Flutter.
- Thêm tệp cấu hình Firebase vào thư mục phù hợp:
   - Android: android/app/google-services.json.
   - iOS: ios/Runner/GoogleService-Info.plist.

- Truy cập Firebase Console, bật Firestore Database, và cấu hình các bộ sưu tập cần thiết:
   - Products: Lưu trữ thông tin sản phẩm.
   - Users: Lưu trữ thông tin người dùng.

- Chạy ứng dụng để kiểm tra kết nối Backend hoạt động.

c. **Kiểm tra ứng dụng**
- Mở ứng dụng trên thiết bị hoặc giả lập.
- Đảm bảo các chức năng chính hoạt động:
   - Tìm kiếm sản phẩm.
   - Duyệt danh mục sản phẩm.
   - Xem chi tiết sản phẩm.
   - Thêm sản phẩm vào giỏ hàng hoặc danh sách yêu thích.
   - Thanh toán 
   - Chat
   - Trạng thái đơn hàng
