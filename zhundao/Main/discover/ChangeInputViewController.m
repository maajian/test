//
//  ChangeInputViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChangeInputViewController.h"

@interface ChangeInputViewController ()<UITextViewDelegate>
{
    BOOL switchFlag;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;


@end

@implementation ChangeInputViewController
- (IBAction)cancelButton:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sureButton:(id)sender {
    if ([_textView.text isEqualToString:@"请输入项目名称"]||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        DDLogVerbose(@"不能为空");
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
- (void)sendData{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setObject:_textView.text forKey:@"Title"];
    [sendDic setValue:[NSString stringWithFormat:@"%li",(long)_model.InputType] forKey:@"InputType"];
    [sendDic setObject:[NSString stringWithFormat:@"%li",(long)_model.ID] forKey:@"ID"];
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
        DDLogVerbose(@"res = %@",obj);
        if (self.block) {
            self.block([sendDic copy]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(NSError *error) {
        
    }];
}
- (void)begin
{
    if (_model.Required) {
        switchFlag =YES;
        [_switchButton setOn:YES];
    }
    else{
        switchFlag=NO;
        [_switchButton setOn:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text =_model.Title;
    _textView.delegate =self;
    [self begin];
    [self setMianTitle];
     [_switchButton addTarget:self action:@selector(SwitchChange) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}
- (void)setMianTitle
{
    switch (_model.InputType) {
        case 0:
            _titleLabel.text= @"单文本";
            break;
        case 1:
            _titleLabel.text= @"多文本";
            break;
        case 4:
            _titleLabel.text = @"图片";
            break;
        case 6:
            _titleLabel.text = @"日期";
        case 7:
            _titleLabel.text = @"数字";
        default:
            break;
    }
}
- (void)SwitchChange
{
    switchFlag = !switchFlag;
    if (switchFlag==NO) {
        [_switchButton setOn:NO];
    }
    else{
        [_switchButton setOn:YES];
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
