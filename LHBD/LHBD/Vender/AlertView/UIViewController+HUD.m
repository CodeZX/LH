//
//  XTViewController+HUD.m
//  Unionpay
//
//  Created by 青 秀斌 on 13-5-24.
//  Copyright (c) 2013年 深圳元度科技有限公司. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "SVProgressHUD.h"
//#import "LoadingView.h"
//#import "BGLoadingView.h"
#import "TKAlertCenter.h"


@implementation UIViewController (HUD)


//HUD Methods
- (void)showLoadingWithMessage:(NSString *)message{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

    //    [LoadingView showLoadingMessage:message inView:self.view];
}

- (void)showSuccessWithMessage:(NSString *)message{
    [SVProgressHUD showSuccessWithStatus:message];
//    [SVProgressHUD showSuccessWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
    //    [LoadingView showSuccessMessage:message inView:self.view];
}

- (void)showFailedWithMessage:(NSString *)message{
    [SVProgressHUD showErrorWithStatus:message];
    //    [LoadingView showFailedMessage:message inView:self.view];
}

- (void)hideLoading{
    [SVProgressHUD dismiss];
    //    [LoadingView hideInView:self.view animated:YES];
}

//HUD Methods
- (void)showBGLoadingWithMessage:(NSString *)message{
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
}

- (void)showBGFailedWithMessage:(NSString *)message{
    //    [BGLoadingView showFailedMessage:message inView:self.view];
}

- (void)showBGInfoWithMessage:(NSString *)message{
    //    [BGLoadingView showInfoMessage:message inView:self.view];
}

- (void)showBGNoInfo{
    //    [BGLoadingView showNoInfoInView:self.view];
}

- (void)hideBGLoading{
    //    [BGLoadingView hideInView:self.view animated:NO];
}

//Toast Methods
- (void)showToast:(NSString *)message{
    //    [self showToast:message];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
}




-(void)showAlert:(nonnull NSString *)alertTitle
    alertMessage:(nonnull NSString *)alertMessage
        okAction:(nullable void (^)(UIAlertAction  * _Nullable action))oAction
    cancelAction:(nullable void (^)(UIAlertAction  * _Nullable action))cAction
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:alertTitle
                                          message:alertMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:oAction];
    
    
    
    
    [alertController addAction:okAction];
    
    if (cAction) {
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:cAction];
        [alertController addAction:cancelAction];
    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}




-(void)showAlert:(nonnull NSString *)alertTitle
    alertMessage:(nonnull NSString *)alertMessage
   customOKTitle:(nullable NSString *)customOKTitle
customCancelTitle:(nullable NSString *)customCancelTitle
        okAction:(nullable void (^)(UIAlertAction * _Nullable action))oAction
    cancelAction:(nullable void (^)(UIAlertAction * _Nullable action))cAction
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:alertTitle
                                          message:alertMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(customOKTitle, @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:oAction];
    
    
    
    
    [alertController addAction:okAction];
    
    if (cAction) {
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(customCancelTitle, @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:cAction];
        [alertController addAction:cancelAction];
    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



@end
