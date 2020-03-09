//
//  MoreLabelViewController.m
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MoreLabelViewController.h"
@interface MoreLabelViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)NSString *placeHStr;
@end

@implementation MoreLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.textView];
    if (_isADMark) {
        self.title = @"管理员备注";
        _placeHStr = @"请输入管理员备注";
    }else{
          self.title = @"多文本";
        _placeHStr = @"请输入多文本";
    }
    [self leftButton];
    // Do any additional setup after loading the view.
}
#pragma mark 自定义返回
- (void)leftButton {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
-(void)backAction
{
    if (_isMust) {  //必须填写 则不能返回空内容
        if ([_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
            maskLabel *label = [[maskLabel alloc]initWithTitle:@"输入框不能为空"];
            [label labelAnimationWithViewlong:self.view];
        }else [self backWithBlock];
    }
    if (!_isMust) [self backWithBlock];
}
- (void)backWithBlock
{
    if (_strBlock) {
        _strBlock(_textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 懒加载
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 70)];
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = KweixinFont(15);
        [_textView becomeFirstResponder];
        if ([_textfTitle isEqualToString:@"未填写*"]||[_textfTitle isEqualToString:@"未填写"]||[_textfTitle isEqualToString:@""]) {
            _textView.text = @"";
        }
        else{
            _textView.text = _textfTitle;
        }
    }
    return _textView;
}

#pragma mark textview delegate

-(void)textViewDidBeginEditing:(UITextView *)textView

{
    if ([textView.text isEqualToString:_placeHStr]) {
        textView.text = @"";
    }
    _textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView

{
    if (textView.text.length<1) {
        textView.text = _placeHStr;
        _textView.textColor = [UIColor lightGrayColor];
    }
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
