//
//  ZDSignInModel.m
//  zhundao
//
//  Created by maj on 2019/7/28.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDSignInModel.h"

@implementation ZDSignInModel
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder {self = [super init];return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone {return [self yy_modelCopy]; }
- (NSUInteger)hash {return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object {return [self yy_modelIsEqual:object]; }
- (NSString *)description {return [self yy_modelDescription]; }

@end
