#import "PGMedalWallTable.h"
#import "PGMeQQPopMenuView.h"
#import "PGMePopMenuTableViewCell.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
static CGFloat const kCellHeight = 44;
@interface PGMeQQPopMenuView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, assign) CGPoint trianglePoint;
@property (nonatomic, copy) void(^action)(NSInteger index);
@end
@implementation PGMeQQPopMenuView
- (instancetype)initWithItems:(NSArray <NSDictionary *>*)array
                        width:(CGFloat)width
             triangleLocation:(CGPoint)point
                       action:(void(^)(NSInteger index))action
{
    if (array.count == 0) {
        return nil;
    }
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.alpha = 0;
        _tableData = [array copy];
        _trianglePoint = point;
        self.action = action;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - width - 5, point.y + 10, width, kCellHeight * array.count) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kCellHeight;
        [_tableView registerNib:[UINib nibWithNibName:@"PGMePopMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"PGMePopMenuTableViewCell"];
        [self addSubview:_tableView];
    }
    return self;
}
+ (void)showWithItems:(NSArray <NSDictionary *>*)array
                width:(CGFloat)width
     triangleLocation:(CGPoint)point
               action:(void(^)(NSInteger index))action
{
    PGMeQQPopMenuView *view = [[PGMeQQPopMenuView alloc] initWithItems:array width:width triangleLocation:point action:action];
    [view show];
}
- (void)tap {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets maskTypeClearL7 = UIEdgeInsetsMake(81,47,139,112); 
        UITextFieldViewMode lineFragmentOriginK2 = UITextFieldViewModeAlways; 
    PGMedalWallTable *dataViewModel= [[PGMedalWallTable alloc] init];
[dataViewModel articleDailyTrainWithplayerStateFailed:maskTypeClearL7 strikethroughStyleAttribute:lineFragmentOriginK2 ];
});
    [self hide];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return NO;
    }
    return YES;
}
#pragma mark - Show or Hide
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _tableView.layer.position = CGPointMake(SCREEN_WIDTH - 5, _trianglePoint.y + 10);
    _tableView.layer.anchorPoint = CGPointMake(1, 0);
    _tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        _tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (void)hide {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets receiveScriptMessagep9 = UIEdgeInsetsZero;
        UITextFieldViewMode tableViewStyleL2 = UITextFieldViewModeAlways; 
    PGMedalWallTable *numberBadgeWith= [[PGMedalWallTable alloc] init];
[numberBadgeWith articleDailyTrainWithplayerStateFailed:receiveScriptMessagep9 strikethroughStyleAttribute:tableViewStyleL2 ];
});
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [_tableView removeFromSuperview];
        [self removeFromSuperview];
        if (self.hideHandle) {
            self.hideHandle();
        }
    }];
}
#pragma mark - Draw triangle
- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGPoint point = _trianglePoint;
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x - 10, point.y + 10);
    CGContextAddLineToPoint(context, point.x + 10, point.y + 10);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PGMePopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PGMePopMenuTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = _tableData[indexPath.row];
    cell.leftImageView.image = [UIImage imageNamed:dic[@"imageName"]];
    cell.titleLabel.text = dic[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
    if (_action) {
        _action(indexPath.row);
    }
}
@end
