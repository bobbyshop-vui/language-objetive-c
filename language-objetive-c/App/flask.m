#import <Foundation/Foundation.h>
#import "flask.h"

@implementation Flask

- (void)startPythonServer:(NSString *)scriptPath {
    if (!scriptPath || scriptPath.length == 0) {
        NSLog(@"Invalid Python script path");
        return;
    }

    // Kiểm tra xem lệnh python3 có sẵn không trong hệ thống (mặc định là python3)
    NSString *pythonCommand = @"python3";  // Sử dụng python3 thay vì chỉ định đường dẫn cụ thể

    // Tạo NSTask để chạy lệnh python3
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/env"];  // Sử dụng /usr/bin/env để tự động tìm python3 trong hệ thống

    // Truyền các tham số cho lệnh python3 và đường dẫn script
    [task setArguments:@[pythonCommand, scriptPath]];

    // Khởi chạy tác vụ
    @try {
        [task launch];
        [task waitUntilExit];  // Chờ cho đến khi script Python hoàn thành
        NSLog(@"Python script executed successfully");
    } @catch (NSException *exception) {
        NSLog(@"Failed to execute Python script: %@", exception.reason);
    }
}

@end
