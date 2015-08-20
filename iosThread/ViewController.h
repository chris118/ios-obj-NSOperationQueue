//
//  ViewController.h
//  iosThread
//
//  Created by 王晓鹏 on 15/8/11.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong, nonatomic)NSOperationQueue *queue;

- (IBAction)NSInvocationOperationClicked:(id)sender;

- (IBAction)NSBlockOperationClicked:(id)sender;

- (IBAction)AddDependencyClicked:(id)sender;

- (IBAction)maxConcurrentOperationCountClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *_info;
@end

