//
//  UIView+Message.h
//  SFPay
//
//  Created by white on 15-5-15.
//  Copyright (c) 2015年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MessageExt)
/**
 @param str 加载框显示的文字
 @param isRespond 显示加载框时下面的内容是否可响应用户操作
 */
- (void)showLoadingWithText:(NSString*)str respondTouch:(BOOL)isRespond;

/**
 *	@brief	弹窗显示错误信息，确定可回调
 *
 *	@param 	error 	错误对象
 *	@param 	delegate 	代理
 *	@param 	tag 	弹窗识别标签
 */
- (void)showError:(NSError *)error delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag;

/**
 *	@brief	弹窗显示错误信息，可回调
 *
 *	@param 	error 	错误对象
 *	@param 	cancel 	取消按钮
 *	@param 	other 	其他接钮
 *	@param 	delegate 	代理
 *	@param 	tag 	弹窗识别标签
 */
- (void)showError:(NSError *)error cancelButton:(NSString *)cancel otherButton:(NSString *)other delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag;

/**
 显示加载中，加载过程中不响应用户操作
 */
- (void)showLoading;

/**
 显示加载中，加载过程中可响应用户操作
 */
- (void)showLoadingRespondTouch;

/**
 去掉加载中标志
 */
- (void)hideLoading;

/**
 显示文字提醒，2秒后消失
 */
- (void)showText:(NSString*)str;

/**
 显示错误提醒，2秒后消失
 */
- (void)showError:(NSError*)error;

/**
 显示错误提醒，点击确定后消失
 */
- (void)showErrorMessage:(NSString *)errorMessage;
@end
