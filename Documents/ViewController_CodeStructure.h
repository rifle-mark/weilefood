//
//  ViewController.h
//  LawyerCenter
//
//  Created by kelei on 15/6/19.
//  Copyright (c) 2015年 kelei. All rights reserved.
//


/**
 *  对外公共的接口必须要有注释，并且是标准的Document注释格式
 */


#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

/**
 *  方法说明
 */
- (void)handle;

@end

@interface ViewController : UIViewController

/**
 *  delegate使用weak声明，并且在类型上必须至少指定一个protocol类型
 */
@property (nonatomic, weak) id<ViewControllerDelegate> delegate;

/**
 *  NSString属性使用copy
 */
@property (nonatomic, copy) NSString *str;

/**
 *  整型使用NSInteger、NSUInteger
 */
@property (nonatomic, assign) NSInteger index;

/**
 *  方法说明
 *
 *  @param str str参数说明
 *
 *  @return 返回值说明
 */
- (NSData *)getDataWithStr:(NSString *)str;

@end

