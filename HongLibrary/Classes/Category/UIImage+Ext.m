//
//  UIImage+Utility.m
//  Pods
//
//  Created by ssf-xiong on 15-6-17.
//
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)
+ (UIImage *)imageWithName:(NSString *)aName withBundleName:(NSString *)aBundleName{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@",aBundleName,aName]];
}

+ (UIImage *)imageWithColor:(UIColor *)maskColor ImgSize:(CGSize)size
{
    NSParameterAssert(maskColor != nil);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [maskColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width,size.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


- (UIImage *)cropToRect:(CGRect)rect
{
    CGImageRef imageRef   = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}


@end
