//
//  UIView+Message.m
//  SFPay
//
//  Created by white on 15-5-15.
//  Copyright (c) 2015年 SF. All rights reserved.
//

#import "ViewMessageUtiles.h"
#import "MBProgressHUD.h"
#import "DefineMacro.h"


@implementation UIView (MessageExt)

- (void)showError:(NSError *)error
{
    [self hideLoading];
    if (error) {
        id userInfo = [error userInfo];
        NSString *errorMsg ;
        if([userInfo objectForKey:NSLocalizedFailureReasonErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
        }else if([userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        }else{
            errorMsg = [error localizedDescription];
        }
        if(errorMsg){
            [self hideLoading];
            if([errorMsg isKindOfClass:[NSString class]]){
                errorMsg = [errorMsg stringByReplacingOccurrencesOfString:@"Error:" withString:@""];
                //用户取消不显示错误信息
                if (error.code != kCFURLErrorCancelled) {
                    if (error.code == kCFURLErrorNotConnectedToInternet || error.code == kCFURLErrorTimedOut || error.code == kCFURLErrorCannotConnectToHost || error.code == kCFURLErrorCannotFindHost || error.code == kCFURLErrorBadURL || error.code == kCFURLErrorNetworkConnectionLost || error.code == 3840) {
                        [self showText:errorMsg];
                    }else{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alertView show];
                    }
                }
                
            }
        }
    }
}

- (void)showError:(NSError *)error delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag
{
    [self hideLoading];
    if (error) {
        id userInfo = [error userInfo];
        NSString *errorMsg ;
        if([userInfo objectForKey:NSLocalizedFailureReasonErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
        }else if([userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        }else{
            errorMsg = [error localizedDescription];
        }
        if(errorMsg){
            [self hideLoading];
            if([errorMsg isKindOfClass:[NSString class]]){
                errorMsg = [errorMsg stringByReplacingOccurrencesOfString:@"Error:" withString:@""];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:delegate cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertView.tag = tag;
                [alertView show];
                //                [self showText:errorMsg];
            }
        }
    }
}

- (void)showError:(NSError *)error cancelButton:(NSString *)cancel otherButton:(NSString *)other delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag
{
    [self hideLoading];
    if (error) {
        id userInfo = [error userInfo];
        NSString *errorMsg ;
        if([userInfo objectForKey:NSLocalizedFailureReasonErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
        }else if([userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey]){
            errorMsg = [userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        }else{
            errorMsg = [error localizedDescription];
        }
        if(errorMsg){
            [self hideLoading];
            if([errorMsg isKindOfClass:[NSString class]]){
                errorMsg = [errorMsg stringByReplacingOccurrencesOfString:@"Error:" withString:@""];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:delegate cancelButtonTitle:cancel otherButtonTitles:other, nil];
                alertView.tag = tag;
                [alertView show];
            }
        }
    }
}

- (void)showErrorMessage:(NSString *)errorMessage{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)showLoading
{
    [self showLoadingWithText:nil respondTouch:NO];
}

- (void)showLoadingRespondTouch
{
    [self showLoadingWithText:nil respondTouch:YES];
}

- (void)showText:(NSString*)str
{
    [self hideLoading];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.text = str;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    label.font = font;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy};
    CGSize labelSize = CGSizeMake(0, 0);
    if (IS_IOS7LATER) {
        labelSize = [str boundingRectWithSize:CGSizeMake(250, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        labelSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(250, 999) lineBreakMode:NSLineBreakByWordWrapping];
    }
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = label;
    [hud hide:YES afterDelay:1];
}

- (void)showLoadingWithText:(NSString*)str respondTouch:(BOOL)isRespond
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.userInteractionEnabled = !isRespond;
    hud.labelText = str;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    
}

- (void)hideLoading
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}


@end
