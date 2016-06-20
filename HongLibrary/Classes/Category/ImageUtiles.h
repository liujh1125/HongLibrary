//
//  UIImage+Utility.h
//  Pods
//
//  Created by ssf-xiong on 15-6-17.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Utiles)
+ (UIImage *)imageWithName:(NSString *)aName withBundleName:(NSString *)aBundleName;

+ (UIImage *)imageWithColor:(UIColor *)maskColor ImgSize:(CGSize)size;
- (UIImage *)cropToRect:(CGRect)rect;


@end
