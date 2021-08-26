//
//  ZDActivityMoreChioceVC+MoveItem.m
//  zhundao
//
//  Created by maj on 2021/3/31.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceVC+MoveItem.h"

#import "UIScrollView+Extension.h"
#import <objc/runtime.h>

#import "ZDActivityMoreChioceModel.h"

// 滚动方向
typedef NS_ENUM(NSInteger, WYAutoScroll) {
    WYAutoScrollUp,
    WYAutoScrollDown
};

@interface ZDActivityMoreChioceVC()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *cellImageView; // 截图
@property (nonatomic, strong) NSIndexPath *fromIndexPath;
@property (nonatomic, strong) NSIndexPath *toIndexPath;
@property (nonatomic, strong) NSIndexPath *oriIndexPath;
@property (nonatomic, strong) CADisplayLink *displayLink; // 定时器,做自动滑动
@property (nonatomic, assign) WYAutoScroll autoScroll; // 滚动方向

@end

@implementation ZDActivityMoreChioceVC (MoveItem)
#pragma mark getter setter
- (UIImageView *)cellImageView {
    return objc_getAssociatedObject(self, @selector(cellImageView));
}
- (void)setCellImageView:(UIImageView *)cellImageView {
    objc_setAssociatedObject(self, @selector(cellImageView), cellImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)fromIndexPath {
    return objc_getAssociatedObject(self, @selector(fromIndexPath));
}
- (void)setFromIndexPath:(NSIndexPath *)fromIndexPath {
    objc_setAssociatedObject(self, @selector(fromIndexPath), fromIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)toIndexPath {
    return objc_getAssociatedObject(self, @selector(toIndexPath));
}
- (void)setToIndexPath:(NSIndexPath *)toIndexPath {
    objc_setAssociatedObject(self, @selector(toIndexPath), toIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)oriIndexPath {
    return objc_getAssociatedObject(self, @selector(oriIndexPath));
}
- (void)setOriIndexPath:(NSIndexPath *)oriIndexPath {
    objc_setAssociatedObject(self, @selector(oriIndexPath), oriIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CADisplayLink *)displayLink {
    return objc_getAssociatedObject(self, @selector(displayLink));
}
- (void)setDisplayLink:(CADisplayLink *)displayLink {
    objc_setAssociatedObject(self, @selector(displayLink), displayLink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (WYAutoScroll)autoScroll {
    return [objc_getAssociatedObject(self, @selector(autoScroll)) integerValue];
}
- (void)setAutoScroll:(WYAutoScroll)autoScroll {
    objc_setAssociatedObject(self, @selector(autoScroll), @(autoScroll), OBJC_ASSOCIATION_ASSIGN);
}
- (UILongPressGestureRecognizer *)moveGestureRecognizer {
    return objc_getAssociatedObject(self, @selector(moveGestureRecognizer));
}
- (void)setMoveGestureRecognizer:(UILongPressGestureRecognizer *)moveGestureRecognizer {
    objc_setAssociatedObject(self, @selector(moveGestureRecognizer), moveGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - GestureRecognizer
- (void)addlongPressToMoveGes {
    self.moveGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveRow:)];
    self.moveGestureRecognizer.minimumPressDuration = 0.1;
    [self.tableView addGestureRecognizer:self.moveGestureRecognizer];
}

#pragma mark - Action
- (void)moveRow:(UILongPressGestureRecognizer *)sender {
    //获取点击的位置
    CGPoint point = [sender locationInView:self.tableView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        //根据手势点击的位置，获取被点击cell所在的indexPath
        self.fromIndexPath = [self.tableView indexPathForRowAtPoint:point];
        if (!self.fromIndexPath) return;
        ZDActivityMoreChioceModel *model = self.dataSource[self.fromIndexPath.section];
        if ((model.optionType == ZDActivityOptionTypeUser && self.fromIndexPath.row != 0)) {
            ZDActivityOptionModel *optionModel = model.userInfoOptionArray[self.fromIndexPath.row - 1];
            if (!optionModel.IsCheck) return;
        } else if (model.optionType == ZDActivityOptionTypeExtra) {
            ZDActivityOptionModel *optionModel = model.extraInfoOptionArray[self.fromIndexPath.row];
            if (!optionModel.IsCheck) return;
        } else {
            return;
        }
        if (kScreenWidth - point.x > 70) {
            return;
        }
        self.oriIndexPath = self.fromIndexPath;
        //根据indexPath获取cell
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.fromIndexPath];
        
        //创建一个imageView，imageView的image由cell渲染得来
        self.cellImageView = [self snapshotImage:cell];
        
        //更改imageView的中心点为手指点击位置
        __block CGPoint center = cell.center;
        self.cellImageView.center = center;
        [UIView animateWithDuration:0.25 animations:^{
            center.y = point.y;
            self.cellImageView.center = center;
            cell.alpha = 0.0;
        } completion:^(BOOL finished) {
            cell.hidden = YES;
        }];
        
    } else if (sender.state == UIGestureRecognizerStateChanged){
        // 根据手势的位置，获取手指移动到的cell的indexPath
        self.toIndexPath = [self.tableView indexPathForRowAtPoint:point];
        ZDActivityMoreChioceModel *oriModel = self.dataSource[self.oriIndexPath.section];
        ZDActivityMoreChioceModel *toModel = self.dataSource[self.toIndexPath.section];
        if (!self.toIndexPath) return;
        if ((oriModel.optionType == ZDActivityOptionTypeUser)) {
            if (toModel.optionType != ZDActivityOptionTypeUser || (toModel.optionType == ZDActivityOptionTypeUser && self.toIndexPath.row == 0)) {
                return;
            }
        } else if (oriModel.optionType == ZDActivityOptionTypeExtra) {
            if (toModel.optionType != ZDActivityOptionTypeExtra) {
                return;
            }
        } else {
            return;
        }
        
        // 更改imageView的中心点为手指点击位置
        CGPoint center = self.cellImageView.center;
        center.y = point.y;
        self.cellImageView.center = center;
        
        // 判断cell是否被拖拽到了tableView的边缘，如果是，则自动滚动tableView
        if ([self scrollToEdge]) {
            [self startTimerToScrollTableView];
        } else {
            [self.displayLink invalidate];
        }
        
        // 每次移动手指都要执行该判断，实时插入
        if (self.toIndexPath && ![self.toIndexPath isEqual:self.fromIndexPath])
            [self insertCellToIndexPath:self.toIndexPath];
       } else {
            [self.displayLink invalidate];
            //将隐藏的cell显示出来，并将imageView移除掉
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.fromIndexPath];
            cell.alpha = 0;
           self.oriIndexPath = nil;
            [UIView animateWithDuration:0.25 animations:^{
                cell.alpha = 1;
                self.cellImageView.center = cell.center;
            } completion:^(BOOL finished) {
                [self.cellImageView removeFromSuperview];
                self.cellImageView = nil;
                cell.hidden = NO;
                [self.tableView reloadData];
            }];
    }
}

#pragma mark - Public
- (BOOL)scrollToEdge {
    //imageView拖动到tableView顶部，且tableView没有滚动到最上面
    if ((CGRectGetMaxY(self.cellImageView.frame) > self.tableView.contentOffsetY + self.tableView.height - self.tableView.contentInset.bottom) && (self.tableView.contentOffsetY < self.tableView.contentSizeHeight - self.tableView.height + self.tableView.contentInset.bottom)) {
        self.autoScroll = WYAutoScrollDown;
        return YES;
    }
    
    //imageView拖动到tableView底部，且tableView没有滚动到最下面
//    WYLog(@"self.tableView.contentOffsetY = %f",self.tableView.contentOffsetY);
//    WYLog(@"-self.tableView.contentInset.top = %f", -self.tableView.contentInset.top);
    if ((self.cellImageView.origin.y < self.tableView.contentOffsetY + self.tableView.contentInset.top) && (self.tableView.contentOffsetY > -self.tableView.contentInset.top)) {
        self.autoScroll = WYAutoScrollUp;
        return YES;
    }
    return NO;
}
- (void)startTimerToScrollTableView {
    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(scrollTableView)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)scrollTableView{
    //如果已经滚动到最上面或最下面，则停止定时器并返回
    if ((self.autoScroll == WYAutoScrollUp && self.tableView.contentOffset.y <= -self.tableView.contentInset.top)
        || (self.autoScroll == WYAutoScrollDown && self.tableView.contentOffset.y >= self.tableView.contentSize.height - self.tableView.height + self.tableView.contentInset.bottom)) {
        [self.displayLink invalidate];
        return;
    }
    //改变tableView的contentOffset，实现自动滚动
    CGFloat height = self.autoScroll == WYAutoScrollUp? -8 : 8;
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + height)];
    //改变cellImageView的位置为手指所在位置
    self.cellImageView.center = CGPointMake(self.cellImageView.center.x, self.cellImageView.center.y + height);
    
    //滚动tableView的同时也要执行插入操作
    self.toIndexPath = [self.tableView indexPathForRowAtPoint:self.cellImageView.center];
    if (self.toIndexPath && ![self.toIndexPath isEqual:self.fromIndexPath])
        [self insertCellToIndexPath:self.toIndexPath];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.oriIndexPath) {
//
//    }
//}
- (void)insertCellToIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != self.oriIndexPath.section) {
        return;
    } else {
        ZDActivityMoreChioceModel *model = self.dataSource[self.oriIndexPath.section];
        if (model.optionType == ZDActivityOptionTypeUser && indexPath.row == 0) {
            return;
        }
        if (model.optionType == ZDActivityOptionTypeUser) {
            ZDActivityOptionModel *obj = model.userInfoOptionArray[self.fromIndexPath.row - 1];
            [model.userInfoOptionArray removeObjectAtIndex:self.fromIndexPath.row - 1];
            [model.userInfoOptionArray insertObject:obj atIndex:indexPath.row - 1];
        }
        if (model.optionType == ZDActivityOptionTypeExtra) {
            ZDActivityOptionModel *obj = model.extraInfoOptionArray[self.fromIndexPath.row];
            [model.extraInfoOptionArray removeObjectAtIndex:self.fromIndexPath.row];
            [model.extraInfoOptionArray insertObject:obj atIndex:indexPath.row];
        }
    }
    
    if (self.fromIndexPath.row > self.toIndexPath.row) {
        [self.tableView reloadRowsAtIndexPaths:@[self.fromIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        [self.tableView reloadRowsAtIndexPaths:@[self.fromIndexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.hidden = YES;
    self.fromIndexPath = indexPath;
}
- (UIImageView *)snapshotImage:(UITableViewCell *)cell {
    UIGraphicsBeginImageContextWithOptions(cell.size, NO, [[UIScreen mainScreen] scale]);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *cellImageView = [[UIImageView alloc] initWithImage:image];
    cellImageView.layer.shadowOffset = CGSizeMake(0, 4);
    cellImageView.layer.shadowRadius = 2;
    cellImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    cellImageView.layer.shadowOpacity = 0.1;
    [self.tableView addSubview:cellImageView];
    return cellImageView;
}

@end
