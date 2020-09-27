#import "PGScrollViewDeceleration.h"
#import "PGDiscoverTextVC.h"
#import "UITextView+BaseCreate.h"
static const NSInteger linespacing =3;
static const NSInteger paragraphSpacing =10;
@interface PGDiscoverTextVC ()
@property(nonatomic,strong)UITextView               *     textview ; 
@end
@implementation PGDiscoverTextVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode playerStateStoppedP1 = UITextFieldViewModeAlways; 
        NSTextAlignment recommendUserDatax4 = NSTextAlignmentCenter; 
    PGScrollViewDeceleration *listRequsetWith= [[PGScrollViewDeceleration alloc] init];
[listRequsetWith viewWillHiddenWithmessageWithUser:playerStateStoppedP1 infoBottomView:recommendUserDatax4 ];
});
    [super viewDidLoad];
    self.title = @"多点签到使用介绍";
    [self.view addSubview: self.textview];
    [self makeAttribute];
    self.view.backgroundColor = ZDBackgroundColor;
}
#pragma  懒加载   
-(UITextView *)textview
{
    if (!_textview) {
        _textview = [UITextView initWithFrame:CGRectMake(5, 0, kScreenWidth-10, kScreenHeight-64) WithText:@"      多点签到是准到科技研发的面向部分大型活动需要多个子签到员帮忙进行电子签到的一款插件。\n      主办方通过超级管理员账户进入准到PC平台配置好多点签到子管理员，并将系统设置的签到ID、手机密码发放给签到专员。 签到专员在此处进行登录。签到专员只能对来宾进行电子签到，可查看来宾的姓名和预设的管理员备注信息（如给来宾发放什么证件或者来宾座位是多少号等）,无法查询来宾完整手机和导出数据功能，从而确保了用户隐私安全。" WithTextColor:[UIColor blackColor] WithFont:KweixinFont(17) WithTextAlignment:NSTextAlignmentLeft withisCanedit:NO];
    }
    _textview.backgroundColor = [UIColor clearColor];
    return _textview;
}
- (void)makeAttribute
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = linespacing;   
    style.paragraphSpacing = paragraphSpacing;   
    NSDictionary *dic = @{NSForegroundColorAttributeName :  [UIColor blackColor],
                          NSParagraphStyleAttributeName :style,   
                          NSKernAttributeName :@0.5f,
                          NSFontAttributeName :KweixinFont(17)};  
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_textview.text attributes:dic];
    _textview.attributedText = str;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
