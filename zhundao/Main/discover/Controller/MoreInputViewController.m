//
//  MoreInputViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MoreInputViewController.h"

#import "UpDataViewController.h"
#import "BaseNavigationViewController.h"
@interface MoreInputViewController ()<UITextViewDelegate>
{
    BOOL switchFlag;
}
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;


@end

@implementation MoreInputViewController
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
     
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
    }
    else
    {
       [self sendData];
    }
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
- (void)SwitchChange
{
    switchFlag = !switchFlag;
    NSLog(@"%i",switchFlag);
    if (switchFlag==NO) {
        [_switch1 setOn:NO];
    }
    else{
        [_switch1 setOn:YES];
    }
}
- (void)sendData
{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setObject:_textView.text forKey:@"Title"];
    [sendDic setValue:@"1" forKey:@"InputType"];
    
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:obj[@"Msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = @"请输入项目名称";
    _textView.textColor = [UIColor lightGrayColor];
    _textView.delegate =self;
    switchFlag =YES;
    
    [_switch1 addTarget:self action:@selector(SwitchChange) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
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
