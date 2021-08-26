//
//  ZDMacro.h
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#ifndef ZDMacro_h
#define ZDMacro_h

typedef void(^ZDBlock_Void)();
typedef void(^ZDBlock_ID)(id obj);
typedef void(^ZDBlock_ID2)(id obj1, id obj2);
typedef void(^ZDBlock_BOOL)(BOOL obj);
typedef void(^ZDBlock_Int)(NSInteger obj);
typedef void(^ZDBlock_Num)(NSNumber *obj);
typedef void(^ZDBlock_Str)(NSString *obj);
typedef void(^ZDBlock_Arr)(NSArray *obj);
typedef void(^ZDBlock_Dic)(NSDictionary *obj);
typedef void(^ZDBlock_Error)(NSError *error);
typedef void(^ZDBlock_Error_Str)(NSString *error);
typedef void(^ZDBlock_TableView)(UITableView *tableView);

#pragma mark - /* Class **/
#define ZD_NotificationCenter        [NSNotificationCenter defaultCenter]
#define ZD_FileManager               [NSFileManager defaultManager]
#define ZD_Application               [UIApplication sharedApplication]
#define ZD_UserDefaults              [NSUserDefaults standardUserDefaults]
#define ZD_CurentDevice              [UIDevice currentDevice]
#define ZD_CurrentThread             [NSThread currentThread]
#define ZD_MainScreen                [UIScreen mainScreen]
#define ZD_MainBundle                [NSBundle mainBundle]
#define ZD_CurrentCalendar           [NSCalendar currentCalendar]
#define ZD_CurrentLocale             [NSLocale currentLocale]
#define ZD_SharedSingleton           [ZDSingleton sharedSingleton]

#pragma mark - /* Property **/
#define ZD_ScreenScale               [UIScreen mainScreen].scale
#define ZD_ScreenBounds              [UIScreen mainScreen].bounds
#define ZD_ScreenWidth               [UIScreen mainScreen].bounds.size.width
#define ZD_ScreenHeight              [UIScreen mainScreen].bounds.size.height
#define ZD_KeyWindow                 [UIApplication sharedApplication].keyWindow
#define ZD_SystemVerionFloatValue    [UIDevice currentDevice].systemVersion.floatValue
#define ZD_CountryCode               [[NSLocale componentsFromLocaleIdentifier:[NSLocale currentLocale].localeIdentifier] objectForKey:@"kCFLocaleCountryCodeKey"]

#pragma mark - /* Method **/
#define ZD_ClassName(classArg)           NSStringFromClass([classArg class])
#define ZD_IsKindOfClass(arg,classArg)   [arg isKindOfClass:[classArg class]]
#define ZD_ThreadCancelledThenReturn     if(ZD_CurrentThread.isCancelled) return;
#define ZD_Weak(obj)                     __weak typeof(obj) weak##obj = obj;
#define ZD_Strong(obj)                   __strong typeof(obj) strong##obj = weak##obj;
#define ZD_WeakSelf                      __weak typeof(self) weakSelf = self;
#define ZD_StrongSelf                    __strong typeof(weakSelf) strongSelf = weakSelf;
#define ZD_BOOL(boolV,yesV,noV)          ((boolV) ? (yesV) : (noV))
#define ZD_ContainOption(all, one)       ((all & one) == one)
#define ZD_SafeStringValue(arg)          [NSString stringWithFormat:@"%@", arg ?: @""]
#define ZD_SafeValue(arg)                arg ? arg: @""
#define ZD_Limit(arg,min,max)            (arg < min ? min : (arg > max ? max : arg))
#define ZD_IsChina                       [ZD_CountryCode isEqualToString:@"CN"]
#define ZD_IsMessageTimeout(arg,threshold)  (([[NSDate date] timeIntervalSince1970]*1000 - arg)/1000.0 > threshold)
#define ZD_IsEqualToString(arg,arg2)     [arg isEqualToString:arg2]

