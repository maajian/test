//
//  InputFieldViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "InputFieldViewController.h"

#import "BaseNavigationViewController.h"
#import "UpDataViewController.h"
@interface InputFieldViewController ()<UITextViewDelegate>
{
     BOOL switchFlag;
}
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation InputFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = @"请输入项目名称";
    _textView.textColor = [UIColor lightGrayColor];
    _textView.delegate =self;
    switchFlag =YES;
    [self setTitle];
    [_switchButton addTarget:self action:@selector(SwitchChange) forControlEvents:UIControlEventValueChanged];
}


- (void)SwitchChange
{
    switchFlag = !switchFlag;
    NSLog(@"%i",switchFlag);
    if (switchFlag==NO) {
        [_switchButton setOn:NO];
    }
    else{
        [_switchButton setOn:YES];
    }
}


- (void)setTitle
{
    switch (_type) {
        case 0:
             self.titleLabel.text = @"单文本";
            break;
        case 6:
            self.titleLabel.text = @"日期";
            break;
        case 7:
            self.titleLabel.text = @"数字";
            break;
        default:
            break;
    }
}


- (void)sendData
{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setObject:_textView.text forKey:@"Title"];
    [sendDic setValue:@(_type) forKey:@"InputType"];

    if (switchFlag) {
        [sendDic setValue:@"true" forKey:@"Required"];
    }
    else{
        [sendDic setValue:@"false" forKey:@"Required"];
        
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[sendDic copy] options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSString *accesskey = [[SignManager shareManager]getaccseekey];
    NSString *posturl = [NSString stringWithFormat:@"%@api/PerActivity/UpdateOrAddOption?accessKey=%@",zhundaoApi,accesskey];
    
    [ZD_NetWorkM postDataWithMethod:posturl parameters:jsonStr succ:^(NSDictionary *obj) {
        NSLog(@"res = %@",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"Res"] integerValue] == 0) {
            NSInteger customID = [dic[@"Data"] integerValue];
            [sendDic setValue:[NSString stringWithFormat:@"%li",(long)customID] forKey:@"ID"];
            if (self.block) {
                self.block([sendDic copy]);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:dic[@"Msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UpDataViewController *updata = [[UpDataViewController alloc]init];
                updata.isPresent = YES;
                updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[SignManager shareManager] getaccseekey]];
                BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:updata];
                [self presentViewController:nav animated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } fail:^(NSError *error) {
        
    }];
}





- (IBAction)sureButton:(id)sender {
   
    if ([_textView.text isEqualToString:@"请输入项目名称"]||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        NSLog(@"不能为空");
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor blackColor];
        label.textColor =[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 6;
        label.layer.masksToBounds = YES;
        
        label.text = @"输入框不能为空";
        label.font = [UIFont boldSystemFontOfSize:16];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        label.alpha = 1;
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    } else if ([self.titleLabel.text isEqualToString:@"单文本"] && _textView.text.length > 50) {
        maskLabel *label = [[maskLabel alloc] initWithTitle:@"单文本字数不能超出50"];
        [label labelAnimationWithViewlong:self.view];
    } else
    {
        [self sendData];
    }
}

- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入项目名称"]) {
        textView.text = @"";
    }
    _textView.textColor = [UIColor blackColor];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        textView.text = @"请输入项目名称";
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
