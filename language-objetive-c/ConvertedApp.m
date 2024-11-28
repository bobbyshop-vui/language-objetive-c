#import <Foundation/Foundation.h>

// Hàm cộng hai số
int add(int a, int b) {
    return a + b;
}

// Hàm mẫu Objective-C
void sampleObjectiveCFunction() {
    // In ra console bằng NSLog
    NSLog(@"This is Objective-C code running.");
NSLog(@"Hello");
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        sampleObjectiveCFunction();
        return 0;
    }
}