#pragma mark - /* Scalar **/
#define ZD_1_PIXEL                       (1.0 / ZD_ScreenScale)
#define ZD_SideViewController_Width      (ZD_ScreenWidth * 0.8)
#define ZD_Version_GreaterThanOrEqual_8  (ZD_SystemVerionFloatValue >= 8.0)
#define ZD_Version_GreaterThanOrEqual_9  (ZD_SystemVerionFloatValue >= 9.0)
#define ZD_Version_GreaterThanOrEqual_10 (ZD_SystemVerionFloatValue >= 10.0)
#define ZD_Version_GreaterThanOrEqual_11 (ZD_SystemVerionFloatValue >= 11.0)
#define ZD_iPhone_4                      (MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 480)
#define ZD_iPhone_5                      (MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 568)
#define ZD_iPhone_6                      (MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 667)
#define ZD_iPhone_6P                     (MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 736)
#define ZD_iPhone_45                     (MIN(ZD_ScreenWidth, ZD_ScreenHeight) == 320)
#define ZD_iPhone_X                      (MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 812 || MAX(ZD_ScreenWidth, ZD_ScreenHeight) == 818)
#define ZD_Unit_Date_YMD                 (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
#define ZD_Unit_Date_HMS                 (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
#define ZD_Unit_Date_YMDHMS              (ZD_Unit_Date_YMD | ZD_Unit_Date_HMS)
#define ZD_StatusBar_H                   ZD_Application.statusBarFrame.size.height
#define ZD_NavBar_H                      44
#define ZD_TabBar_H                      49
#define ZD_TopBar_H                      (ZD_StatusBar_H + ZD_NavBar_H)
#define ZD_SAFE_TOP                      44
#define ZD_SAFE_BOTTOM                   34
#define ZD_SAFE_BOTTOM_LAYOUT            (ZD_iPhone_X ? -(ZD_SAFE_BOTTOM) : 0)
#define ZD_SAFE_BOTTOM_LAYOUT_TABBAR     (ZD_iPhone_X ? -(ZD_SAFE_BOTTOM+ZD_TabBar_H) : -ZD_TabBar_H)
#define ZD_BootomBtnConstant             ZD_SAFE_BOTTOM_LAYOUT - 30

//#pragma mark - /* Log **/
//#if ZDRelease
//    #define ZD_StartTime
//    #define ZD_StopTime
//    #define ZD_EndTime(format, ...)
//    #define ZDLog(format,...)
//    #define ZDLogM(format, ...)
//    #define ZDLogL(format, ...)
//    #define ZDLogP(format, ...)
//    #define ZDLogLife()
//    #define ZDLogLifeLoad()
//    #define ZDLogLifeDealloc()
//    #define ZDLogSuc(format, ...)
//    #define ZDLogErr(format, ...)
//
//#else
//#define NSLog(format,...)\
//printf("%s:%.4lf:%s[%04d]%s\n", [[[NSDate date] dateByAddingTimeInterval:[NSTimeZone systemTimeZone].secondsFromGMT].description stringByReplacingOccurrencesOfString:@" +0000" withString:@""].UTF8String, [[NSDate date] timeIntervalSinceReferenceDate] - floor([[NSDate date] timeIntervalSinceReferenceDate]), __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
//#define ZD_StartTime \
//CFAbsoluteTime ZD_StartTime = CFAbsoluteTimeGetCurrent();\
//ZDLog(@"⏳开始........");
//#define ZD_StopTime \
//CFAbsoluteTime ZD_StopTime  = CFAbsoluteTimeGetCurrent();\
//ZDLog(@"⌛️结束，用时:%f", ZD_StopTime - ZD_StartTime);
//#define ZD_EndTime(format, ...) \
//CFAbsoluteTime ZD_StopTime  = CFAbsoluteTimeGetCurrent();\
//ZDLog(@"⌛️结束，用时:%f..." format, ZD_StopTime - ZD_StartTime, ##__VA_ARGS__);

//#define ZDLog(format,...) \
//DDLogVerbose(@"Meari___:" format,  ##__VA_ARGS__);
//#define ZDLogM(format, ...) \
//DDLogVerbose(@"Meari________________:" format, ##__VA_ARGS__);
//#define ZDLogL(format, ...) \
//DDLogVerbose(@"Meari________________________________:" format, ##__VA_ARGS__);
//#define ZDLogP(format, ...) \
//DDLogVerbose(@"Meari--------人--" format, ##__VA_ARGS__);
//#define ZDLogLifeLoad() \
//DDLogVerbose(@"AppLife:👶🏻👶🏻👶🏻---%@", self);
//#define ZDLogLifeDealloc() \
//DDLogVerbose(@"AppLife:💀💀💀---%@", self);
//#define ZDLogSuc(format, ...)\
//DDLogVerbose(@"Meari-------✅✅:" format, ##__VA_ARGS__);
//#define ZDLogErr(format, ...)\
//DDLogVerbose(@"Meari-------❌❌:" format, ##__VA_ARGS__);

