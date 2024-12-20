# Makefile

# Đường dẫn đến dự án Xcode
PROJECT = language-objective-c.xcodeproj

# Scheme của bạn (hãy thay đổi theo tên scheme của bạn trong Xcode)
SCHEME = language-objective-c

# Thư mục build nơi lưu file thực thi
BUILD_DIR = ./build/Debug

# Tên file thực thi (tên này sẽ tùy thuộc vào tên của file thực thi sau khi biên dịch)
EXECUTABLE = language-objective-c

# Biên dịch và chạy ứng dụng khi gọi make (mục tiêu mặc định)
all:
    # Biên dịch dự án với cấu hình Debug và chỉ định thư mục lưu file thực thi
    xcodebuild -project $(PROJECT) -scheme $(SCHEME) -configuration Debug -derivedDataPath $(BUILD_DIR)

    # Chạy ứng dụng
    ./$(BUILD_DIR)/$(EXECUTABLE)
