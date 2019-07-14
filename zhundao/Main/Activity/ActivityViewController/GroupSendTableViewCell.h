//
//  GroupSendTableViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupSendTableViewCell;

@protocol GroupSendTableViewCellDelegate <NSObject>
- (void)tableViewCell:(GroupSendTableViewCell *)tableViewCell didSelectTextView:(UITextView *)textView;

@end
typedef void(^groupSendBlock) (NSInteger needCount,NSString *textStr);

@interface GroupSendTableViewCell : UITableViewCell
@property(nonatomic,copy)groupSendBlock groupSendBlock;
/*! 选择收信人和本次群发订单的label */
@property(nonatomic,strong)UILabel *leftLabel1;
/*! 所有cell的右边label */
@property(nonatomic,strong)UILabel *rightLabel;
/*! textView */
@property(nonatomic,strong)UITextView *TextView;
/*! textview字数 */
@property(nonatomic,strong)UILabel *wordLabel;
/*! 左边灰色的label */
@property(nonatomic,strong)UILabel *detailLabel;
/*! 群发签名 */
@property(nonatomic,strong)UILabel *groupSign;


/*! cell的位置 */
@property(nonatomic,strong)NSIndexPath *indexPath;
/*! 收信人数 */
@property(nonatomic,assign)NSInteger personCount;
/*! 短信条数 */
@property(nonatomic,assign)NSInteger messageCount;
/*! 签名字符串 */
@property(nonatomic,copy)NSString *signStr;

/*! 内容 */
@property(nonatomic,strong)NSString *textStr;
/*! 文本条数 */
@property(nonatomic,assign)NSInteger labelCount;

@property (nonatomic, weak) id<GroupSendTableViewCellDelegate> groupSendTableViewCellDelegate;

@end
