//
//  ZDImagePreviewController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDImagePreviewController;
@class PHAsset;

@protocol ZDImagePreviewControllerDelegate <NSObject>

- (void)lm_previewController:(ZDImagePreviewController *)previewController dismissPreviewWithCancel:(BOOL)cancel;

@end

@interface ZDImagePreviewController : ZDBaseVC

@property (nonatomic, weak) id<ZDImagePreviewControllerDelegate> delegate;
@property (nonatomic, strong) PHAsset *asset;

@end
