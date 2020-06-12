//
//  ViewController.m
//  block复习
//
//  Copyright © 2020 LSZ. All rights reserved.
//

#import "ViewController.h"
typedef void (^block_t) (void);
typedef void(^block_t2)(ViewController*);
@interface ViewController ()
@property(nonatomic,copy) block_t block;
@property(nonatomic,copy) block_t2 block2;
@property(nonatomic,copy) NSString* name;
@end

@implementation ViewController
+(id)shareInstance
{
    static ViewController* vc = nil;
    dispatch_once_t once = 0l;
    dispatch_once(&once, ^{
       if(vc == nil)
           vc = [[ViewController alloc] init];
    });
    return vc;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testblock1];
    [self testBlock2];
    [self testBlock3];
    [self testBlock4];
    [self testBlock5];
    [self testblock9];
    
    self.testblock9;
    self.select.find(@"小明");
    
    [self myfactWithBlock:^(NSString *name) {
        NSLog(@"事实是%@",name);
    }];
    
    
    
}
int  Sum (int a,int b)
{
    return a+b;
}
-(void)testblock1
{
    int  (* test) (int a, int b);
    test = Sum;
    int k = Sum(10, 11);
    int l = (*test)(10,20);
    
    NSLog(@"%d\n,%d\n",k,l);
    
}
-(void)testBlock2
{
    void (^testBlock)(void) = ^{
        NSLog(@"this is first block");
    };
    testBlock();
    NSLog(@"%@",testBlock);
}
-(void)testBlock3
{
    block_t block;
    block = ^{
        
    };
    
    NSLog(@"%@",block);
}
-(void)testBlock4
{
    int a = 10;//捕获外部变量
    void (^testBlock)(void) = ^{
        NSLog(@"this is first block");
        NSLog(@"%d",a);//引用了外部变量
    };
    testBlock();
    NSLog(@"%@",testBlock);
}
-(void)testBlock5
{
    int a = 10;
    NSLog(@"%@",^{
        NSLog(@"%d",a);
    });
}
-(void)testblock6
{
    __weak typeof(self) weakSelf = self;
    self.name = @"niubihhong";
    self.block = ^{
        NSLog(@"%@",weakSelf.name);
    };
}
#pragma mark - li
-(void)testblock7
{
//    __weak typeof(self) weakSelf = self;
    self.name = @"niubihhong";
    __block ViewController* vc = self;
    self.block = ^{
        NSLog(@"%@",vc.name);
    };
    self.block();
}
-(void)testblock8
{
    self.name = @"niubihhong";
    self.block2 = ^(ViewController* vc){
        NSLog(@"%@",vc.name);
    };
    self.block2(self);
}
-(void)testblock9
{
    __block int a = 10;
    NSLog(@"前--- %p",&a);
    
    void (^block)(void) = ^{
        a++;
        NSLog(@"a=%d\n",a);
        NSLog(@"中--- %p",&a);
    };
    block();
    NSLog(@"后--- %p",&a);
}
-(ViewController*)select
{
    NSLog(@"%s",__func__);
    return self;
}
-(void (^)(NSString*))find
{
    void (^block)(NSString*) = ^(NSString* name){
        NSLog(@"%@",name);
    };
    NSLog(@"%s",__func__);
    return block;
}

-(void)myfactWithBlock:(void(^)(NSString* name))fact
{
    if(fact){
        fact(@"发财了");
    }
}
@end
