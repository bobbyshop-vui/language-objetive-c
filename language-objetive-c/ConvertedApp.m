//import <Foundation/Foundation.h>
//import "flask.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Khởi tạo đối tượng Flask từ thư viện flask.h
        Flask *flaskServer = [[Flask alloc] init];
        
        // Đường dẫn đến script Flask
        NSString *scriptPath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/main.flask ";
        
        // Bắt đầu server Python Flask
        [flaskServer startPythonServer:scriptPath];
    }
    return 0;
}

