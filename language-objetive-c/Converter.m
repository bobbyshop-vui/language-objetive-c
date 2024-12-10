#import "Converter.h"

@implementation Converter

- (NSString *)convertPythonToObjC:(NSString *)pythonCode {
    NSMutableString *objCCode = [NSMutableString string];
    NSArray *lines = [pythonCode componentsSeparatedByString:@"\n"];
    BOOL importProcessed = NO;

    for (NSString *line in lines) {
        if ([line hasPrefix:@"import "] && !importProcessed) {
            NSString *libraryName = [line substringWithRange:NSMakeRange(7, line.length - 7)];
            [objCCode appendFormat:@"#import %@\n", libraryName];
            importProcessed = YES;
        }
        else if ([line containsString:@"print("]) {
            NSScanner *scanner = [NSScanner scannerWithString:line];
            [scanner scanUpToString:@"(" intoString:nil];
            [scanner scanString:@"(" intoString:nil];
            NSString *message = @"";
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@")"] intoString:&message];
            [scanner scanString:@")" intoString:nil];
            NSString *newLine = [NSString stringWithFormat:@"NSLog(@\%@\);", message];
            [objCCode appendFormat:@"%@\n", newLine];
        }
        else if ([line containsString:@"("] && [line containsString:@")"] && ![line containsString:@"void "]) {
            [objCCode appendFormat:@"%@\n", line];
        }
        else {
            [objCCode appendFormat:@"%@\n", line];
        }
    }

    return objCCode;
}

@end
