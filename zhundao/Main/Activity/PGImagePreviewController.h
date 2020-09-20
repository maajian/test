//
//  PGImagePreviewController.h
//  SimpleWord
//
//  Created by Chenly on 16/5/16.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGImagePreviewController;
@class PHAsset;

@protocol PGImagePreviewControllerDelegate <NSObject>

- (void)lm_previewController:(PGImagePreviewController *)previewController dismissPreviewWithCancel:(BOOL)cancel;

@end

@interface PGImagePreviewController : PGBaseVC

@property (nonatomic, weak) id<PGImagePreviewControllerDelegate> delegate;
@property (nonatomic, strong) PHAsset *asset;

@end
