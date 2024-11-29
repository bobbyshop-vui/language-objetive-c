//
//  main.m
//  language-objetive-c
//
//  Created by Bobby on 2024/11/29.
//
#import <Foundation/Foundation.h>
#import "Converter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;

        // Đọc file main.py
        NSString *mainFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/main.py";
        NSString *mainCode = [NSString stringWithContentsOfFile:mainFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"Error reading file: %@", error.localizedDescription);
            return 1;
        }
        
        // Chuyển đổi mã Python sang Objective-C
        Converter *converter = [[Converter alloc] init];
        NSString *objcCode = [converter convertPythonToObjC:mainCode];
        
        // Lưu mã Objective-C vào ConvertedApp.m
        NSString *convertedFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp.m";
        BOOL success = [objcCode writeToFile:convertedFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (!success) {
            NSLog(@"Error writing to file: %@", error.localizedDescription);
            return 1;
        }
        
        // Đọc danh sách framework từ library.txt
        NSString *libraryFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/library.txt";
        NSString *libraryContent = [NSString stringWithContentsOfFile:libraryFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"Error reading library file: %@", error.localizedDescription);
            return 1;
        }
        
        NSArray *libraries = [libraryContent componentsSeparatedByString:@"\n"];
        NSMutableArray *arguments = [NSMutableArray array];

        // Thêm framework vào arguments
        for (NSString *library in libraries) {
            if (library.length > 0) {
                [arguments addObject:@"-framework"];
                [arguments addObject:library];
            }
        }

        // Thêm tệp nguồn và tệp đích
        [arguments addObject:@"-o"];
        [arguments addObject:@"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp"];
        [arguments addObject:@"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp.m"];

        // Cấu hình NSTask để gọi clang qua /usr/bin/env
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/env"];
        [task setArguments:[@[@"clang"] arrayByAddingObjectsFromArray:arguments]];

        // Chạy lệnh và chờ hoàn thành
        [task launch];
        [task waitUntilExit];
        
        if ([task terminationStatus] != 0) {
            NSLog(@"Clang command failed with exit code %d", [task terminationStatus]);
            return 1;
        }
        
        return 0;
    }
}
