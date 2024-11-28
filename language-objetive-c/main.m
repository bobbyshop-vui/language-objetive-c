#import <Foundation/Foundation.h>
#import "Converter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;

        NSString *mainFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/main.py";
        NSString *mainCode = [NSString stringWithContentsOfFile:mainFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"Error reading file: %@", error.localizedDescription);
            return 1;
        }
        
        Converter *converter = [[Converter alloc] init];
        NSString *objcCode = [converter convertPythonToObjC:mainCode];
        
        NSString *convertedFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp.m";
        BOOL success = [objcCode writeToFile:convertedFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (!success) {
            NSLog(@"Error writing to file: %@", error.localizedDescription);
            return 1;
        }
        
        NSString *libraryFilePath = @"/Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/library.txt";
        NSString *libraryContent = [NSString stringWithContentsOfFile:libraryFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"Error reading library file: %@", error.localizedDescription);
            return 1;
        }
        
        NSArray *libraries = [libraryContent componentsSeparatedByString:@"\n"];
        NSMutableString *clangCommand = [NSMutableString string];
        
        for (NSString *library in libraries) {
            if (library.length > 0) {
                [clangCommand appendFormat:@"-framework %@ ", library];
            }
        }
        
        [clangCommand appendFormat:@"-o /Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp /Volumes/Data/Laptrinh/App/language-objetive-c/language-objetive-c/ConvertedApp.m"];
        
        // Use NSTask to run the clang command
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/env"];
        [task setArguments:@[@"clang"]]; // Add clang arguments here
        [task setEnvironment:@{@"PATH": @"/usr/bin:/bin:/usr/sbin:/sbin"}];
        
        // Handle error properly
        [task launch];
        [task waitUntilExit];
        
        if ([task terminationStatus] != 0) {
            NSLog(@"Clang command failed with exit code %d", [task terminationStatus]);
            return 1;
        }
        
        return 0;
    }
}
