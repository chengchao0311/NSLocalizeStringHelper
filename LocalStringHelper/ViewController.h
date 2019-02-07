//
//  ViewController.h
//  LocalStringHelper
//
//  Created by 陈 鑫琦 on 2019/2/5.
//  Copyright © 2019 cxq. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController<NSControlTextEditingDelegate>

@property (weak) IBOutlet NSTextField *keyFeild;
@property (weak) IBOutlet NSTextField *valueField;
@property (weak) IBOutlet NSTextField *resultField;
@property(nonatomic, strong) NSArray * fileArray;

@end

