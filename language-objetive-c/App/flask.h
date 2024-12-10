//
//  flask.h
//  language-objetive-c
//
//  Created by Bobby on 2024/12/08.
//

#ifndef flask_h
#define flask_h
#import <Foundation/Foundation.h>

@interface Flask : NSObject

- (void)startPythonServer:(NSString *)scriptPath;

@end
#endif /* flask_h */
