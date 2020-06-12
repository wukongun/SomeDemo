//
//  ViewController.h
//  block复习
//
//  Copyright © 2020 LSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (copy,nonatomic) NSString* str;


-(void)myfactWithBlock:(void(^)(NSString* name))fact;

@end

