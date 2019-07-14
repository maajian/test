//
//  XYViewController.m
//  zhundao
//
//  Created by zhundao on 2017/7/5.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "XYViewController.h"
#import "UITextField+TextLeftOffset_ffset.h"
#import "PrintVM.h"
@interface XYViewController ()
@property(nonatomic,strong)UITextField *tf1;
@property(nonatomic,strong)UITextField *tf2;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UILabel  *exLabel;

@property(nonatomic,strong)UIButton  *testButton ;
@end

@implementation XYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = zhundaoBackgroundColor;
    [self.view addSubview:self.tf1];
    [self.view addSubview:self.tf2];
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.exLabel];
    [self.view addSubview:self.testButton];
    [self setText];
    self.title  = @"打印调试";
    // Do any additional setup after loading the view.
}
#pragma mark 懒加载
- (UITextField *)tf1
{
    if (!_tf1) {
        _tf1 = [myTextField initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 44) placeholder:@"请输入x轴偏移值" font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        _tf1.layer.cornerRadius = 5;
        _tf1.layer.masksToBounds = YES;
        [_tf1 setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 20, 44) WithMode:UITextFieldViewModeAlways];
        _tf1.backgroundColor = [UIColor whiteColor];
        _tf1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _tf1;
}
- (UITextField *)tf2
{
    if (!_tf2) {
        _tf2 = [myTextField initWithFrame:CGRectMake(10, 84, kScreenWidth-20, 44) placeholder:@"请输入y轴偏移值" font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        _tf2.backgroundColor = [UIColor whiteColor];
        _tf2.layer.cornerRadius = 5;
        _tf2.layer.masksToBounds = YES;
         [_tf2 setTextOffsetWithLeftViewRect:CGRectMake(0, 0, 20, 44) WithMode:UITextFieldViewModeAlways];
        _tf2.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
    }
    return _tf2;
    
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [MyButton initWithButtonFrame:CGRectMake(10, 174, kScreenWidth-20, 44) title:@"保存" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor:zhundaoGreenColor cornerRadius:5 masksToBounds:YES];
    }
    return _sureBtn;
}

- (UILabel *)exLabel
{
    if (!_exLabel) {
        _exLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-200, 134, 180, 30)];
        _exLabel.font = [UIFont systemFontOfSize:11];
        _exLabel.textColor= zhundaoGreenColor;
        _exLabel.text = @"建议修改偏移值为5或-5的倍数";
        _exLabel.textAlignment =NSTextAlignmentRight;
    }
    return _exLabel;
    
}

- (UIButton *)testButton
{
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _testButton.frame = CGRectMake(kScreenWidth-100, 230, 80, 25);
        [_testButton setTitle:@"打印测试" forState:0];
        [_testButton setTitleColor:[UIColor whiteColor] forState:0];
        [_testButton setBackgroundColor:zhundaoGreenColor];
        _testButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _testButton.layer.cornerRadius = 5;
        _testButton.layer.masksToBounds = YES;
        [_testButton addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}
#pragma mark  -----打印 

- (void)print
{
    PrintVM *_ViewModel = [[PrintVM alloc]init];
     [_ViewModel printQRCode:@"m819993" name:@"准到科技" isPrint:YES offsetx:[_tf1.text intValue] offsety:[_tf2.text intValue]];
}
#pragma mark 设置输入框文本
- (void)setText
{
    
   NSString *x =  [[NSUserDefaults standardUserDefaults]objectForKey:@"printX"];
    _tf1.text = [NSString stringWithFormat:@"%@",x];
    NSString *y = [[NSUserDefaults standardUserDefaults]objectForKey:@"printY"];
    _tf2.text = [NSString stringWithFormat:@"%@",y];
}

#pragma mark 确定返回

- (void)sureAction
{
    NSString *str1 =[_tf1.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSString *str2 =[_tf2.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( ([str1 isEqualToString:@""]||[str1 isEqualToString:@"-"]) && ([str2 isEqualToString:@""]||[str2 isEqualToString:@"-"] )) {
        if ([_delegate respondsToSelector:@selector(backWithX:y:)]) {
            [_delegate backWithX:_tf1.text  y:_tf2.text];
        }
        [[NSUserDefaults standardUserDefaults]setObject:_tf1.text forKey:@"printX"];
        [[NSUserDefaults standardUserDefaults]setObject:_tf2.text  forKey:@"printY"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"请输入正确内容"];
        [label labelAnimationWithViewlong:self.view];
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
