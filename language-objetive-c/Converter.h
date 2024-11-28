//  Converter.h
//  Python-objective-c
//
//  Created by Bobby on 2024/11/13.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject

// Phương thức để chuyển mã Python sang mã Objective-C
- (NSString *)convertPythonToObjC:(NSString *)pythonCode;

@end
