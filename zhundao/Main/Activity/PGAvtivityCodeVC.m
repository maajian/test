//
//  PGAvtivityCodeVC.m
//  zhundao
//
//  Created by zhundao on 2017/2/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGAvtivityCodeVC.h"
#import "UIImage+LXDCreateBarcode.h"
#import "PGMaskLabel.h"
#import <Photos/Photos.h>

@interface PGAvtivityCodeVC ()
{
    UIImageView *imageView;
}
@end

@implementation PGAvtivityCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZDBackgroundColor;
    [self setimage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setimage
{
    
    UIImage * image1 = [UIImage imageOfQRFromURL:_imagestr codeSize: 1000 red: 0 green: 0 blue: 0 insertImage: nil roundRadius: 15.0f];
    CGSize size = image1.size;
    imageView = [[UIImageView alloc] init];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    imageView.bounds = CGRectMake(0, 0, size.width, size.height);
    imageView.image = image1;
    [self.view addSubview: imageView];
    CGFloat imageViewMinX =CGRectGetMinX(imageView.frame);
     CGFloat imageViewMaxY =CGRectGetMaxY(imageView.frame);
    CGFloat imageViewMinY =CGRectGetMinY(imageView.frame);
    CGFloat imageViewWidth =CGRectGetWidth(imageView.frame);
    CGFloat imageViewHeight =CGRectGetHeight(imageView.frame);
    
    UIView *BackView = [[UIView alloc]initWithFrame:CGRectMake(imageViewMinX-20, imageViewMinY-80, imageViewWidth+40, imageViewHeight+160)];
    [self.view insertSubview:BackView atIndex:0];
    BackView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewMinX-17, imageViewMinY-40, imageViewWidth+34, 30)];   //普通label
    titleLabel.text = _labelStr;
    titleLabel.textColor = ZDGrayColor;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, imageViewWidth+40, 40)];   // 报名名称label
    label1.text =self.titlestr;
    label1.font = [UIFont systemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [BackView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageViewMinX-20, imageViewMaxY, imageViewWidth+40, 40)];  // 扫码提示label
    label2.text = self.hideLabel ? [NSString stringWithFormat:@"扫一扫上面的二维码，进行%@",_labelStr] : @"";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = ZDGrayColor;
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, imageViewHeight+120, imageViewWidth+40, 40)];   //保存按钮
    [BackView addSubview:button];
    [button setTitle:@"保存图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveImageWithFrame) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithRed:109.00f/255.0f green:180.00f/255.0f blue:0.00f/255.0f alpha:1]];
   
//    UIButton *VIPButton = [[UIButton alloc]initWithFrame:CGRectMake(0, imageViewHeight+170, imageViewWidth+40, 40)];   //保存按钮
//    [BackView addSubview:button];
//    [button setTitle:@"保存图片" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(saveImageWithFrame) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor colorWithRed:109.00f/255.0f green:180.00f/255.0f blue:0.00f/255.0f alpha:1]];
    
    UIImageView *deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    deleteImage.image = [UIImage imageNamed:@"more删除1"];
    deleteImage.center = CGPointMake(CGRectGetMaxX(imageView.frame)+16, imageViewMinY-75);
    [self.view addSubview:deleteImage];
    BackView.layer.cornerRadius = 5;
    BackView.layer.masksToBounds = YES;

}
- (void)saveImageWithFrame
{
    [[PGSignManager shareManager]saveImageWithFrame:imageView.frame WithCtr:self];
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
