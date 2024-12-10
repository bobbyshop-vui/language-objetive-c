#import <Foundation/Foundation.h>
#import "Converter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;

        // Đọc file main.py
        NSString *mainFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/App/main.loc.txt";
        NSString *mainCode = [NSString stringWithContentsOfFile:mainFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"Error reading file: %@", error.localizedDescription);
            return 1;
        }
        
        // Chuyển đổi mã Python sang Objective-C
        Converter *converter = [[Converter alloc] init];
        NSString *objcCode = [converter convertPythonToObjC:mainCode];
        
        // Lưu mã Objective-C vào ConvertedApp.m
        NSString *convertedFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/App/ConvertedApp.m";
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

        // Đọc tệp add-h.txt để lấy danh sách file .h
        NSString *addHFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/add-h.txt";
        NSString *addHContent = [NSString stringWithContentsOfFile:addHFilePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"Error reading add-h file: %@", error.localizedDescription);
            return 1;
        }

        NSArray *headerFiles = [addHContent componentsSeparatedByString:@"\n"];
        for (NSString *header in headerFiles) {
            if (header.length > 0) {
                [arguments addObject:@"-I"];
                [arguments addObject:header];
            }
        }

        // Đọc tệp add-m.txt để lấy danh sách file .m
        NSString *addMFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/add-m.txt";
        NSString *addMContent = [NSString stringWithContentsOfFile:addMFilePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"Error reading add-m file: %@", error.localizedDescription);
            return 1;
        }

        NSArray *sourceFiles = [addMContent componentsSeparatedByString:@"\n"];
        for (NSString *source in sourceFiles) {
            if (source.length > 0) {
                [arguments addObject:source];
            }
        }

        // Thêm tệp nguồn chính và tệp đích
        [arguments addObject:@"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/App/ConvertedApp.m"];
        [arguments addObject:@"-o"];
        [arguments addObject:@"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp"];

        // Cấu hình NSTask để gọi Apple clang
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/env"];
        [task setArguments:[@[@"gcc"] arrayByAddingObjectsFromArray:arguments]];

        // Chạy lệnh và chờ hoàn thành
        [task launch];
        [task waitUntilExit];
        
        if ([task terminationStatus] != 0) {
            NSLog(@"Clang command failed with exit code %d", [task terminationStatus]);
            return 1;
        }
        NSTask *runTask = [[NSTask alloc] init];
        [runTask setLaunchPath:@"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp"];
        [runTask launch];
        [runTask waitUntilExit];
        return 0;
    }
}
