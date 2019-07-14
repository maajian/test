//
//  MessageContentCell.h
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageContentCell : UITableViewCell

@property (nonatomic, strong) MessageContentModel *model;

@end

NS_ASSUME_NONNULL_END
