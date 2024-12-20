#import <Foundation/Foundation.h>
#import "flask.h"

// Hàm toàn cục với kiểu trả về void
void sampleObjectiveCFunction() {
    // In ra console bằng NSLog
    NSLog(@"This is Objective-C code running.");
NSLog(@"Hello!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // In ra thông báo động bằng NSLog
        NSLog(@"Hello!");

        // Cache SEL và IMP cho hàm sampleObjectiveCFunction
        SEL sampleFunctionSelector = @selector(sampleObjectiveCFunction);
        IMP sampleFunctionIMP = (IMP)sampleObjectiveCFunction;

        // Kiểm tra và gọi hàm sampleObjectiveCFunction() động bằng IMP đã cache
        if (sampleFunctionIMP) {
            // Hàm con trỏ với kiểu trả về void
            void (*functionPointer)(void) = (void (*)(void))sampleFunctionIMP;
            functionPointer();  // Gọi hàm thông qua function pointer
        }

        // Khởi tạo đối tượng Flask từ thư viện flask.h
        Flask *flaskServer = [[Flask alloc] init];
        
        // Đường dẫn đến script Flask
        NSString *scriptPath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/App/main.flask";
        
        // Cache SEL và IMP cho phương thức startPythonServer:
        SEL startServerSelector = @selector(startPythonServer:);
        IMP startServerIMP = [flaskServer methodForSelector:startServerSelector];
        
        // Gọi phương thức startPythonServer: động với IMP đã cache
        if (startServerIMP) {
            ((void (*)(id, SEL, NSString *))startServerIMP)(flaskServer, startServerSelector, scriptPath);
        }
    }
    return 0;
}

