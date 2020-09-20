//
//  ZDActivityCustomInviteVM.m
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityCustomInviteVM.h"
#import "ZDDiscoverPriviteInviteViewModel.h"
#import "ZDDiscoverShowViewModel.h"
@interface ZDActivityCustomInviteVM()

@property(nonatomic,strong)ZDDiscoverPriviteInviteViewModel *viewModel;

@property(nonatomic,strong)ZDDiscoverShowViewModel *showViewModel;

@end

@implementation ZDActivityCustomInviteVM

- (instancetype)init{
    if (self = [super init]) {
        _viewModel = [[ZDDiscoverPriviteInviteViewModel alloc]init];
        _showViewModel = [[ZDDiscoverShowViewModel alloc]init];
    }
    return self;
}


- (NSArray *)getInviteFixWithIndex :(NSInteger)index{
    NSString *name = [self inviteNameWithIndex:index-2];
    NSArray *fixArray =  [_showViewModel writeFixArray:name];
    return fixArray;
}

- (NSArray *)getInviteCustomWithIndex :(NSInteger)index{
    NSString *name = [self inviteNameWithIndex:index-2];
    NSArray *customArray =  [_showViewModel writeCustomArray:name];
    return customArray;
}

- (UIImage *)getImageWithIndex :(NSInteger)index{
    NSString *name = [self inviteNameWithIndex:index-2];
    UIImage *image = [_viewModel writeImage:name ];
    return image;
}

- (NSString *)inviteNameWithIndex:(NSInteger)index{
    NSDictionary *dic = [self.viewModel writeNameFromPlist];
    NSArray *array = [dic.allValues copy];
    NSString *name = [array objectAtIndex:index];
    return name;
}

@end