//#endif







#pragma mark - /* Code block */
//=
#define ZDEqual_WhenNonNil(variable, argument) if(argument != nil) {variable = argument;}

//block
#define ZDDo_Block_Safe(block, ...)\
if (block) {\
block(__VA_ARGS__);\
}
#define ZDDo_Block_Safe1(block, arg1)  ZDDo_Block_Safe(block, (arg1))
#define ZDDo_Block_Safe2(block, arg1, arg2) ZDDo_Block_Safe(block, (arg1), (arg2))
#define ZDDo_Block_Safe3(block, arg1, arg2, arg3) ZDDo_Block_Safe(block, (arg1), (arg2), (arg3))
#define ZDDo_Block_Safe4(block, arg1, arg2, arg3, arg4) ZDDo_Block_Safe(block, (arg1), (arg2), (arg3), (arg4))


//block on main thread
#define ZDDo_Block_Safe_Main(block, ...)\
if (block) {\
if ([NSThread currentThread].isMainThread) {\
block(__VA_ARGS__);\
}else {\
dispatch_async(dispatch_get_main_queue(), ^{\
block(__VA_ARGS__);\
});\
}\
}
#define ZDDo_Block_Safe_Main1(block, arg1)  ZDDo_Block_Safe_Main(block, (arg1))
#define ZDDo_Block_Safe_Main2(block, arg1, arg2) ZDDo_Block_Safe_Main(block, (arg1), (arg2))
#define ZDDo_Block_Safe_Main3(block, arg1, arg2, arg3) ZDDo_Block_Safe_Main(block, (arg1), (arg2), (arg3))
#define ZDDo_Block_Safe_Main4(block, arg1, arg2, arg3, arg4) ZDDo_Block_Safe_Main(block, (arg1), (arg2), (arg3), (arg4))


//Singleton
#define ZD_Singleton_Interface(name) +(instancetype)shared##name;
#define ZD_Singleton_Implementation(name)\
+ (instancetype)shared##name {\
static id instance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[self alloc] init];\
});\
return instance;\
}

//Coder
#define ZD_CoderAndCopy \
- (void)encodeWithCoder:(NSCoder *)aCoder {\
unsigned int count = 0;\
Ivar *list = class_copyIvarList([self class], &count);\
for (int i = 0; i < count; i++) {\
Ivar iv = list[i];\
const char *name = ivar_getName(iv);\
if (strlen(name) > 0) {\
NSString *key = [NSString stringWithUTF8String:name];\
[aCoder encodeObject:[self valueForKey:key] forKey:key];\
}\
}\
free(list);\
}\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
self = [super init];\
if (self) {\
unsigned int count = 0;\
Ivar *list = class_copyIvarList([self class], &count);\
for (int i = 0; i < count; i++) {\
Ivar iv = list[i];\
const char *name = ivar_getName(iv);\
if (strlen(name) > 0) {\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [aDecoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
}\
free(list);\
}\
return self;\
}\
- (instancetype)copyWithZone:(NSZone *)zone {\
id copy = [[[self class] alloc] init];\
unsigned int count = 0;\
Ivar *list = class_copyIvarList([self class], &count);\
for (int i = 0; i < count; i++) {\
Ivar iv = list[i];\
const char *name = ivar_getName(iv);\
if (strlen(name) > 0) {\
NSString *key = [NSString stringWithUTF8String:name];\
id v = [self valueForKey:key];\
[copy setValue:v forKey:key];\
}\
}\
free(list);\
return copy;\
}

//Getter
#define ZDGetter_MutableArray(name)\
- (NSMutableArray *)name {\
if (!_##name) {\
_##name = [NSMutableArray arrayWithCapacity:0];\
}\
return _##name;\
}
#define ZDGetter_MutableDictionary(name)\
- (NSMutableDictionary *)name {\
if (!_##name) {\
_##name = [NSMutableDictionary dictionary];\
}\
return _##name;\
}

//runtime
#define ZD_ExchangeClassImp(sel1,sel2) \
method_exchangeImplementations(class_getClassMethod(self, sel1), class_getClassMethod(self, sel2));
#define ZD_ExchangeInstanceImp(sel1,sel2) \
method_exchangeImplementations(class_getInstanceMethod(self, sel1), class_getInstanceMethod(self, sel2));


#endif /* ZDMacro_h */
