#import "PGGuideBottomView.h"
//
//  PGActivityMoreLabelVC.m
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityMoreLabelVC.h"
@interface PGActivityMoreLabelVC ()<UITextViewDelegate>
@property (nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)NSString *placeHStr;
@end

@implementation PGActivityMoreLabelVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextField *trainParticularBottomj9= [[UITextField alloc] initWithFrame:CGRectMake(130,55,109,122)]; 
    trainParticularBottomj9.clearButtonMode = UITextFieldViewModeNever; 
    trainParticularBottomj9.textColor = [UIColor whiteColor]; 
    trainParticularBottomj9.font = [UIFont boldSystemFontOfSize:20];
    trainParticularBottomj9.textAlignment = NSTextAlignmentNatural; 
    trainParticularBottomj9.tintColor = [UIColor blackColor]; 
    trainParticularBottomj9.leftView = [[UIView alloc] initWithFrame:CGRectMake(135,242,190,52)];
     trainParticularBottomj9.leftViewMode = UITextFieldViewModeAlways; 
        CGRect sectionFooterHeightL1 = CGRectMake(250,8,155,113); 
    PGGuideBottomView *uploadSuccBlock= [[PGGuideBottomView alloc] init];
[uploadSuccBlock pg_postImageWithWithwithCommentObject:trainParticularBottomj9 gestureRecognizerState:sectionFooterHeightL1 ];
});
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
dispatch_async(dispatch_get_main_queue(), ^{
    UITextField *scriptMessageHandlerA8= [[UITextField alloc] initWithFrame:CGRectMake(160,47,147,25)]; 
    scriptMessageHandlerA8.clearButtonMode = UITextFieldViewModeNever; 
    scriptMessageHandlerA8.textColor = [UIColor whiteColor]; 
    scriptMessageHandlerA8.font = [UIFont boldSystemFontOfSize:20];
    scriptMessageHandlerA8.textAlignment = NSTextAlignmentNatural; 
    scriptMessageHandlerA8.tintColor = [UIColor blackColor]; 
    scriptMessageHandlerA8.leftView = [[UIView alloc] initWithFrame:CGRectMake(102,14,145,75)];
     scriptMessageHandlerA8.leftViewMode = UITextFieldViewModeAlways; 
        CGRect backButtonClickF5 = CGRectZero;
    PGGuideBottomView *withLongLong= [[PGGuideBottomView alloc] init];
[withLongLong pg_postImageWithWithwithCommentObject:scriptMessageHandlerA8 gestureRecognizerState:backButtonClickF5 ];
});
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
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"输入框不能为空"];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UITextField *currentDateStringb3= [[UITextField alloc] initWithFrame:CGRectZero]; 
    currentDateStringb3.clearButtonMode = UITextFieldViewModeNever; 
    currentDateStringb3.textColor = [UIColor whiteColor]; 
    currentDateStringb3.font = [UIFont boldSystemFontOfSize:20];
    currentDateStringb3.textAlignment = NSTextAlignmentNatural; 
    currentDateStringb3.tintColor = [UIColor blackColor]; 
    currentDateStringb3.leftView = [[UIView alloc] initWithFrame:CGRectMake(87,243,214,162)];
     currentDateStringb3.leftViewMode = UITextFieldViewModeAlways; 
        CGRect cropTypeWithU0 = CGRectZero;
    PGGuideBottomView *mutableParagraphStyle= [[PGGuideBottomView alloc] init];
[mutableParagraphStyle pg_postImageWithWithwithCommentObject:currentDateStringb3 gestureRecognizerState:cropTypeWithU0 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
