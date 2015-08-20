//
//  ViewController.m
//  iosThread
//
//  Created by 王晓鹏 on 15/8/11.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize queue = _queue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 顺序随机
- (IBAction)NSInvocationOperationClicked:(id)sender {
    
    for (int i = 0; i < 5; i++) {
            NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doInBackgroud:) object:@(i)];
        
        [_queue addOperation:op1];
    }

}
- (void)doInBackgroud:(id)obj
{
    NSLog(@"下NSInvocationOperation %@  i = %@", [NSThread currentThread], obj);
    
    //不能更新UI 在工作线程
    //self._info.text = @"doInBackgroud";
    
    
    //使用main queue更新UI线程
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:[NSString stringWithFormat:@"doInBackgroud %@  done...", obj] waitUntilDone:YES];
}
- (void)updateUI:(id)obj
{
    self._info.text = obj;
}


//顺序随机
- (IBAction)NSBlockOperationClicked:(id)sender {
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op1", [NSThread currentThread]);
        
        //更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self._info.text = @"op1 done";
        }];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op2", [NSThread currentThread]);
    }];
    
    //总是第一个执行
    [op2 setQueuePriority:NSOperationQueuePriorityHigh];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op3", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op4", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op5", [NSThread currentThread]);
    }];
    
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    [_queue addOperation:op3];
    [_queue addOperation:op4];
    [_queue addOperation:op5];
    
    //简单写法
    [self.queue addOperationWithBlock:^{
         NSLog(@"下NSInvocationOperation %@  op name: op6", [NSThread currentThread]);
    }];
}

//顺序执行－－－－串行， 3,4,5都在一个线程里
- (IBAction)AddDependencyClicked:(id)sender {
    
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op1", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op2", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op3", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op4", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op5", [NSThread currentThread]);
    }];
    
    [op5 addDependency:op4];
    [op4 addDependency:op3];
    [op3 addDependency:op2];
    //[op2 addDependency:op1];
    
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    [_queue addOperation:op3];
    [_queue addOperation:op4];
    [_queue addOperation:op5];
}

// 顺序执行－－－－串行
- (IBAction)maxConcurrentOperationCountClicked:(id)sender {
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op1", [NSThread currentThread]);
        
        //更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self._info.text = @"op1 done";
        }];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op2", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op3", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op4", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下NSInvocationOperation %@  op name: op5", [NSThread currentThread]);
    }];
    
    _queue.maxConcurrentOperationCount = 1;
    
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    [_queue addOperation:op3];
    [_queue addOperation:op4];
    [_queue addOperation:op5];
}


@end
