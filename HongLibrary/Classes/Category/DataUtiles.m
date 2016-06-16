//
//  NSData+Utiles.m
//  Pods
//
//  Created by ehmo on 16/6/16.
//
//

#import "DataUtiles.h"

@implementation NSData (Utiles)


- (NSString*)hexString {
    
    NSMutableString *str = [NSMutableString stringWithCapacity:64];
    NSUInteger length = [self length];
    char *bytes = malloc(sizeof(char) * length);
    
    [self getBytes:bytes length:length];
    
    for (int i = 0; i < length; i++) {
        [str appendFormat:@"%02.2hhx", bytes[i]];
    }
    free(bytes);
    
    return str;
}



@end
