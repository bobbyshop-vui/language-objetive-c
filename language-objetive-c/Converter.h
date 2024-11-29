//  Converter.h
//  Python-objective-c
//
//  Created by Bobby on 2024/11/13.
//
#ifndef Converter_h
#define Converter_h

#import <Foundation/Foundation.h>

@interface Converter : NSObject

// Phương thức để chuyển mã Python sang mã Objective-C
- (NSString *)convertPythonToObjC:(NSString *)pythonCode;

@end

#endif /* Converter_h */
