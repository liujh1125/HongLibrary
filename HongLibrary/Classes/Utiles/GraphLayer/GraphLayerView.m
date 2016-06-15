//
//  GraphLayerView.m
//  Pods
//
//  Created by JHong on 16/2/25.
//
//

#import "GraphLayerView.h"

@implementation GraphLayerView{
    
    CAShapeLayer *shapeLayer;
    UIBezierPath *bezierPath;
    
    NSTimer *circleTimer;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupLayer];
        
    }
    return self;
}

-(void)setupLayer{
    
    shapeLayer = [CAShapeLayer new];
    shapeLayer.fillColor = nil;
    shapeLayer.frame = self.bounds;
    [self.layer addSublayer:shapeLayer];
}

// 画进度条圆行
-(void)setCircle:(UIColor*)sColor Width:(CGFloat)width percent:(CGFloat)percent{
    
    
    shapeLayer.lineCap = kCALineCapRound;       // 边缘线的类型
    shapeLayer.lineWidth = width;               // 线条宽度
    shapeLayer.strokeColor = sColor.CGColor;    // 边缘线的颜色
    
    bezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - width)/ 2 startAngle:-M_PI_2 endAngle:(M_PI * 2) * percent - M_PI_2 clockwise:YES];;
    shapeLayer.path = bezierPath.CGPath;
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}




// 画矩形
-(void)drawRectangle{
}








- (void)setTrackColor:(UIColor *)trackColor
{
    
}


- (void)setProgress:(float)progress animated:(BOOL)animated
{
    
}

@end
