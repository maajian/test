//
//  ZDMeDetailNoticeVC.m
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeDetailNoticeVC.h"
#import "NSString+HTML.h"

#import "ZDMeNoticeViewModel.h"

@interface ZDMeDetailNoticeVC ()
/*! textview */
@property(nonatomic,strong)UITextView *textView ;

@property(nonatomic,assign)BOOL isNeed;
/*! 富文本字符串 */
@property(nonatomic,strong) NSAttributedString *htmlStr;
 // 逻辑管理器
@property (nonatomic, strong) ZDMeNoticeViewModel *viewModel;

@end

@implementation ZDMeDetailNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[ZDMeNoticeViewModel alloc] init];
    self.view.backgroundColor  = ZDBackgroundColor;
    [self.view addSubview:self.textView];
    self.title = @"通知公告";
    [self customBack];
    if (_isNotificationPush) {
        [self netWork];
    } else {
        [self changeContent];
    }
}

#pragma mark ------懒加载
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10 , 0, kScreenWidth-20, kScreenHeight-64)];
        _textView.allowsEditingTextAttributes = NO;
        _textView.editable =NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.backgroundColor = ZDBackgroundColor;
        [_textView becomeFirstResponder];
    }
    return _textView;
}

#pragma mark --- 网络请求
- (void)netWork {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getNoticeDetail:_ID successBlock:^{
        _detail = weakSelf.viewModel.noticeModel.Detail;
        _detailTitle = weakSelf.viewModel.noticeModel.Title;
        _time = weakSelf.viewModel.noticeModel.AddTime;
        [self changeContent];
        
    } failBlock:^(NSString *error) {
        
    }];
}

- (void)changeContent {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _htmlStr= [NSString strToAttriWithStr:[NSString stringWithFormat:@"<head><style>img{width:%fpx !important;height:auto}</style></head>%@",CGRectGetWidth(_textView.frame),_detail]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setContent];
        });
    });
}

/*! 设置textview内容 */

- (void)setContent {
    
     NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 5;
    
    paragraphStyle1.paragraphSpacing = 5; //段落后面的间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"\n"];
    if (_detailTitle.length) {
        NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:_detailTitle attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName :paragraphStyle1}];
        [attributedString appendAttributedString:attributedString1];
        NSAttributedString *returnStr = [[NSAttributedString alloc]initWithString:@"\n"];
        [attributedString appendAttributedString:returnStr];
        NSAttributedString *timeString = [[NSAttributedString alloc]initWithString:_time attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kColorA(150, 150, 150, 1),NSParagraphStyleAttributeName :paragraphStyle1}];
        [attributedString appendAttributedString:timeString];
        NSAttributedString *returnStr1 = [[NSAttributedString alloc]initWithString:@"\n"];
        [attributedString appendAttributedString:returnStr1];
    }
   
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithAttributedString:_htmlStr];
    [str1 removeAttribute:NSFontAttributeName range:NSMakeRange(0, str1.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str1.length)];
    [attributedString appendAttributedString:str1];
    _textView.attributedText = attributedString;
    
    
}

#pragma mark 自定义返回按钮

-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}

- (void)backpop
{
    if (_isLoadBlock) {
        _isLoadBlock(_isNeed);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----保存是否已读
/*! mark 保存是否已读 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_ID) {
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"noticeState"]) {
            NSMutableArray *array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"noticeState"] mutableCopy];
            if ([array containsObject:@(_ID)]) {
                return;
            }else{
                [self savaState:array];
            }
            
        }else{
            NSMutableArray *array = [NSMutableArray array];
            [self savaState:array];
        }
    }
}
- (void)savaState :(NSMutableArray *)savaArray{
    [savaArray addObject:@(_ID)];
    _isNeed = YES;
    [[NSUserDefaults standardUserDefaults]setObject:savaArray forKey:@"noticeState"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



-(void)dealloc{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
