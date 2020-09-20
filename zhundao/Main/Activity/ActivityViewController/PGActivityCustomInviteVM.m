#import "PGUserInfoBottom.h"
//
//  PGActivityCustomInviteVM.m
//  zhundao
//
//  Created by zhundao on 2017/10/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityCustomInviteVM.h"
#import "PGDiscoverPriviteInviteViewModel.h"
#import "PGDiscoverShowViewModel.h"
@interface PGActivityCustomInviteVM()

@property(nonatomic,strong)PGDiscoverPriviteInviteViewModel *viewModel;

@property(nonatomic,strong)PGDiscoverShowViewModel *showViewModel;

@end

@implementation PGActivityCustomInviteVM

- (instancetype)init{
    if (self = [super init]) {
        _viewModel = [[PGDiscoverPriviteInviteViewModel alloc]init];
        _showViewModel = [[PGDiscoverShowViewModel alloc]init];
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
