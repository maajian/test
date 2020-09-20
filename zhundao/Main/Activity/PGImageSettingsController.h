//
//  PGImageSettingsController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGImageSettingsController;

@protocol PGImageSettingsControllerDelegate <NSObject>

- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentPreview:(UIViewController *)previewController;
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController insertImage:(UIImage *)image;

- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentImagePickerView:(UIViewController *)picker;
//- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController dismissImagePickerView:(UIViewController *)picker;

@end

@interface PGImageSettingsController : UIViewController

@property (nonatomic, weak) id<PGImageSettingsControllerDelegate> delegate;
- (void)reload;

@end
