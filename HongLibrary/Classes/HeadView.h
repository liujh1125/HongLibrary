//
//  HeadView.h
//  SFPay
//
//  Created by ssf-2 on 14-11-6.
//  Copyright (c) 2014年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>

@optional
/**
 *	@brief	左侧按钮响应函数
 */
- (void)responseLeftButton;

/**
 *	@brief	右侧按钮响应函数
 */
- (void)responseRightButton;

/**
 *	@brief	标题按扭响应函数
 */
- (void)responseTitleButton;


@end

@interface HeadView : UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIView *contentView;



@property (assign, nonatomic) IBOutlet id<HeadViewDelegate> delegate;

@end
