//
//  ZDImageSettingsController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDImageSettingsController;

@protocol ZDImageSettingsControllerDelegate <NSObject>

- (void)lm_imageSettingsController:(ZDImageSettingsController *)viewController presentPreview:(UIViewController *)previewController;
- (void)lm_imageSettingsController:(ZDImageSettingsController *)viewController insertImage:(UIImage *)image;

- (void)lm_imageSettingsController:(ZDImageSettingsController *)viewController presentImagePickerView:(UIViewController *)picker;
//- (void)lm_imageSettingsController:(ZDImageSettingsController *)viewController dismissImagePickerView:(UIViewController *)picker;

@end

@interface ZDImageSettingsController : UIViewController

@property (nonatomic, weak) id<ZDImageSettingsControllerDelegate> delegate;
- (void)reload;

@end
